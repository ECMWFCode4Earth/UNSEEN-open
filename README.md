# UNSEEN-open

**An open, reproducible and transferable workflow to assess and anticipate climate extremes beyond the observed record**

Timo Kelder\*

Advisors: Louise Slater, Julia Wagemann, Rob Wilby, Tim Marjoribanks, Christel Prudhomme

Email\*: [t.kelder@lboro.ac.uk](mailto:t.kelder@lboro.ac.uk) GitHub\*: [https://github.com/timokelder](https://github.com/timokelder)

Best rendering on [GitHub Pages](https://esowc.github.io/UNSEEN-open/)

## What is UNSEEN?
The UNprecedented Simulated Extreme ENsemble (UNSEEN, [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3)) approach is an increasingly popular method that exploits seasonal prediction systems to  **assess and anticipate climate extremes beyond the observed record**. The approach uses pooled forecasts as plausible alternate realities. Instead of the &#39;single realization&#39; of reality, pooled forecasts can be exploited to better assess the likelihood of infrequent events, which only have a limited chance of occurring in observed records. This method has for example been used to improve design levels of storm-surges in the river Rhine and to anticipate and understand heatwaves in China.

A limitation of the UNSEEN method is the big data crunching it requires and the limited accessibility of some of the forecasting systems used. Recently, we applied this method to SEAS5 for the first time, with promising results for extreme precipitation over Norway and Svalbard (submitted to [_NPJ_ _Climate and Atmospheric Science_](https://doi.org/10.31223/osf.io/hyxeq)). SEAS5 is a good dataset for the UNSEEN approach because it is freely available and has a high resolution and a large ensemble compared to global climate models. To make this approach more accessible, we propose to make an open, reproducible and transferable workflow for the UNSEEN method using the open access SEAS5 dataset on the CDS.

SEAS5 is a huge dataset - for example, forecasts of just one variable (e.g. precipitation only surface level) on a daily and global scale can total to a few terabytes. The data size drastically reduces by using a spatial average monthly timeseries, and hence, we will start this project with a case study of spatial and monthly averaged precipitation. After successful application, there is room for expansion of the work.

## February 2020 case study
February 2020 was the wettest February on record in the UK (since 1862), [according to the Met Office](https://www.metoffice.gov.uk/about-us/press-office/news/weather-and-climate/2020/2020-winter-february-stats). The UK faced three official storms during February, and this exceptional phenomena attracted media attention, such as an article from the [BBC](https://www.bbc.com/news/science-environment-51713172) on increased climate concerns among the population. A [Carbon Brief post](https://www.carbonbrief.org/met-office-why-the-uk-saw-record-breaking-rainfall-in-february-2020) explained why the UK saw such record-breaking rainfall and put this rare event into perspective, citing, amongst other approaches, the UNSEEN method. The UNSEEN study by [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3) assessed monthly precipitation over the UK. They showed that the monthly precipitation records for south east England have a 7% chance of being exceeded in at least one month in any given winter. They did not use SEAS5 but the Met Office model ensemble. This work was taken up in the [National Flood Resilience Review (2016)](https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/551137/national-flood-resilience-review.pdf), showing the high relevance and applicability of the method. Here, the aim is to  **build an open, reproducible and transferable workflow** , that will be tested for this well-studied region of the world and hopefully can be transferred to other regions and climate variables of interest.

## The Workflow
In this project, we will 1. [download and preprocess the data](Data_mining.md) 2. [evaluate the extremes](Evaluation.md) and 3. illustrate applications.

Or jump straight into the [notebooks](https://nbviewer.jupyter.org/github/esowc/UNSEEN-open/tree/master/Notebooks/). 

## Todo / questions

1. Download
- [x] Create the GitHub page and share with collaborators
- [x] Download and preprocess SEAS5 data 
- [x] Download and preprocess E-OBS
- [ ] Extract country-averaged precipitation
- [ ] Make reproducible, what do we want to develop? (CDS toolbox?)

2. Evaluate
- [ ] Ensemble member independence
- [ ] Model stability
- [ ] Model fidelity
- [ ] First using UK averaged time-series of February precipitation. Then grid-based? 

