"""
Python module with functions for preprocessing cds data. 
"""
import xarray as xr
import numpy as np
from .CDSretrieve import _get_init_months

def merge_SEAS5(folder, target_months):
    init_months, leadtimes = _get_init_months(target_months)
    print('Lead time: ' + str(init_months[0]))
    SEAS5_ld1 = xr.open_mfdataset(
        folder + '*' + str(init_months[0]) + '.nc',
        combine='by_coords')  # Load the first lead time
    SEAS5 = SEAS5_ld1  # Create the xarray dataset to concatenate over
    for init_month in init_months[1:len(init_months)]:  ## Remove the first that we already have
        print(init_month)
        SEAS5_ld = xr.open_mfdataset(
            folder + '*' + "%.2i" % init_month + '.nc',
            combine='by_coords') 
    SEAS5 = SEAS5.assign_coords(leadtime = np.arange(len(init_months)) + 2) # assign leadtime coordinates
    return(SEAS5)