library(extRemes)
library(ggplot2)
library(ggpubr)

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