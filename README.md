# UNSEEN-open
Open, transferable and reproducible workflow for the UNSEEN method

## What is UNSEEN?
The UNprecedented Simulated Extreme ENsemble (UNSEEN, [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3)) approach is an upcoming method that exploits seasonal prediction systems to assess and anticipate climate extremes beyond the observed record. The approach uses pooled forecasts as plausible alternate realities. Instead of the 'single realization' of reality, pooled forecasts can be exploited to better assess the likelihood of infrequent events, which only have a limited frequency of occurrence in observed records. This method has for example been used to improve design levels of storm-surges in the river Rhine and to anticipate and understand heatwaves in China. 
   
A considerable limitation of the UNSEEN method is the big data crunching it requires and the limited accessibility of some of the forecasting systems used. Recently, we applied this method to SEAS5 for the first time, with promising results for extreme precipitation over Norway and Svalbard. SEAS5 is a good dataset for the UNSEEN approach because it is freely available and has a high resolution and a large ensemble compared to global climate models. To make this approach more accessible, we propose to make an open, reproducible and transferable workflow for the UNSEEN method using the open access SEAS5 dataset on the CDS. 

## February 2020 case study
SEAS5 is a huge dataset -- for example, forecasts of just one variable (e.g. precipitation only surface level) on a daily and global scale can total to a few terabytes.  The data size drastically reduces by using a spatial average monthly timeseries, and hence, we will start this project with a case study of spatial and monthly averaged precipitation.  After successfull application, there is enough room for expansion of the work.

February 2020 was the wettest february on record in the UK (since 1862), [according to the Met Office](https://www.metoffice.gov.uk/about-us/press-office/news/weather-and-climate/2020/2020-winter-february-stats).  UK faced three official storms during february, and this exceptional phenomena has attrected  media attention, such as an article from the bbc on increased climate concerns amongst people. A great [carbon brief post](https://www.carbonbrief.org/met-office-why-the-uk-saw-record-breaking-rainfall-in-february-2020) explaining the events and putting the rare event into perspective with, amongst other, the UNSEEN method. The previous UNSEEN study [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3) has already assessed monthly precipitation over the UK and has shown that

## The Workflow
In this project, we will 1. download the data 2. process the data 3. evaluate the extremes and 4. illustrate applications.


We first redo the graph in [der Wiel et al., 2019](https://doi.org/10.1029/2019GL081967), by comparing Flood frequency curves for the Amazon based on [Statistical extrapolation of the observed or `physical empirical' estimation from model simulations](R/Amazon.md)).

This shows that there are two very large mega-floods that have occurred in 2000 years of present climate simulations, that largely deviate from the magnitude expected from observations. How have these events developed? 
