#!/bin/bash

# This script copies (a) DICOMS from lcni to our lab, on Talapas, (b) DICOMS & physio from Talapas to CAS server

## COPY TALAPAS LCNI DICOMS TO TALAPAS DSNLAB ARCHIVE
ssh jpfeifer@talapas-ln1.uoregon.edu rsync -aiv -P /projects/lcni/dcm/dsnlab/Pfeifer/TAG/TAG???_20* /projects/dsnlab/shared/tag/archive/DICOMS/ # for tag
ssh jpfeifer@talapas-ln1.uoregon.edu rsync -aiv -P /projects/lcni/dcm/dsnlab/Pfeifer/SOS/TAG???_20* /projects/dsnlab/shared/sos/archive/DICOMS/ # for SOS (named correctly)
ssh jpfeifer@talapas-ln1.uoregon.edu rsync -aiv -P /projects/lcni/dcm/dsnlab/Pfeifer/SOS/SOS???_20* /projects/dsnlab/shared/sos/archive/DICOMS/ # for SOS (named incorrectly)

## COPY TALAPAS LCNI PHYSIO TO TALAPAS DSNLAB ARCHIVE
ssh jpfeifer@talapas-ln1.uoregon.edu rsync -aiv -P /projects/lcni/dcm/dsnlab/Pfeifer/TAG/*physio* /projects/dsnlab/shared/tag/archive/physio/
##New TAG physio is now saved in dcm format… no additional backup required
##SOS physio is now saved in dcm format… no additional backup required

## COPY TALAPAS DSNLAB ARCHIVE TO CAS
rsync -aiv -e ssh jpfeifer@talapas-ln1.uoregon.edu:/projects/dsnlab/shared/tag/archive/ /Volumes/psych-cog/dsnlab/TAG/archive/ # tag dicoms and physio
rsync -aiv -e ssh jpfeifer@talapas-ln1.uoregon.edu:/projects/dsnlab/shared/sos/archive/ /Volumes/psych-cog/dsnlab/SOS/archive/ # sos dicoms and physio

## COPY TASK BEH DATA FROM LCNI DESKTOP TO CAS
rsync -aiv -e ssh dsnlab@kashkaval:/Users/dsnlab/Studies/TAG/DRS/task/input/tag*_info.mat /Volumes/psych-cog/dsnlab/TAG/behavior/task/info/ # inputs
rsync -aiv -e ssh dsnlab@kashkaval:/Users/dsnlab/Studies/TAG/DRS/task/output/* /Volumes/psych-cog/dsnlab/TAG/behavior/task/output/ # outputs

## COPY TASK BEH DATA FROM MOCK SCANNER TO CAS
rsync -aiv -e ssh dsnlab@simulatum:/Users/dsnlab/Studies/TAG/task/DRS/task/input/tag*_info.mat /Volumes/psych-cog/dsnlab/TAG/behavior/task/info/ # inputs
rsync -aiv -e ssh dsnlab@simulatum:/Users/dsnlab/Studies/TAG/task/DRS/task/output/* /Volumes/psych-cog/dsnlab/TAG/behavior/task/output/ # outputs

## COPY ALL FILES FROM TAG TO EXTERNAL HARDDRIVE ("Chief")
rsync -aiv -P /Volumes/psych-cog/dsnlab/TAG/ /Volumes/Chief/TAG/ # tag
rsync -aiv -P /Volumes/psych-cog/dsnlab/SOS/ /Volumes/Chief/SOS/ # sos