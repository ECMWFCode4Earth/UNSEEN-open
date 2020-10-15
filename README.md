# UNSEEN-open

**An open, reproducible and transferable workflow to assess and anticipate climate extremes beyond the observed record**

UNSEEN-open is an open source project using the *global* SEAS5 and ERA5 datasets. It makes *evaluation of model simulations* and *extreme value analysis* easy in order to anticipate climate extremes beyond the observed record. The project is developed as part of the ECMWF summer of weather code 2020 ([esowc](https://esowc.ecmwf.int/)), which is funded by [Copernicus](https://climate.copernicus.eu/).

Timo Kelder\*

Advisors: Julia Wagemann, Louise Slater, Rob Wilby, Tim Marjoribanks, Christel Prudhomme

Email\*: [t.kelder@lboro.ac.uk](mailto:t.kelder@lboro.ac.uk) GitHub\*: [https://github.com/timokelder](https://github.com/timokelder)

## Documentation
Learn more about UNSEEN-open on our readthedocs website: https://unseen-open.readthedocs.io

## What is UNSEEN?
The UNprecedented Simulated Extreme ENsemble (UNSEEN, [Thompson et al., 2017](https://www.nature.com/articles/s41467-017-00275-3)) approach is an increasingly popular method that exploits seasonal prediction systems to  **assess and anticipate climate extremes beyond the observed record**. The approach uses pooled forecasts as plausible alternate realities. Instead of the &#39;single realization&#39; of reality, pooled forecasts can be exploited to better assess the likelihood of infrequent events, which only have a limited chance of occurring in observed records. This method has for example been used to improve design levels of storm-surges in the river Rhine and to anticipate and understand heatwaves in China.

UNSEEN requires big data crunching and accessing the forecasting systems might be complicated for unfamiliar users. To make this approach more accessible, we build an open, reproducible and transferable workflow for the UNSEEN method using the open access Copernicus SEAS5 dataset. Recently, we applied this method to SEAS5 with promising results for extreme precipitation over Norway and Svalbard (accepted by [_NPJ_ _Climate and Atmospheric Science_](https://doi.org/10.31223/osf.io/hyxeq)). 

<!-- 
## The Workflow
In this project, we will 1. [download and preprocess the data](Data_mining.md) 2. [evaluate the extremes](Evaluation.md) and 3. illustrate applications.

Or jump straight into the [workflow for February 2020 precipitation](https://nbviewer.jupyter.org/github/esowc/UNSEEN-open/tree/master/Notebooks/Workflow.ipynb).

## Todo / questions

1. Download
- [x] Set up CDS
- [x] Retrieve SEAS5 and EOBS
- [x] Preprocess SEAS5 and EOBS
- [x] Mask: Extract country-averaged precipitation
- [ ] Package: Automated download and preprocess

2. Evaluate
- [x] Ensemble member independence
- [x] Model stability
- [x] Model fidelity
- [ ] Write R package
    - [ ] Separate Repo?

### Potential research topics
- [ ] Test robustness of the method to variable / regions / seasons
    - [ ] Redo analysis for The Siberian heatwave (Jan - May, 65-120E, 50-70N)
    - [ ] Redo UK analysis for the river Rhine (or The Netherlands) using winter total precipitation (or seasonal max daily) instead of February precipitation
- [ ] Provide example on the CDS toolbox
- [ ] Spatial, grid-based analysis instead of area averaged time-series
- [ ] EOBS UK 2020 is not the highest. How does EOBS compare to MetOffice data?

### Issues
- [ ] EOBS from CDS temporally unavailable
 -->
 
 
