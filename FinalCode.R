library(rstan)
library(coda)
library(tidyverse)

rstan_options(auto_write = TRUE)
options(mc.cores=parallel::detectCores())

modelString = "

	functions {
 		vector dz_dt(real t, vector z, vector theta) {

			vector[2] dzdt;

    			dzdt[1] = (theta[1] - theta[2] * z[2]) * z[1];
    			dzdt[2] = (-theta[3] + theta[4] * z[1]) * z[2];

    			return dzdt;

  		}
	}

	data {
  		int<lower = 0> N;           // number of measurement times
  		real ts[N];                 // measurement times > 0
  		real y_init[2];             // initial measured populations
  		real<lower = 0> y[N, 2];    // measured populations
	}

	parameters {
  		vector<lower = 0>[4] theta;   // { alpha, beta, gamma, delta }
  		vector<lower = 0>[2] z_init;  // initial population
 		real<lower = 0> sigma[2];   // measurement errors
	}

	transformed parameters {
		vector[2] z[N] = ode_rk45(dz_dt, z_init, 0, ts, theta);
	}

	model {

  		theta[{1, 3}] ~ normal(1, 0.5);
 		theta[{2, 4}] ~ normal(0.05, 0.05);
  		sigma ~ lognormal(-1, 1);
  		z_init ~ lognormal(log(10), 1);

  		for (k in 1:2) {
    			y_init[k] ~ lognormal(log(z_init[k]), sigma[k]);
    			y[, k] ~ lognormal(log(z[, k]), sigma[k]);
  		}
	}"


data <- read.csv("Lokta.csv")
N <- length(data$Year) - 1
ts <- 1:N
y0 <- c(data$Hare[1], data$Lynx[1])
y <- as.matrix(data[2:(N + 1), 2:3])
y <- cbind(y[ , 2], y[ , 1]); 						# hare, lynx order
stan_data <- list(N = N, ts = ts, y0 = y0, y = y)

model <- stan_model(model_code = modelString)
stanFit <- sampling(object=model, data = stan_data, chains = 3, iter = 5000, warmup = 2000, thin = 1, seed = 123)                  #control = list(adapt_delta = 0.99)



