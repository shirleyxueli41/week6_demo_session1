#!/usr/bin/env bash
#SBATCH --job-name=hw4_counts
#SBATCH --partition=batch
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

# One regular job reads all nine BAM files.
# Resource requests are examples. -s 2 matches the course dataset.
bam_dir=results/star
out_dir=results/counts
gtf=/cluster/tufts/biocontainers/datasets/references/gencodes/human/gencode.v49.primary_assembly.annotation.gtf

mkdir -p "$out_dir"

module purge
module load subread

featureCounts \
    -T "$SLURM_CPUS_PER_TASK" \
    -p \
    -s 2 \
    -a "$gtf" \
    -o "${out_dir}/gene_counts.txt" \
    "${bam_dir}"/*_Aligned.sortedByCoord.out.bam

