"""
Python module with functions for retrieving cds data. 
"""
import cdsapi 
import numpy as np
import os


c = cdsapi.Client()

def get_init_months(target_month):
    target = target_month if isinstance(target_month, list) else [target_month]
    init_list = [target[0] - x for x in range(1,7 - len(target))]
    init_months = [12 + i if i < 1 else i for i in init_list]
    leadtimes = [np.arange(x, x + len(target)) for x in range(2,8 - len(target))]
    return(init_months, leadtimes)

def print_arguments(target_months):
    target_months = target_months if isinstance(target_months, list) else [target_months]
    init_months, leadtimes = get_init_months(target_months)
    for j in range(2):  ##add if error still continue
        for i in range(len(init_months)):
            init_month = init_months[i]
            leadtime_months = leadtimes[i]
            if 12 in init_months:
                if init_month < 6:
                    year = years[j] + 1
                else:
                    year = years[j]
            else:
                year = years[j]
            print('year = ' + str(year) + ' init_month = ' + str(init_month) +
                  ' leadtime_month = ' + str(leadtime_months))


def retrieve_single(variables, year, init_month, leadtimes, area, folder):
    """Retrieve SEAS5 data from CDS.
        
        Parameters
        ----------
        variable : str
        year : int
            str(year) is used in the function
        init_month : Initialization month, integer. 
            For example, if the target month is February (2), initialization months are August-January (8-12,1) forecasting February
        leadtime_month : The lead times you want, integer. 
            Use of single months is much faster. The first lead time is 1 (Leadtime 0 does not exist).
            For example, for forecasting February from initialization month 1 (January), the leadtime months is 2. 
            For initialization month 12 (december), the lead time month is 3 (February).
        folder : The path to the folder where to store the data. 

        Returns
        -------
        Saves the files in the specified folder.
    """
    c.retrieve(
        'seasonal-monthly-single-levels',
        {
            'format': 'netcdf',
            'originating_centre': 'ecmwf',
            'system': '5',
            'variable': variables,
            'product_type': ['monthly_mean'], #'monthly_maximum',, 'monthly_standard_deviation',],
            'year': str(year),  #data before 1993 is available.  
            'month': "%.2i" % init_month,
            'leadtime_month': [str(a) for a in leadtimes],
            'area': area,
        },
        folder + str(year) + "%.2i" % init_month + '.nc')
    
    
def retrieve_SEAS5(variables, target_months, area, folder, years=np.arange(1981, 2017)):
    """Retrieve SEAS5 data from CDS.
        
        Parameters
        ----------
        variables : The variables to be downloaded, str. Can also be one variable.
        target_months : The month(s) of interest, int.
            For example, for JJA, use [6,7,8]. 
            Must be consecutive (e.g. no May, July, August).
        area : The domain to download the data over, [North, West, South, East,].
            For example, to dowload longitude 30,70 and latitude -10, 120, use [70, -11, 30, 120,]
        years : Defaults to the entire hindcast years from 1981-2016
        folder : The path to the folder where to store the data. 

        Returns
        -------
        Saves the files in the specified folder.
    """
    init_months, leadtimes = get_init_months(target_months)
    for j in range(len(years)):  ##add if error still continue
        for i in range(len(init_months)):
            init_month = init_months[i]
            leadtime_months = leadtimes[i]
            if 12 in init_months:
                if init_month < 6:
                    year = years[j]
                else:
                    year = years[j] - 1
            else:
                year = years[j]

            if not os.path.isfile(folder + str(year) + "%.2i" % init_month + '.nc'):
                retrieve_single(variables=variables,
                                year=year,
                                init_month=init_month,
                                leadtimes=leadtime_months,
                                area = area,
                                folder=folder)

def retrieve_ERA5(variables,
                  folder,
                  grid = [1.0, 1.0],
                  target_months=[
                      '01',
                      '02',
                      '03',
                      '04',
                      '05',
                      '06',
                      '07',
                      '08',
                      '09',
                      '10',
                      '11',
                      '12',
                  ],
                  area=[90, -180, -90, 180],
                  years=np.arange(1979, 2021)):
    """Retrieves the full ERA5 dataset from CDS (years 1979-2020).
        
        Parameters
        ----------
        variables : The variables to be downloaded, str. Can also be one variable.
        folder : The path to the folder where to store the data. 
        grid : The grid spacing, or spatial resolution of the data. 
            Defaults to 1x1 degrees to match SEAS5.
            If a higher resolution is wanted, use [0.25, 0.25].
        target_months : The month(s) of interest.
            For example, for JJA, use [6,7,8]. 
            Defaults to all months. 
        area : The domain to download the data over, [North, West, South, East,].
            For example, to dowload longitude 30,70 and latitude -10, 120, use [70, -11, 30, 120,].
            Default is the full extent [90, -180, -90, 180].
        years : Defaults to the period 1979-2020.

        Returns
        -------
        Saves the files in the specified folder.
    """
    for j in range(len(years)):
        year = years[j]
        if not os.path.isfile(folder + 'ERA5_' + str(year) + '.nc'):
            c.retrieve(
                'reanalysis-era5-single-levels-monthly-means',
                {
                    'format': 'netcdf',
                    'product_type': 'monthly_averaged_reanalysis',
                    'variable': variables,
                    'area': area,         
                    'grid': grid,  
                    'year': str(year),
                    'month': target_months,
                    'time': '00:00',
                },
                folder + 'ERA5_' + str(year) + '.nc')