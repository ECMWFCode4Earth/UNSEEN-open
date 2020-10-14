library(extRemes)
library(ggplot2)
library(ggpubr)

###Stationary plot
EVT_plot <- function(obs, ensemble, GEV_type, main, y_lab = "February average precipitation (mm/day)", ylim = NA) {
  ## We plot the GEV distribution for ERA5 and empirical data for SEAS5
  fit_obs <- fevd(
    x = obs, threshold = NULL, threshold.fun = ~1, location.fun = ~1,
    scale.fun = ~1, shape.fun = ~1, use.phi = FALSE,
    type = GEV_type, method = "MLE", initial = NULL, # type= c("GEV", "GP", "PP", "Gumbel", "Exponential"), method= c("MLE", "GMLE", "Bayesian", "Lmoments")
    span = NULL, units = NULL, time.units = "days", period.basis = "year", ## time and period only important for labelling and do not influence the calculation
    na.action = na.fail, optim.args = NULL, priorFun = NULL,
    priorParams = NULL, proposalFun = NULL, proposalParams = NULL,
    iter = 9999, weights = 1, blocks = NULL, verbose = FALSE
  )

  ## Now calculate the return levels and their confidence intervals for each return period within rperiods
  rperiods <- c(seq(from = 1.01, to = 1.5, by = 0.1), 1.7, 2, 3, 5, 10, 20, 50, 80, 100, 120, 200, 250, 300, 500, 800, 2000, 5000)
  rvs_obs <- ci.fevd(fit_obs, alpha = 0.05, type = "return.level", return.period = rperiods, method = "normal")
  colnames(rvs_obs) <- c("Obs_l", "Obs", "Obs_h") # Rename the col
  GEV_obs <- data.frame(cbind(rvs_obs, rperiods)) ## Make a datafram for ggplot

  ## Add the emipirical data
  rp_obs <- length(obs) / 1:length(obs) ## these are the (empirical) return periods for the sorted datapoints
  obs_sorted <- sort(obs, decreasing = T) ## For example, the highest extreme has a rp of 35 years, the second highest 17.5, third highest 11.7 etc.
  datapoints_obs <- data.frame(cbind(rp_obs, obs_sorted))


  rp_S5 <- length(ensemble) / 1:length(ensemble) # SEAS5 has return periods up to 3800 years
  ensemble_sorted <- sort(ensemble, decreasing = T)
  datapoints_S5 <- data.frame(cbind(rp_S5, ensemble_sorted))

  ## And plot
  cols <- c("UNSEEN" = "black", "OBS     " = "blue") ## for  the legend
  ggplot(data = datapoints_S5, aes(x = rp_S5)) +
    geom_point(aes(y = ensemble_sorted, col = "UNSEEN"), alpha = 0.5, size = 1) +
    geom_ribbon(data = GEV_obs, aes(ymin = Obs_l, ymax = Obs_h, x = rperiods, fill = "OBS     "), alpha = 0.1) +
    geom_point(data = datapoints_obs, aes(x = rp_obs, y = obs_sorted, col = "OBS     "), size = 1) +
    scale_x_continuous(trans = "log10") +
    scale_fill_manual(name = "Data", values = cols) +
    scale_colour_manual(name = NULL, values = cols) +
    theme_classic() +
    theme(
      legend.position = c(.95, .05),
      legend.justification = c("right", "bottom"),
      legend.box.just = "right",
      legend.title = element_blank(),
      text = element_text(size = 11),
      axis.text = element_text(size = 11)
    ) +
    labs(title = main, y = y_lab, x = "Return period (years)") +
    if (is.finite(ylim)) {
      coord_cartesian(ylim = c(NA, ylim))
    }
}


##Unseen trends plots:
rperiods = c(2, 5, 10, 20, 50, 80, 100, 120, 200, 250, 300, 500, 800,2000,5000)

RV_ci <- function(extremes,covariate,return_period,covariate_values,GEV_type) { ## A function to fit the GEV and obtain the return values 
  fit <- fevd(extremes, type = GEV_type, location.fun = ~ covariate, ##Fitting the gev with a location and scale parameter linearly correlated to the covariate (years)
               scale.fun = ~ covariate, use.phi = TRUE)

  params_matrix <- make.qcov(fit, vals = list(mu1 = covariate_values,phi1 = covariate_values)) #Create a parameter matrix for the GEV fit
  rvs=ci.fevd(fit,alpha = 0.05,type='return.level',return.period = return_period,method ="normal",qcov=params_matrix)  #Calculate the return values and confidence intervals for each year   
  return(rvs)
}

