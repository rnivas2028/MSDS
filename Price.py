# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:19:33 2023

@author: RSingh MSDS CUNY 2023
"""
import yfinance as yf
import DataAccess as da
import pandas as pd
import warnings
warnings.filterwarnings("ignore")
    
def download(ticker, start_date, end_date):
     df = yf.download(ticker, start=start_date, end=end_date)
     df["Date"] = df.index
     df.rename(columns = {'Adj Close':'Adj_Close'}, inplace = True)
     df = df[["Date", "Open", "High","Low", "Close", "Adj_Close", "Volume"]]
     df.reset_index(drop=True, inplace=True)
     df['day'] = df['Date'].dt.day_name()
     df['Ticker'] = ticker
     return df

def read_csv(ticker):
     df = pd.read_csv(ticker+'_1.csv')
     df.rename(columns = {'Adj Close':'Adj_Close'}, inplace = True)
     df = df[["Date", "Open", "High","Low", "Close", "Adj_Close", "Volume"]]
     df['Date'] =pd.to_datetime(df['Date'])
     df['day'] =  pd.to_datetime(df['Date']).dt.day_name()
     df['Ticker'] = ticker
     return df
 
def get_price(ticker, start_date, end_date):
     df = da.select_price(ticker, start_date, end_date)
     return df
 
def load_price(tickers, start_date, end_date):
    for ticker in tickers:
     da.delete_price(ticker);
     df_price=download(ticker, start_date, end_date)
     da.save_price(df_price)
     print('save_price: ',ticker)
     
def load_price_from_csv(ticker):
    da.delete_price(ticker);
    df_price=read_csv(ticker)
    da.save_price(df_price)
    print('save_price: ',ticker)    
