# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 23:19:33 2023

@author: RSingh MSDS CUNY 2023
"""
import datetime
import Movement as movement
############ run ###############

portfolio = {
    "SPY":"VIXCLS",
    "NDX":"VXNCLS",
    "DJI":"VXDCLS",
    "RUT":"RVXCLS",
    "GLD":"GVZCLS",
    "EWZ":"VXEWZCLS"
}

movement.get_movements(portfolio)

"""
    "SPY":"VIXCLS",
    "NDX":"VXNCLS",
    "DJI":"VXDCLS",
    "RUT":"RVXCLS",
    "GLD":"GVZCLS",
    "EWZ":"VXEWZCLS"
"""