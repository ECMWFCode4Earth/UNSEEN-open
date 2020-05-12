UNSEEN data mining
================
Timo Kelder
April 1, 2020

SEAS5 data
----------

We will be using the SEAS5 hindcast, which is a dataset running from 1981-2016. The hindcast is initialized every month with 25 ensemble members and the forecast run for 7 months. February is hence forecasted by 7 initialization months (August-February). We discard the first month of the forecast because of dependence between the forecasts, explained in the [evaluation section](Evaluation.md) and are left with 6 initialization month and 25 ensemble members forecasting february precipitation each year, totalling to an increase of 150 times the observed length.

We will create a workflow to download the data from CDS, see the initial analysis [here](https://nbviewer.jupyter.org/github/esowc/UNSEEN-open/blob/master/Initial_data_download.ipynb).
