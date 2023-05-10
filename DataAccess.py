# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:36:10 2023

@author: RSingh MSDS CUNY 2023
"""

import mysql.connector
import pandas as pd
host="raags-thinsvr"
database="etss"
user="raags"
password="honda"                                               
def save_price(df_price):                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    val_to_insert = df_price.values.tolist()
    print(val_to_insert[1])
    cursor.executemany("INSERT INTO etss.price (Date, Open, High, Low, Close, Adj_Close, Volume, day, Ticker) VALUES(%s, %s, %s,%s, %s, %s,%s, %s, %s)", val_to_insert)
    connection.commit()
    connection.close()
    cursor.close()
 
def select_price(ticker, start_date, end_date):              
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    query = ("SELECT * FROM etss.price WHERE ticker=%s AND date>=%s AND date<=%s")    
    cursor.execute(query, (ticker, start_date, end_date))
    df = pd.DataFrame(cursor.fetchall())
    cursor.close()
    connection.close()
    return df

def delete_price(ticker):                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()  
    query = ("DELETE FROM etss.price WHERE ticker=%s")    
    cursor.execute(query, [ticker])    
    connection.commit()
    cursor.close()
    connection.close()
    
def save_volatility(df_volatility):                  
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    val_to_insert = df_volatility.values.tolist()
    cursor.executemany("INSERT INTO etss.volatility (Date, volatility, value) VALUES(%s, %s, %s)", val_to_insert)
    connection.commit()
    connection.close()
    cursor.close()

def select_volatility(volatility_indx, start_date, end_date):              
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    query = ("SELECT * FROM etss.volatility WHERE volatility=%s AND date>=%s AND date<=%s")    
    cursor.execute(query, (volatility_indx, start_date, end_date))
    df = pd.DataFrame(cursor.fetchall())
    cursor.close()
    connection.close()
    return df

def delete_volatility(vol_indx):                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()      
    query = ("DELETE FROM etss.volatility WHERE volatility=%s")    
    cursor.execute(query, [vol_indx])    
    connection.commit()
    connection.close()
    cursor.close() 

def save_market_analytics(df_volatility):                  
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    val_to_insert = df_volatility.values.tolist()
    cursor.executemany("INSERT INTO etss.market_analytics (reference_id,ticker,volatility_index,date,open,close,range,absolute,volatility,actual_range,movement_predicted_by_volatility_pct,weekly_close_price_predicted_by_volatility_upper,weekly_close_price_predicted_by_volatility_lower,predicted_movement_by_volatility,actual_movement) " 
                       "VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", val_to_insert)
    connection.commit()
    connection.close()
    cursor.close()

def delete_market_analytics():                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()  
    cursor.execute("DELETE FROM etss.volatility")
    connection.commit()
    connection.close()
    cursor.close()
    
def save_movement(reference_id,ticker,volatility_index,start_date, stop_date, movement_pct):                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()
    sql = "INSERT INTO etss.movement (reference_id, ticker, volatility_index, start_date, stop_date, movement_pct) VALUES(%s, %s, %s,%s, %s, %s)"
    val = (reference_id,ticker,volatility_index,start_date, stop_date, movement_pct)
    cursor.execute(sql, val)
    connection.commit()
    connection.close()
    cursor.close()

def delete_movement(reference_id, ticker, volatility_index):                 
    connection = mysql.connector.connect(host=host,database=database,user=user,password=password)
    cursor = connection.cursor()  
    query = ("DELETE FROM etss.movement WHERE reference_id =%s and ticker=%s and volatility_index=%s")    
    cursor.execute(query, [reference_id, ticker, volatility_index])    
    connection.commit()
    cursor.close()
    connection.close()
