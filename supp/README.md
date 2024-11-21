# `supp`

This directory stores all figures associated with the manuscript except for the main figures.
We provide only a portion of figures (e.g., **S1 Fig** and **S2 Fig**) to the journal as supporting information, which are referred to in the manucript.
The rest of the figures (e.g., **S2.2 Fig** and **S3.2 Fig**) are not provided to the journal or referred to using figure numbers in the manucript.
Note that **Sx.y Fig** contains the same type of plots as **Sx Fig** but for a differnt modeling approach, computational method, or simulation scenario.

<!-- \newpage -->

## Results

### Assessing the allelic additivity in hNPCs with growth stimulation

<center><img src=
"png/wnt_llk.png"
align="center" width="650"></center>

<!-- ![](png/wnt_llk.png){width=80%} -->

**S1 Fig.**
**Assessing the allelic additivity assumption in hNPCs.**
**A.** Scatterplots comparing the maximized likelihood between nonlinear and linear regression for 3073 gene-SNP pairs under the control condition. **B.** The same as in **A** but between the model with a categorical genotype variable consisting of three levels and nonlinear regression. **C.** The same as in **A** but between the model with a categorical genotype variable and linear regression. **D.** The same as in **A** but under the treated condition. **E.** The same as in **B** but under the treated condition. **F.** The same as in **C** but under the treated condition. **G.** Scatterplots comparing the maximized likelihood between nonlinear and linear regression for 42576 cCRE-SNP pairs under the control condition. **H.** The same as in **G** but between the model with a categorical genotype variable and nonlinear regression. **I.** The same as in **G** but between the model with a categorical genotype variable and linear regression. **J.** The same as in **G** but under the treated condition. **K.** The same as in **H** but under the treated condition. **L.** The same as in **I** but under the treated condition.

### Simulation: classifying GxT interactions using BMS

<center><img src=
"png/sim_rocc_mcmc_bs.png" 
align="center" width="650"></center>

**S2 Fig.**
**ROC curves assessing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MCMC and bridge sampling.**
Shown are results from 800 simulations without random effect, which we call scenario 1 (**A**), those with donor random effect in model fitting but not in data generation (scenario 2) (**B**), those with donor random effect in data generation but not in model fitting (scenario 3) (**C**), and those with donor effect in both data generation and model fitting (scenario 4) (**D**).

<center><img src=
"png/sim_rocc_map_lap.png"
align="center" width="650"></center>

**S2.2 Fig.**
**ROC curves assessing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MAP and Laplace approximation.**
The same as in **S2 Fig** but from 8000 simulations using MAP estimation and Laplace approximation.

<center><img src=
"png/sim_calib_mcmc_bs.png" 
align="center" width="900"></center>

**S3 Fig.**
**Calibration of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MCMC and bridge sampling.**
The $x$- and $y$-axis represent the posterior probability and the fraction of the corresponding events, respectively. The results from 800 simulations are grouped into ten equally-spaced bins. The vertical bars represent the standard errors assuming a binomial distribution. 
The panels **A** to **D** show the results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_calib_map_lap.png" 
align="center" width="900"></center>

**S3.2 Fig.**
**Calibration of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MAP and Laplace approximation.**
The same as in **S3 Fig** but from 8000 simulations using MAP estimation and Laplace approximation.

<center><img src=
"png/sim_hist_mcmc_bs_nl.png"
align="center" width="900"></center>

**S4 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS with $\log$-NL using MCMC and bridge sampling.**
In each panel, the rows and columns represent the data-generating and posterior mode models, respectively. The panels **A** to **D** show the results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_hist_mcmc_bs_lm.png"
align="center" width="900"></center>

**S4.2 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS with $\log$-LM using MCMC and bridge sampling.**
The same as in **S4 Fig** but for $\log$-LM.

<center><img src=
"png/sim_hist_mcmc_bs_rint.png"
align="center" width="900"></center>

**S4.3 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS with RINT-LM using MCMC and bridge sampling.**
The same as in **S4 Fig** but for RINT-LM.

<center><img src=
"png/sim_hist_map_lap_nl.png"
align="center" width="900"></center>

**S4.4 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS with $\log$-NL using MAP estimation and Laplace approximation.**
The same as in **S4 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_hist_map_lap_lm.png"
align="center" width="900"></center>

**S4.5 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS with $\log$-LM using MAP estimation and Laplace approximation.**
The same as in **S4.4 Fig** but for $\log$-LM.

<center><img src=
"png/sim_hist_map_lap_rint.png"
align="center" width="900"></center>

**S4.6 Fig.**
**Stratified histograms of posterior probability of the eight models obtained by BMS wth RINT-LM using MAP estimation and Laplace approximation.**
The same as in **S4.4 Fig** but for RINT-LM.

<center><img src=
"png/sim_procc_mcmc_bs.png"
align="center" width="650"></center>

**S5 Fig.**
**Partial ROC curves assessing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MCMC and bridge sampling.**
The panels **A** to **D** show the results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_procc_map_lap.png"
align="center" width="650"></center>

