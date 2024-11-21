#!/bin/bash

#SBATCH --job-name=snake
#SBATCH --time=1:00:00
#SBATCH --mem=2G

proj=$HOME/reqtl-code

main_src1=$proj/figures/vis/main-figs/
main_src2=$proj/figures/revision/vis/
main_dst=$proj/figures/revision/main-figs/

fig_src1=$proj/figures/vis/supp-figs
fig_src2=$proj/figures/revision
table_src1=$proj/derived_data/performance
table_src2=$proj/derived_data/revision
fig_dst=$proj/figures/revision/supp-figs
table_dst=$proj/derived_data/revision/supp-tables

mkdir -p $main_dst
mkdir -p $fig_dst
mkdir -p $table_dst

cp $main_src1/*pdf $main_dst/
cp $main_src2/sim_rocc_vln.pdf $main_dst/

cp $fig_src1/*pdf $fig_dst/

cp $fig_src2/rocc/map-lap/rocc.pdf\
 $fig_dst/sim_rocc_map_lap.pdf
cp $fig_src2/rocc/map-lap/procc.pdf\
 $fig_dst/sim_procc_map_lap.pdf
cp $fig_src2/rocc/mcmc-bs/procc.pdf\
 $fig_dst/sim_procc_mcmc_bs.pdf

cp $fig_src2/vis/sim/map-lap/lm/hist.pdf\
 $fig_dst/sim_hist_map_lap_lm.pdf
cp $fig_src2/vis/sim/mcmc-bs/lm/hist.pdf\
 $fig_dst/sim_hist_mcmc_bs_lm.pdf
cp $fig_src2/vis/sim/map-lap/nl/hist.pdf\
 $fig_dst/sim_hist_map_lap_nl.pdf
cp $fig_src2/vis/sim/mcmc-bs/nl/hist.pdf\
 $fig_dst/sim_hist_mcmc_bs_nl.pdf
cp $fig_src2/vis/sim/map-lap/rint/hist.pdf\
 $fig_dst/sim_hist_map_lap_rint.pdf
cp $fig_src2/vis/sim/mcmc-bs/rint/hist.pdf\
 $fig_dst/sim_hist_mcmc_bs_rint.pdf

cp $fig_src2/effect/mcmc-bs/rocc_pw.pdf\
 $fig_dst/sim_rocc_effect_mcmc_bs.pdf  
cp $fig_src2/effect/mcmc-bs/procc_pw.pdf\
 $fig_dst/sim_procc_effect_mcmc_bs.pdf  

cp $fig_src2/est/map-lap/scatter_all.pdf\
 $fig_dst/sim_est_map_lap.pdf   
cp $fig_src2/est/mcmc-bs/scatter_all.pdf\
 $fig_dst/sim_est_mcmc_bs.pdf   

rm $fig_dst/sim_compare_pp.pdf
cp $fig_src2/comparison/sim_compare_pp_noranef.pdf\
 $fig_dst/
cp $fig_src2/comparison/sim_compare_pp_ranef.pdf\
 $fig_dst/

cp $fig_src2/vis/wnt_llk.pdf $fig_dst/