unseen_trends1 <- function(ensemble, obs, x_ens, x_obs, covariate_ens, covariate_obs, rp, GEV_type, title = "", ylab = 'Three-day precipitation (mm)') {

    ci_ens=RV_ci(extremes = ensemble,
                 covariate = covariate_ens,
                 return_period = rp,
                 covariate_values = covariate_obs, ## The covariate values are used to create the parameter matrix. This should only be the years, most likely same as covariate_obs. c(1:36 in this case)
                 GEV_type=GEV_type)

    ci_obs=RV_ci(extremes = obs,
                 covariate = covariate_obs,
                 return_period = rp,
                 covariate_values = covariate_obs,
                 GEV_type=GEV_type)

    ###plot
    cols=c("OBS"="blue","UNSEEN-trends"="orange")
    p_trend=
      ggplot()+
      ggtitle(title) +
      geom_point(aes(x = x_ens,y = ensemble),size=2,alpha=0.051)+
       # scale_size_manual(values = seq(0.1,3,length.out = 3499)) +
      geom_point(aes(x=x_obs,y = obs),col='blue',shape=4,size=2,stroke=1.5)+
      geom_line(aes(x=x_obs,y = ci_ens[,2]),col='orange')+
      geom_ribbon(aes(x=x_obs,ymin = ci_ens[,1],ymax=ci_ens[,3],fill="UNSEEN-trends"),alpha=0.5)+
      geom_line(aes(x=x_obs,y = ci_obs[,2]),col='blue')+
      geom_ribbon(aes(x=x_obs,ymin = ci_obs[,1],ymax=ci_obs[,3],fill="OBS"),alpha=0.2)+
      theme_classic()+
      ylab(ylab)+
      scale_fill_manual(name="Method",values=cols) +
      theme(axis.title.x=element_blank(),
            plot.title = element_text(hjust = 0.5),
            text=element_text(size=14),
            axis.text = element_text(size=14))
    return(p_trend)
}


unseen_trends2 <- function(ensemble, obs, covariate_ens, covariate_obs, GEV_type, ylab = 'Three-day precipitation (mm)') {

    # Calculate the return values for 1981 (covariate = 1)
    rvs_1981=RV_ci(extremes = ensemble,
                   covariate = covariate_ens,
                   return_period = rperiods,
                   covariate_values = 1,
                   GEV_type = GEV_type) ##calc the return values
    colnames(rvs_1981) = c('S5_1981_l','S5_1981','S5_1981_h','S5_1981_sd') #Rename the column

    # Calculate the return values for 2015 (covariate = 35)
    rvs_2015=RV_ci(extremes = ensemble,
                   covariate = covariate_ens,
                   return_period = rperiods,
                   covariate_values = 35,
                   GEV_type = GEV_type)
    colnames(rvs_2015) = c('S5_2015_l','S5_2015','S5_2015_h','S5_2015_sd')

    rvs_obs_1981=RV_ci(extremes = obs,
                       covariate = covariate_obs,
                       return_period = rperiods,
                       covariate_values = 1,
                       GEV_type = GEV_type)
    colnames(rvs_obs_1981) = c('Obs_1981_l','Obs_1981','Obs_1981_h','Obs_1981_sd') #Rename the col

    rvs_obs_2015=RV_ci(extremes = obs,
                       covariate = covariate_obs,
                       return_period = rperiods,
                       covariate_values = 35,
                       GEV_type = GEV_type)
    colnames(rvs_obs_2015) = c('Obs_2015_l','Obs_2015','Obs_2015_h','Obs_2015_sd')

    ## Combine the return values into one dataframe
    rvs=data.frame(cbind(rvs_1981,rvs_2015,rvs_obs_1981,rvs_obs_2015,rperiods))

#     cols=c("S5_1981"="#f04546","S5_2015"="#3591d1","Obs_1981"="#62c76b","Obs_2015"="#62c76b")
    cols=c("1981"="black","2015"="red")
    p=ggplot(data = rvs,aes(x=rperiods))+
      geom_line(aes(y = S5_1981),col='black')+
      geom_ribbon(aes(ymin=S5_1981_l,ymax=S5_1981_h,fill='1981'),alpha=0.5)+
      geom_line(aes(y = S5_2015,colour="2015"),col='red')+
      geom_ribbon(aes(ymin=S5_2015_l,ymax=S5_2015_h,fill="2015"), alpha=0.5)+
      geom_line(aes(y = Obs_1981),col='black',linetype ='dashed')+
      geom_ribbon(aes(ymin=Obs_1981_l,ymax=Obs_1981_h),fill='black', alpha=0.1)+
      geom_line(aes(y = Obs_2015),col='red',linetype ='dashed')+
      geom_ribbon(aes(ymin=Obs_2015_l,ymax=Obs_2015_h),fill='red', alpha=0.1)+
      scale_x_continuous(trans='log10')+
      theme_classic()+
      scale_fill_manual(name="Years",values=cols) +
      xlab('Return period (years)')+
      ylab(ylab)+
      theme(text=element_text(size=14),
            axis.text = element_text(size=14))
    return(p)
}
