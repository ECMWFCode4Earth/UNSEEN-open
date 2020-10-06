.. unseen_open documentation master file, created by
   sphinx-quickstart on Wed Sep  9 08:49:16 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to unseen_open's documentation!
=======================================

**UNSEEN-open** is an open source project that makes retrieval of SEAS5 
and ERA5 data, evaluation of model simulations and extreme value analysis
easy in order to **anticipate climate extremes** beyond the observed record.

UNSEEN-open relies heavily on xarray_ for data preprocessing and
uses ggplot_ and extRemes_ for the extreme value analysis. The extreme
value utilities are being developed into an UNSEEN_ Rpackage. 

The project is developed as part of the ECMWF summer of weather code 2020 (esowc_),
which is funded by Copernicus_.

We believe UNSEEN-open might 1) help estimate design values, especially relevant for data scarce regions; 2) improve risk estimation of natural hazards by coupling UNSEEN to impact models; 3) detect trends in rare climate extremes, including variables other than precipitation; and 4) increase our physical understanding of the drivers of non-stationarity of climate extremes, through the possible attribution of detected trends.

We hope this approach may see many applications across a range of scientific fields!

Citation
-------

If any code or example data is used, please cite this project.

All code and example data are available under the open source `MIT License`__.

__ https://opensource.org/licenses/MIT

If any questions may arise, please don't hesitate to get in touch t.kelder@lboro.ac.uk.



.. _xarray: https://esowc.ecmwf.int/
.. _ggplot: https://climate.copernicus.eu/
.. _extRemes: https://esowc.ecmwf.int/
.. _UNSEEN: https://climate.copernicus.eu/
.. _esowc: https://esowc.ecmwf.int/
.. _Copernicus: https://climate.copernicus.eu/

.. toctree::
   :maxdepth: 2
   :caption: Introduction:
   
   Whats-unseen
   Notebooks/Workflow
   Notebooks/Examples
   
.. toctree::
   :maxdepth: 1
   :caption: The workflow:
   
   Notebooks/1.Download/1.Retrieve
   Notebooks/2.Preprocess/2.Preprocess
   Notebooks/3.Evaluate/3.Evaluate
   
.. toctree::
   :maxdepth: 1
   :caption: Extra:
   
   Notebooks/Global_monthly_temperature_records_ERA5
   Notebooks/2020_contrasting_weather
   Notebooks/2.Preprocess/2.3Upscale
   

License
-------

All code and example data are available under the open source `MIT License`__.

__ https://opensource.org/licenses/MIT