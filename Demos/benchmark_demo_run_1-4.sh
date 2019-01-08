#!/bin/bash

# Name
NAME="Bonev_ES_observed_KR_chr8_42100-44500kb_res25kb"

# Parameters for conversion and normalization
START=42100000
END=44500000
RES=25000
OFFSET=2

# Hyperparameters for optimization
ALPHA1=0.002
ALPHA2=0.0001
STEP1=2000
STEP2=5000
ITERATION=100
INIT_K_BACKBONE=0.3

# Number of optimization sample
SAMPLE=1

# Parameters for plot
PLT_MIN_LOG_C=-3
PLT_MAX_K_BACKBONE=0.5
PLT_MAX_K=0.010
PLT_K_DIS_BINS=100
PLT_MAX_K_DIS=1500

HiCFILE=$NAME".txt"
#--------------------------------------------------------------------------------------------------
# Run python codes
echo "python 1_conversion.py"
time python 1_conversion.py $HiCFILE $START $END $RES

echo "python 2_normalization.py"
time python 2_normalization.py $NAME $RES $OFFSET
#read -p "Finished normalization!! Optimization OK? (y/N): " yn
#case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

echo "python 3_optimization.py"
time python 3_optimization.py $NAME $SAMPLE $ALPHA1 $ALPHA2 $STEP1 $STEP2 $ITERATION $INIT_K_BACKBONE

echo "python 4_validation.py"
time python 4_validation.py $NAME $RES $SAMPLE $PLT_MIN_LOG_C $PLT_MAX_K_BACKBONE $PLT_MAX_K $PLT_K_DIS_BINS $PLT_MAX_K_DIS