**S5.2 Fig.**
**Partial ROC curves assessing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM for the no-GxT, induced, and altered categories using MAP and Laplace approximation.**
The panels **A** to **D** show the results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_aggr_mcmc_bs.png"
align="center" width="650"></center>

**S6 Fig.**
**Posterior probability of the correct and incorrect models for aggregated categories obtained by BMS using MCMC and bridge sampling.**
Violin plots for comparing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM based on the distribution of posterior probability of the correct and incorrect models for the no-GxT, induced, and altered model categories. The closed circles represent median values. The panels **A** to **D** show the results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_aggr_map_lap.png"
align="center" width="650"></center>

**S6.2 Fig.**
**Posterior probability of the correct and incorrect models for aggregated categories obtained by BMS using MAP estimation and Laplace approximation.**
The same as in **S6 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_vln_mcmc_bs1.png"
align="center" width="650"></center>

**S7 Fig.**
**Posterior probability of the correct and incorrect models for the eight categories obtained by BMS using MCMC and bridge sampling on data generated without random effect.**
Violin plots for comparing the performance of BMS with $\log$-NL, $\log$-LM, and RINT-LM based on the distribution of posterior probability of the correct and incorrect models for each of the eight model categories. The closed circles represent median values. The panels **A** and **B** respectively show the results in scenarios 1 and 2, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_mcmc_bs2.png"
align="center" width="650"></center>

**S7.2 Fig.**
**Posterior probability of the correct and incorrect models for the eight categories obtained by BMS using MCMC and bridge sampling on data generated with donor random effect.**.
The same as **S7 Fig** but on data generated with donor random effect. The panels **A** and **B** respectively show the results in scenarios 3 and 4, which are described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_map_lap1.png"
align="center" width="650"></center>

**S7.3 Fig.**
**Posterior probability of the correct and incorrect models for the eight categories obtained by BMS using MAP estimation and Laplace approximation on data generated without random effect.**
The same as in **S7 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_vln_map_lap2.png"
align="center" width="650"></center>

**S7.4 Fig.**
**Posterior probability of the correct and incorrect models for the eight categories obtained by BMS using MAP estimation and Laplace approximation on data generated with donor random effect.**
The same as in **S7.2 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_est_mcmc_bs.png"
align="center" width="900"></center>

**S8 Fig.**
**Comparison of effect estimates by Bayesian model averaging with $\log$-NL, $\log$-LM, and RINT-LM.**
**A.** Scatter plots comparing estimation of the genotype, treatment, and GxT interaction effects relative to the residual standard deviation against the true values in scenario 1, which is described in the legend to **S2 Fig**.
Each point represents each of 8000 feature-SNP pairs.
Shown in the top-left corner of each panel is the root mean squared error (RMSE).
**B.** The same as in **A** but for scenario 2.
**C.** The same as in **A** but for scenario 3.
**D.** The same as in **A** but for scenario 4.

<center><img src=
"png/sim_est_map_lap.png"
align="center" width="900"></center>

**S8.2 Fig.**
**Comparison of MAP estimates with $\log$-NL, $\log$-LM, and RINT-LM.**
The same as in **S8 Fig** but for MAP estimation.

<center><img src=
"png/sim_compare_pp_noranef.png"
align="center" width="900"></center>

**S9 Fig.**
**Comparison of posterior probability at varying hyperparameter values between two computational approaches on synthetic data generated without donor random effect.**
**A.** Scatter plots comparing posterior probabilities obtained by MCMC followed by bridge sampling and those obtained by MAP estimation followed by Laplace approximation for scenario 1, which is described in the legend to **S2 Fig**. Each point represents each of the eight models for a feature-SNP pair. The values are compared across eight models and 686 feature-SNP pairs for which minor allele homozygotes were present (i.e., 5488 combinations).
**B.** The same as in **A** but for 114 feature-SNP pairs for which minor allele homozygotes were absent (i.e., 912 combinations).
**C.** The same as in **A** but for scenario 2.
**D.** The same as in **B** but for scenario 2.

<center><img src=
"png/sim_compare_pp_ranef.png"
align="center" width="900"></center>

**S9.2 Fig.**
**Comparison of posterior probability at varying hyperparameter values between two computational approaches on synthetic data generated with donor random effect.**
**A.** The same as in **S9 Fig A** but for scenario 2.
**B.** The same as in **S9 Fig B** but for scenario 2.
**C.** The same as in **S9 Fig C** but for scenario 3.
**D.** The same as in **S9 Fig D** but for scenario 3.

<center><img src=
"png/sim_compare_sum_lnpy.png"
align="center" width="650"></center>

**S10 Fig.**
**Comparison of the sum of the $\log$ of marginal likelihood across combinations of hyperparameter values between two computational approaches for $\log$-NL, $\log$-LM, and RINT-LM with and without donor random effect.**
Scatter plots comparing results obtained by MCMC followed by bridge sampling and those obtained by MAP estimation followed by Laplace approximation. Each point represents the $\log$ of the marginal likelihood summed over 80 feature-SNP pairs. The values are compared across 125 combinations of the hyperparameter values (see **S1 Text** for details).

