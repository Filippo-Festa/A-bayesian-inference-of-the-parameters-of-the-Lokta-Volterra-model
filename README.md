# Bayesian Inference of Lokta-Volterra Model Parameters

This repository contains the implementation and analysis for a project conducted as part of the "Advanced Statistics for Physical Analysis" course at Università degli Studi di Padova. The project focuses on performing Bayesian inference to estimate the parameters of the Lokta-Volterra model, a set of first-order, non-linear differential equations used to describe the dynamics of biological systems in which two species interact, specifically a predator and a prey.

## Project Overview

### Mathematical Foundation
The Lokta-Volterra equations model the interaction between two species:
- **Prey Population Growth Rate (α)**: Determines the rate at which the prey population increases.
- **Predator Efficiency (β)**: Represents the rate at which the predator population reduces the prey population.
- **Predator Population Decline Rate (γ)**: Indicates the rate at which the predator population decreases in the absence of prey.
- **Predator Reproduction Rate (δ)**: Describes the rate of predator population growth proportional to the prey population.

The system's stationary conditions and solutions were derived and analyzed, serving as a foundation for the statistical model.

### Data and Statistical Model
The statistical model employed in this project is based on observed data of predator and prey populations over time. Using a Bayesian approach, the project aims to infer the true, unknown population sizes at various time points, given the initial conditions and the parameters of the Lokta-Volterra model.

### Weakly Informative Priors
To enhance the robustness of the Bayesian inference, weakly informative priors were selected for the parameters. This approach ensures that the priors influence the posterior distributions without overwhelming the data, leading to more reliable parameter estimates.

### Computational Approach
The inference was performed using STAN, a state-of-the-art platform for statistical modeling and high-performance statistical computation. The project includes the STAN code used for the Bayesian inference, allowing for reproducibility and further exploration.

### Key Files
- **Data Preparation**: Scripts for data pre-processing and exploratory data analysis.
- **Model Implementation**: STAN code for Bayesian inference of the Lokta-Volterra parameters.
- **Results Analysis**: Jupyter notebooks containing the analysis of the inferred parameters and their implications on the predator-prey dynamics.
