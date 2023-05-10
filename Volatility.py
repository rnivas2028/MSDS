# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:19:33 2023

@author: RSingh MSDS CUNY 2023
"""
import DataAccess as da
import pandas_datareader.data as web
import warnings
warnings.filterwarnings("ignore")
    
def download(vol_inx, start_date, end_date):  
 vix = web.DataReader(vol_inx, "fred", start_date, end_date)
 vix["Date"] = vix.index
 vix = vix[["Date", vol_inx]]
 vix["volatility"] = vol_inx
 vix["value"] = vix[vol_inx]
 vix["value"]=vix["value"].fillna(0)
 vix = vix.drop(vol_inx, axis=1)
 vix.reset_index(drop=True, inplace=True)
 print(vix.tail)
 return vix

############ run ###############
def load_volatility(vol_indexs, start_date, end_date):
    for vol_inx in vol_indexs:
     da.delete_volatility(vol_inx)
     df_vol=download(vol_inx, start_date, end_date)
     print(df_vol.head())
     da.save_volatility(df_vol)
     print('save_volatility: ',vol_inx)
###

def get_volatility(volatility_indx, start_date, end_date):
     df = da.select_volatility(volatility_indx, start_date, end_date)
     return df

