# UNSEEN-open
 Open, transferable and reproducible workflow for the UNSEEN method

# What is UNSEEN?
The UNprecedented Simulated Extreme ENsemble (UNSEEN, [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3)) approach is an upcoming method that exploits seasonal predictions systems to assess and anticipate climate extremes beyond the observed record. The approach uses forecast as plausible virtual realities that could have happened in the real world. Instead of the `single realization' of reality, forecasts can be exploited to better assess infrequent events, that would not be sampled enough in the limited timeseries we have from observed records. This method has for example been used to improve design levels of storm-surges in the river Rhine and to anticipate and understand heatwaves in China. 



   
A big limitation of this method is the big data crunching it requires, and the non-open access systems that have been used. Recently, we applied this method to SEAS5 for the first time, with promising results for extreme precipitation over Norway and Svalbard. SEAS5 is a good dataset for this application, as it is freely available, and has a high resolution and large ensemble compared to global climate models. In that work, the entire hindcast dataset was downloaded by the Norwegian meteorological Institute, and the data processing was performed on their server. However, to make this approach more accessible, we propose to make an open, reproducible and transferable workflow for the UNSEEN method using the open access SEAS5 dataset on the CDS. 

