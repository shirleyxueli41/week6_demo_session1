#!/usr/bin/env bash
#SBATCH --job-name=hw4_star
#SBATCH --partition=batch
#SBATCH --array=TODO_ARRAY_RANGE
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=06:00:00
#SBATCH --output=logs/%x_%A_%a.out
#SBATCH --error=logs/%x_%A_%a.err

# Resource requests are examples for this course dataset, not universal rules.
sample=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" samples.txt)
trim_dir=results/fastp
out_dir=results/star
star_index=/cluster/tufts/biocontainers/datasets/references/gencodes/human/index/star
gtf=/cluster/tufts/biocontainers/datasets/references/gencodes/human/gencode.v49.primary_assembly.annotation.gtf

mkdir -p "$out_dir"

module purge
module load star
module load samtools/1.17

STAR \
    --runThreadN "$SLURM_CPUS_PER_TASK" \
    --genomeDir "$star_index" \
    --sjdbGTFfile "$gtf" \
    --readFilesIn \
        "${trim_dir}/${sample}_R1_trimmed.fastq.gz" \
        "${trim_dir}/${sample}_R2_trimmed.fastq.gz" \
    --readFilesCommand zcat \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMattributes NH HI AS NM MD \
    --outFileNamePrefix "${out_dir}/${sample}_"

samtools index "${out_dir}/${sample}_Aligned.sortedByCoord.out.bam"

