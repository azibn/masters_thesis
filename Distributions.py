import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
pd.set_option('display.max_rows',None)
df = pd.read_excel(r'/Users/azib/Documents/MSc_Thesis/SB9 Catalogue.xls',sheet_name=1)

"""Distribution for eccentricity"""

period_test = df[df['period'] > 100].index
df.drop(period_test,inplace=True)
period_log = np.log(df['period'])
df.insert(3,"log_period", period_log)
df.plot('log_period','eccentricity','hist', bins=500,figsize=(15,10),title='Eccentricity Distribtution')
plt.show()

"""Distributions for Radial Velocity equation parameters"""

import seaborn as sns

fig,ax = plt.subplots(2,2, figsize=(10,15))
sns.distplot(df['semi_amplitude_1'],bins=10,ax=ax[0,0])
sns.distplot(df['system_velocity'],bins = 10,ax=ax[0,1])
sns.distplot(df['period'],bins = 10,ax=ax[1,0])
sns.distplot(df['omega'],bins = 10,ax=ax[1,1])
K1 = pd.Series.to_numpy(df['semi_amplitude_1'])
P = pd.Series.to_numpy(df['period'])

"""Semi amplitude vs Period"""

plt.figure(figsize=(20,10))
plt.scatter(K1,P)
plt.xlabel('Semi Amplitude',fontsize=16)
plt.ylabel('Period',fontsize=16)
plt.axhline(y=20,color='r')
plt.axvline(x=40,color='r')



