# -*- coding: utf-8 -*-
"""
Created on Sun Oct 27 23:52:37 2019

@author: Lenovo
"""

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

YS=int(input('Enter the number of years studied by the founders:'))
title1='Bachelor field by valuation growth for '+str(YS)+' years of study'

def acquisition():
    data=pd.read_csv(r'C:\Users\Lenovo\Ironhack\Bootcamp\Projects\startup-founder-valuations-dataset\Startup_founders_valuations.csv')
    return data

def wrangling(data):
    filtered1=data[data.Years_of_Study==YS].copy()
    return filtered1

def analyze(filtered):
    result1=filtered1.groupby('Bachelor_Studies',as_index=False)['Valuation_IncreaseAB'].mean().sort_values(by='Valuation_IncreaseAB',ascending=False).head(8).round(2)
    return result1

def viz(data):
    fig,ax=plt.subplots(figsize=(15,8))
    barchart1=sns.barplot(data=result1,x='Bachelor_Studies',y='Valuation_IncreaseAB')
    plt.title(title1+'\n',fontsize=16)

    sns.set_style('darkgrid')
    plt.show()
    return barchart1

def save_viz(chart):
    fig1=barchart1.get_figure()
    fig1.savefig(r'C:\Users\Lenovo\Ironhack\Bootcamp\Projects\startup-founder-valuations-dataset/'+'script_Top Bachelor studies.png')
    
if __name__=='__main__':
    data=acquisition()
    filtered1=wrangling(data)
    result1=analyze(filtered1)
    barchart1=viz(result1)
    save_viz(barchart1)