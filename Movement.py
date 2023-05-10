# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:19:33 2023

@author: RSingh MSDS CUNY 2023
"""
import datetime
import pandas as pd
import Price as price
import DataAccess as da
import Volatility as volatility
import math
import warnings
warnings.filterwarnings("ignore")

def get_dt_range(start_date, stop_date):
    date_df=pd.date_range(start_date, stop_date)
    df = pd.DataFrame(date_df)
    return df

def get_weekly_price(ticker, vol_index, df, df_date, df_vix):
    adj_price_df = pd.DataFrame(columns=['Date', 'Open', 'Close', 'Range', 'Absolute', 'Volatility'])    
    for row in df_date.iterrows():
        try:
            str_date=str(row[1])[4:14]
            split = str_date.split('-')         
            t_date    = datetime.date(int(split[0]),int(split[1]),int(split[2]))
            t_weekday = t_date.weekday()  
            open_price='';
            close_price=''
            if(t_weekday==0 and (df.loc[df[7] == str_date]).shape[0] !=0):  
                t_price=(df.loc[df[7] == str_date])
                t_vix=(df_vix.loc[df_vix[0] == str_date])
                if (t_price.size!=0): # Monday
                    # Here do nothing
                     open_price = t_price[1]
                     vix_price = t_vix[2]
                     try:
                      open_price=open_price.values.item(-1)
                     except:
                      open_price='0.0'              
                     try:
                      vix_price=vix_price.values.item(-1)
                     except:
                      vix_price='0.0'            
                     # Friday   - if Friday 0 than dont add
                     strptime_date = datetime.datetime.strptime(str_date, "%Y-%m-%d")+ datetime.timedelta(days=4)
                     strptime_date = str(pd.to_datetime(strptime_date).date())
                     try:
                      t_price_close=(df.loc[df[7] == strptime_date])
                      close_price = t_price_close[5]
                      close_price=close_price.values.item(-1)
                     except:
                      close_price='0.0'
                open_price = str(open_price)    
                close_price = str(close_price)
                if (len(open_price)>0 and open_price != '0.0' 
                    and len(close_price)>0 and close_price != '0.0'
                    and len(str(vix_price))>0 and str(vix_price) != '0.0'):
                 range=float(open_price)-float(close_price) 
                 adj_price_df = adj_price_df.append({'Date': str_date, 
                                                     'Open': open_price, 
                                                     'Close': close_price, 
                                                     'Range': range, 
                                                     'Absolute': abs(range), 
                                                     'Volatility':vix_price}, 
                                                      ignore_index=True)
        except:
         x=0 # unused 
    return adj_price_df

def get_movements_by_vol_index(df, reference_id, ticker,volatility_index):
    movements_by_vix_df = pd.DataFrame(columns=['Reference_id',	'Ticker','Volatility_index',
                                                'Date', 'Open', 'Close', 'Range', 'Absolute', 'Volatility',
                                                'Actual_Range', 'Movement_Predicted_By_Volatility_PCT', 
                                                'Weekly_Close_Price_Predicted_By_Volatility_Upper', 
                                                'Weekly_Close_Price_Predicted_By_Volatility_Lower', 
                                                'Predicted_Movement_By_Volatility', 'Actual_Movement'])  
    for i in range(0, len(df)):
     date=df.iloc[i]['Date']
     open_price=df.iloc[i]['Open']
     close_price=df.iloc[i]['Close']
     val_range=df.iloc[i]['Range']
     actual_range=df.iloc[i]['Absolute']
     vix=df.iloc[i]['Volatility']
     # Movement Predicted by VIX
     pct_mt_predicted=math.sqrt(5/365)*(float(vix))
     # Weekly Close Price Predicted by VIX 
     weekly_price_predicted_r1=float(open_price)*(1+float(pct_mt_predicted)/100)
     weekly_price_predicted_r2=float(close_price)*(1-float(pct_mt_predicted)/100)
     movement_predicted=float(open_price)*(float(pct_mt_predicted)/100)
     actual_movement=float(open_price)-float(close_price)
     try:
      movements_by_vix_df = movements_by_vix_df.append({'Reference_id':reference_id,	
                                                        'Ticker':ticker,
                                                        'Volatility_index':volatility_index,
                                                        'Date': date,
                                                        'Open': open_price,
                                                        'Close': close_price,
                                                        'Range': val_range,
                                                        'Volatility': vix,
                                                        'Actual_Range': actual_range, 
                                                        'Movement_Predicted_By_Volatility_PCT': pct_mt_predicted, 
                                                        'Weekly_Close_Price_Predicted_By_Volatility_Upper': weekly_price_predicted_r1,
                                                        'Weekly_Close_Price_Predicted_By_Volatility_Lower': weekly_price_predicted_r2,
                                                        'Predicted_Movement_By_Volatility': movement_predicted, 
                                                        'Actual_Movement': actual_movement}, 
                                       ignore_index=True)
     except:
      print('error')   
    return movements_by_vix_df
def conclusions(df):
    movements=0
    for i in range(0, len(df)):
     movement_predicted=df.iloc[i]['Predicted_Movement_By_Volatility']
     actual_movement=df.iloc[i]['Actual_Movement']
     total_movements=len(df)
     #print(movement_predicted,actual_movement) 
     if actual_movement>movement_predicted :
      movements=movements+1
    movement_in_range =  movements/total_movements*100
    return movement_in_range

def quantify_market_analytics(market_analytics_id, portfolio, start_date, stop_date):
    df_date_range=get_dt_range(start_date, stop_date)
    for keys, values in portfolio.items():
        ticker=keys
        vol_index=values
        print(ticker,vol_index, start_date,stop_date )
        df_price=price.get_price(ticker, start_date, stop_date)
        if df_price.empty:
         return
        df_vol=volatility.get_volatility(vol_index, start_date, stop_date)
        df_weekly_price=get_weekly_price(ticker,vol_index,df_price,df_date_range,df_vol)
        df=get_movements_by_vol_index(df_weekly_price, market_analytics_id, ticker, vol_index)
        #da.save_market_analytics(df)
        if(df.shape[0] !=0):
           # da.save_market_analytics(df)
            movement=conclusions(df)
            print(round(movement,2) )
            #reference_id,ticker,volatility_index,start_date, stop_date, movement_pct
            try:
             # delets previous movements
             da.delete_movement(market_analytics_id,ticker,vol_index)
            except:
             result =0 
            try:
             # save new movement
             da.save_movement(market_analytics_id,ticker,vol_index,start_date, stop_date, movement)
            except:
             result =0 
        else:
            print('--')
        print('------------------')
"""
30	0-3 Year	0-3 Year Market Analytics
31	0-6 Year	0-6 Year Market Analytics
32	0-9 Year	0-9 Year Market Analytics
33	0-12 Year	0-12 Year Market Analytics
34	0-15 Year	0-15 Year Market Analytics
35	0-18 Year	0-18 Year Market Analytics
50	0-5 Year	0-5 Year Market Analytics
51	0-10 Year	0-10 Year Market Analytics
52	0-15 Year	0-15 Year Market Analytics
53	0-20 Year	0-20 Year Market Analytics
300	0-3 Year	0-3 Year Market Analytics
301	3-6 Year	3-6 Year Market Analytics
302	6-9 Year	6-9 Year Market Analytics
303	9-12 Year	9-12 Year Market Analytics
304	12-15 Year	12-15 Year Market Analytics
305	15-18 Year	15-18 Year Market Analytics
500	0-5 Year	0-5 Year Market Analytics
501	5-10  Year	5-10  Year Market Analytics
502	10-15 Year	10-15 Year Market Analytics
503	15-20 Year	15-20 Year Market Analytics
"""

def get_market_analytics_by_range(portfolio):
    today = datetime.date.today()
    start_date = datetime.datetime(today.year-20, today.month, today.day+1) 
    #30	0-3 Year	0-3 Year Market Analytics
    stop_date = datetime.datetime(today.year-17, today.month, today.day)
    quantify_market_analytics(30, portfolio, start_date, stop_date)

    #31	0-6 Year	0-6 Year Market Analytics
    stop_date = datetime.datetime(today.year-14, today.month, today.day)
    quantify_market_analytics(31, portfolio, start_date, stop_date)
    #32	0-9 Year	0-9 Year Market Analytics
    stop_date = datetime.datetime(today.year-11, today.month, today.day)
    quantify_market_analytics(32, portfolio, start_date, stop_date)
    #33	0-12 Year	0-12 Year Market Analytics
    stop_date = datetime.datetime(today.year-8, today.month, today.day)
    quantify_market_analytics(33, portfolio, start_date, stop_date)
    #34	0-15 Year	0-15 Year Market Analytics
    stop_date = datetime.datetime(today.year-5, today.month, today.day)
    quantify_market_analytics(34, portfolio, start_date, stop_date)    
    #35	0-18 Year	0-18 Year Market Analytics
    stop_date = datetime.datetime(today.year-2, today.month, today.day)
    quantify_market_analytics(35, portfolio, start_date, stop_date)    
    #50	0-5 Year	0-5 Year Market Analytics
    stop_date = datetime.datetime(today.year-15, today.month, today.day)
    quantify_market_analytics(50, portfolio, start_date, stop_date)
    #51	0-10 Year	0-10 Year Market Analytics
    stop_date = datetime.datetime(today.year-10, today.month, today.day)
    quantify_market_analytics(51, portfolio, start_date, stop_date)
    #52	0-15 Year	0-15 Year Market Analytics
    stop_date = datetime.datetime(today.year-5, today.month, today.day)
    quantify_market_analytics(52, portfolio, start_date, stop_date)
    #53	0-20 Year	0-20 Year Market Analytics
    stop_date = datetime.datetime(today.year, today.month, today.day)
    quantify_market_analytics(53, portfolio, start_date, stop_date)
    #300	0-3 Year	0-3 Year Market Analytics
    stop_date = datetime.datetime(today.year-17, today.month, today.day)
    quantify_market_analytics(300, portfolio, start_date, stop_date)
    
    #301	3-6 Year	3-6 Year Market Analytics
    start_date = datetime.datetime(today.year-17, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-14, today.month, today.day)
    quantify_market_analytics(301, portfolio, start_date, stop_date)
    
    #302	6-9 Year	6-9 Year Market Analytics
    start_date = datetime.datetime(today.year-14, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-11, today.month, today.day)
    quantify_market_analytics(302, portfolio, start_date, stop_date)
    
    #303	9-12 Year	9-12 Year Market Analytics
    start_date = datetime.datetime(today.year-11, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-8, today.month, today.day)
    quantify_market_analytics(303, portfolio, start_date, stop_date)
    
    #304	12-15 Year	12-15 Year Market Analytics
    start_date = datetime.datetime(today.year-8, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-5, today.month, today.day)
    quantify_market_analytics(304, portfolio, start_date, stop_date)
    
    #305	15-18 Year	15-18 Year Market Analytics
    start_date = datetime.datetime(today.year-5, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-2, today.month, today.day)
    quantify_market_analytics(305, portfolio, start_date, stop_date)
    
    #500	0-5 Year	0-5 Year Market Analytics
    start_date = datetime.datetime(today.year, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-15, today.month, today.day)
    quantify_market_analytics(500, portfolio, start_date, stop_date)
    
    #501	5-10  Year	5-10  Year Market Analytics
    start_date = datetime.datetime(today.year-15, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-10, today.month, today.day)
    quantify_market_analytics(501, portfolio, start_date, stop_date)
    
    #502	10-15 Year	10-15 Year Market Analytics
    start_date = datetime.datetime(today.year-10, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-5, today.month, today.day)
    quantify_market_analytics(502, portfolio, start_date, stop_date)
    
    #503	15-20 Year	15-20 Year Market Analytics
    start_date = datetime.datetime(today.year-5, today.month, today.day+1) 
    stop_date = datetime.datetime(today.year-0, today.month, today.day)
    quantify_market_analytics(503, portfolio, start_date, stop_date)


def get_movements(portfolio):
 get_market_analytics_by_range(portfolio)
        