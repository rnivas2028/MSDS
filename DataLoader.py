# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:19:33 2023

@author: RSingh MSDS CUNY 2023
"""
import datetime
import Price as price
import Volatility as volatility

############ run ###############

today = datetime.date.today()
start_date = datetime.datetime(today.year-20, today.month, today.day+1)
stop_date = datetime.datetime(today.year, today.month, today.day)
## Tickers
tickers=["SPY","NDX","DJI","^NSEI","EWZ"]
price.load_price(tickers, start_date, stop_date)

# "RUT" will be loaded thru CSV
price.load_price_from_csv("RUT")

# "GLD" will be loaded thru CSV
price.load_price_from_csv("GLD")

## Volatility
vol_indexs=["VIXCLS","VXNCLS","VXDCLS","RVXCLS","GVZCLS","VXAPLCLS","VXEWZCLS"]
#volatility.load_volatility(vol_indexs, start_date, stop_date)




