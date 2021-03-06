#!/bin/bash

# This script fits a probabilistic diffusion model to diffusion data that have already been motion-corrected & preprocessed using preproc_diff.sh

# Load FSL
module load fsl/5.0.10

# Set directory names
datadir="/projects/dsnlab/shared/tag/bids_data"
scriptsdir="/projects/dsnlab/shared/tag/TAG_scripts/dMRI"
outputdir="/projects/dsnlab/shared/tag/bids_data/derivatives/dMRI_preproc"

# Set file dependencies
data=""$outputdir"/"${subid}"/ses-wave1/dwi/data.nii.gz"
b0mask=""$outputdir"/"${subid}"/ses-wave1/dwi/nodif_brain_mask.nii.gz"

# Set error log file
errorlog=""$scriptsdir"/errorlog_bedpostx.txt"

# Create error log file
touch "${errorlog}"

if [[ -f "$data" && -f "$b0mask" ]]; then

# Make directory for bedpostx to use
mkdir "$outputdir"/"${subid}"/ses-wave1/dwi.fit
cp "$outputdir"/"${subid}"/ses-wave1/dwi/data.nii.gz "$outputdir"/"${subid}"/ses-wave1/dwi.fit/
cp "$outputdir"/"${subid}"/ses-wave1/dwi/nodif_brain_mask.nii.gz "$outputdir"/"${subid}"/ses-wave1/dwi.fit/
cp "$scriptsdir"/params/bvecs "$outputdir"/"${subid}"/ses-wave1/dwi.fit/
cp "$scriptsdir"/params/bvals "$outputdir"/"${subid}"/ses-wave1/dwi.fit/

# Fitting a probabilistic diffusion model
# Note: This last command takes a couple days to run
echo running "${subid}" bedpostx
fsl_sub.orig bedpostx "$outputdir"/"${subid}"/ses-wave1/dwi.fit

echo "${subid}" preprocessing completed.
# Congratulations!  You are now ready to perform tractography.

else
# Making a note of missing files in error log
echo "ERROR: missing at least one file necessary for fitting diffusion model"
echo "$outputdir"/"${subid}"/ses-wave1/dwi: MISSING BEDPOSTX INPUT FILES >> $errorlog
fi


