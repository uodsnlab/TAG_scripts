#!/bin/bash
#
# This script will convert afni files
# to gzipped nifti files
#

echo -e "\nSetting up AFNI"

module load afni

date

echo $SHELL
echo $SHLVL
echo ${SUBID}

# set subject and group identifiers
subj="${SUBID}"
echo $subj
group_id=tag
echo $group_id
pipeline=rsfMRI_preproc_wave1

# set data directories
top_dir=/projects/dsnlab/shared/"${group_id}"
echo $top_dir
rsfMRI_output=$top_dir/bids_data/derivatives/$pipeline/$subj/$subj.results
echo $rsfMRI_output

pushd $rsfMRI_output
gen_epi_review.py -script @epi_review."${subj}"             \
    -dsets pb00."${subj}".r*.tcat+orig.HEAD

gen_ss_review_scripts.py -mot_limit 0.2 -out_limit 0.1  \
    -errts_dset errts."${subj}".fanaticor+orig.HEAD -exit0

./@ss_review_basic |& tee out.ss_review."${subj}".txt

rm rm.*
ls *.BRIK > afnifiles.txt

afnifiles=`cat afnifiles.txt`
for i in $afnifiles
	do 
	filename=${i::-5}
	niftiname=${i::-10}
	echo $filename
	echo $niftiname
	3dAFNItoNIFTI $filename
	gzip $niftiname.nii
	rm $filename.BRIK
	rm $filename.HEAD
done

popd
