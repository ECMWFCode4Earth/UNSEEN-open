UNSEEN data mining
================
Timo Kelder
April 1, 2020

SEAS5 data
----------

We will be using the SEAS5 hindcast, which is a dataset running from 1981-2016. The hindcast is initialized every month with 25 ensemble members and the forecast run for 7 months. February is hence forecasted by 7 initialization months (August-February). We discard the first month of the forecast because of dependence between the forecasts, explained in the [evaluation section](Evaluation.md) and are left with 6 initialization month and 25 ensemble members forecasting february precipitation each year, totalling to an increase of 150 times the observed length.

In the previous study, I did not have to download the SEAS5 data, they were readily available on the Norwegian Meteorological Institute server I was working on. Here, we will create a workflow to download the data from CDS. As starting point we can use and build on the exporter created for the [ml-drought project of the Summer of Weather code 2019](https://github.com/esowc/ml_drought).

-   These sections are still very short and will be updated (they are described in more detail in another Github and I am not sure yet when we will make that open / how much I need to repeat)
-
