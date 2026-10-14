#!/bin/bash

# Run this wrapper from the hw4 project folder with: bash run.sh

fastp_job=$(sbatch --parsable scripts/02_fastp_array.sh)

star_job=$(sbatch --parsable \
    TODO_FASTP_DEPENDENCY \       # Need correction here, after correction, delete this comment
    scripts/03_star_array.sh)

counts_job=$(sbatch --parsable \
    TODO_STAR_DEPENDENCY \       # Need correction here, after correction, delete this comment
    scripts/04_featurecounts_all.sh)

echo "fastp array job:   $fastp_job"
echo "STAR array job:    $star_job"
echo "featureCounts job: $counts_job"


# Please check week4_demo_session2 scripts for hints 