<center><img src=
"png/sim_rocc_effect_mcmc_bs.png"
align="center" width="900"></center>

**S11 Fig.**
**ROC curves assessing the impact of the effect prior on the performance of BMS using MCMC and bridge sampling.**
The colors represent varying hyper parameter values (see **S1 Text**). The panels **A** to **D** show results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.
In each panel, the rows and columns represent modeling approaches and aggregated categories, respectively.

<center><img src=
"png/sim_procc_effect_mcmc_bs.png"
align="center" width="900"></center>

**S12 Fig.**
**Partial ROC curves assessing the impact of the effect prior on the performance of BMS using MCMC and bridge sampling.**
The colors represent varying hyper parameter values (see **S1 Text**). The panels **A** to **D** show results in scenarios 1 to 4, which are described in the legend to **S2 Fig**.
In each panel, the rows and columns represent modeling approaches and aggregated categories, respectively.

<center><img src=
"png/sim_vln_effect_mcmc_bs_noranef_noranef.png"
align="center" width="650"></center>

**S13 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses without random effect using MCMC and bridge sampling.**
Violin plots showing the distribution of posterior probability of the correct (**A**) and incorrect (**B**) models for each of the eight model categories with varying hyper parameter values (see **S1 Text**). The closed circles represent median values. Shown is the results in scenario 1, which is described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_effect_mcmc_bs_noranef_ranef.png"
align="center" width="650"></center>

**S13.2 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in model fitting but not in data generation using MCMC and bridge sampling.**
The same as in **S13 Fig** but in scenario 2, which is described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_effect_mcmc_bs_ranef_noranef.png"
align="center" width="650"></center>

**S13.3 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in data generation but not in model fitting using MCMC and bridge sampling.**
The same as in **S13 Fig** but in scenario 3, which is described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_effect_mcmc_bs_ranef_ranef.png"
align="center" width="650"></center>

**S13.4 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in both data generation and model fitting using MCMC and bridge sampling.**
The same as in **S13 Fig** but in scenario 4, which is described in the legend to **S2 Fig**.

<center><img src=
"png/sim_vln_effect_map_lap_noranef_noranef.png"
align="center" width="650"></center>

**S13.5 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses without random effect using MAP estimation and Laplace approximation.**
The same as in **S13 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_vln_effect_map_lap_noranef_ranef.png"
align="center" width="650"></center>

**S13.6 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in model fitting but not in data generation using MAP estimation and Laplace approximation.**
The same as in **S13.2 Fig** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_vln_effect_map_lap_ranef_noranef.png"
align="center" width="650"></center>

**S13.7 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in data generation but not in model fitting using MAP estimation and Laplace approximation.**
The same as in **S13.3** but for MAP estimation and Laplace approximation.

<center><img src=
"png/sim_vln_effect_map_lap_ranef_ranef.png"
align="center" width="650"></center>

**S13.8 Fig.**
**Assessing the impact of the effect prior on the posterior probability of the correct and incorrect models from analyses with donor random effect in both data generation and model fitting using MAP estimation and Laplace approximation.**
The same as in **S13.4** but for MAP estimation and Laplace approximation.

### Classifying GxT interactions for response eQTLs in hNPCs with growth stimulation

<center><img src=
"png/wntrna_hm.png"
align="center" width="650"></center>

**S14 Fig.**
**Posterior probability of the models with and without accounting for the sign of effect size for the response eQTL data in hNPCs.**
The heatmaps show the posterior probability of the eight models for the 98 response eQTLs, which represent gene-SNP pairs with significant GxT interactions (**A**), as well as that of the 27 models accounting for the sign of effect size (**B**). The rows and columns represent the models and gene-SNP pairs, respectively. The gene-SNP pairs are ordered by $P$ values for significant GxT interactions from a previous study (Matoba *et al.* 2024). The leftmost column corresponds to the smallest $P$ value.

<center><img src=
"png/wntrna_compare_pp.png"
align="center" width="650"></center>

**S15 Fig.**
**Comparison of posterior probability between results with donor random effect and those with polygenic random effect for response eQTLs.**
Scatter plots comparing results obtained by BMS with polygenic (kinship) random effect and those with donor random effect. Each point represents the posterior probability of a mode for a feature-SNP pair. The values are compared across eight models and 98 feature-SNP pairs (i.e., 784 combinations).

### Classifying GxT interactions with respect to chromatin accessibility

<center><img src=
"png/wntatac_hm.png"
align="center" width="650"></center>

**S16 Fig.**
**Posterior probability of the models with and without accounting for the sign of effect size for the response caQTL data in hNPCs.**
The same as in **S14 Fig** but for 1775 response caQTLs. 

<center><img src=
"png/wntatac_gp.png"
align="center" width="900"></center>

**S17 Fig.**
**Representative BMS results for the response caQTL data in hNPCs.**
The same as in **Fig. 5** (see the main text) but for response caQTLs. 

<center><img src=
"png/wntatac_gp_co.png"
align="center" width="650"></center>

**S18 Fig.**
**Examples of response caQTLs with the crossover interaction in hNPCs.**
The same as in **Fig. 6** (see the main text) but for response caQTLs. 
