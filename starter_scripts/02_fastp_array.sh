#!/usr/bin/env bash
#SBATCH --job-name=hw4_fastp
#SBATCH --partition=batch
#SBATCH --array=TODO_ARRAY_RANGE
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=logs/%x_%A_%a.out
#SBATCH --error=logs/%x_%A_%a.err

# Resource requests are examples for this course dataset, not universal rules.
sample=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" samples.txt)
raw_dir=/cluster/tufts/c26fa1bio0196/shared/hw4/data
out_dir=results/fastp

mkdir -p "$out_dir"

module purge
module load fastp

fastp \
    -i "${raw_dir}/${sample}_R1.fastq.gz" \
    -I "${raw_dir}/${sample}_R2.fastq.gz" \
    -o "${out_dir}/${sample}_R1_trimmed.fastq.gz" \
    -O "${out_dir}/${sample}_R2_trimmed.fastq.gz" \
    --json "${out_dir}/${sample}_fastp.json" \
    --html "${out_dir}/${sample}_fastp.html" \
    --detect_adapter_for_pe \
    --thread "$SLURM_CPUS_PER_TASK"

