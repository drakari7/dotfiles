#!/usr/bin/env python3
import pyexec, pytradingflags, pyclicktrading
import logging, time

class ModelHandler:
    def __init__(self, product, shmem_prefix):
        self.product = product
        self.shmem_prefix = shmem_prefix
        self.clicktrading = pyclicktrading.Control(product, shmem_prefix)
        self.clicktrading_view = pyclicktrading.View(product, self, shmem_prefix)
        self.tradingflags = pytradingflags.TradingFlagsControl(product, shmem_prefix)
        self.handle = None

    def update(self):
        self.clicktrading.Update()
        self.clicktrading_view.Receive()
        self.tradingflags.Update()

    def OnClickOrder(self, order_idx, manual_order):
        if manual_order.insert.time_in_force != pyexec.order.TimeInForce.ImmediateOrCancel:
            self.handle = manual_order.handle

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--shmem_prefix', required=True)
    parser.add_argument('--product', '-p', required=True)
    parser.add_argument('--instrument_idx', '-i', required=True, action='append')
    parser.add_argument('--order', '-o', default='0')
    parser.add_argument('--qty', '-q', default='1')
    parser.add_argument('--side', '-s', default='0')
    parser.add_argument('--price', default='1.0')
    parser.add_argument('--ioc', action='store_true')
    parser.add_argument('--self_trade', action='store_true')
    parser.add_argument('--cancel', action='store_true')
    parser.add_argument('--amend_price', default='')
    parser.add_argument('--amend_qtyup', action='store_true')
    parser.add_argument('--amend_qtydown', action='store_true')
    parser.add_argument('--idle', action='store_true')
    args = parser.parse_args()
    
    print("Initializing model...")
    model = ModelHandler(args.product, args.shmem_prefix)
    model.update()

    for _ in range(50):
        model.update()
        time.sleep(0.02)

    print("Enabling trading...")
    model.tradingflags.ProductAllowTrading(pyexec.ClickTrading)
    for idx in args.instrument_idx:
        model.tradingflags.InstrumentAllowTrading(int(idx), pyexec.ClickTrading)

    for _ in range(50):
        model.update()
        time.sleep(0.02)

    for _ in range(int(args.order)):
        for idx in args.instrument_idx:
            print("Adding order... ")
            order = pyexec.order.Insert()
            order.instrument_idx = int(idx)
            order.price = float(args.price)
            order.side = pyexec.order.Side.Buy if args.side == '0' else pyexec.order.Side.Sell
            order.kind = pyexec.order.Kind.Limit
            order.time_in_force = pyexec.order.TimeInForce.GoodForDay if not args.ioc else pyexec.order.TimeInForce.ImmediateOrCancel
            order.volume = int(args.qty)
            order.portfolio_idx = 1
            order.post_only = not args.ioc
            model.clicktrading.Insert(order)

            if args.self_trade:
                for _ in range(10):
                    model.update()
                    time.sleep(0.02)

                order = pyexec.order.Insert()
                order.instrument_idx = int(idx)
                order.price = float(args.price)
                order.side = pyexec.order.Side.Sell if args.side == '0' else pyexec.order.Side.Buy
                order.kind = pyexec.order.Kind.Limit
                order.time_in_force = pyexec.order.TimeInForce.GoodForDay
                order.volume = 2 * int(args.qty)
                order.portfolio_idx = 1
                # order.post_only = False
                model.clicktrading.Insert(order)

            if args.amend_price:
                for _ in range(50):
                    model.update()
                    time.sleep(0.02)

                amend = pyexec.order.Amend()
                amend.instrument_idx = int(idx)
                amend.price = float(args.amend_price)
                amend.side = pyexec.order.Side.Buy if args.side == '0' else pyexec.order.Side.Sell
                amend.volume = int(args.qty)
                model.clicktrading.Amend(model.handle, amend)

            if args.cancel:
                for _ in range(50):
                    model.update()
                    time.sleep(0.02)

                # print("Disabling trading...")
                # model.tradingflags.ProductDenyTrading(pyexec.ClickTrading)
                # for idx in args.instrument_idx:
                #     model.tradingflags.InstrumentDenyTrading(int(idx), pyexec.ClickTrading)

                # for _ in range(50):
                #    model.update()
                #    time.sleep(0.02)

                if model.handle:
                    model.clicktrading.Cancel(model.handle)

                for _ in range(50):
                    model.update()
                    time.sleep(0.02)
            else:
                for _ in range(50):
                    model.update()
                    time.sleep(0.02)

    if args.idle:
        while True:
            model.update()
            time.sleep(0.02)
    else:
        for _ in range(50):
            model.update()
            time.sleep(0.02)
            
        print("Disabling trading...")
        model.tradingflags.ProductDenyTrading(pyexec.ClickTrading)
        for idx in args.instrument_idx:
            model.tradingflags.InstrumentDenyTrading(int(idx), pyexec.ClickTrading)

