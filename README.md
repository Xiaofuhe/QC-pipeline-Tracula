# DTIQC  
- A Quality Control Pipeline for TRACULA


## Overview
For Diffusion Tensor Imaging (DTI) data analysis, TRACULA (TRActs Constrained by UnderLying Anatomy) is a popular and useful tool to reconstruct major white-matter pathways. In practice, we find some tracts can occasionally be partially reconstructed by TRACULA and therefore have to be excluded from studies. Here, we propose DTIQC (Diffusion Tensor Imaging Quality Control), a semi-automated quality control pipeline that facilitate the quality control assessment for reconstructed white-matter pathways and help recover the excluded data. 

For more details, please see the paper:

He X, Stefan M, Pagliaccio D, Khamash L, Fontaine M, Marsh R (2021). A Quality Control Pipeline for Probabilistic Reconstruction of White-matter Pathways. Journal of Neuroscience Methods. https://doi.org/10.1016/j.jneumeth.2021.109099

## Support
For support using our tool, please contact: DTIQC2020@yahoo.com

## Requirements and Dependencies

-	DTIQC is developed and implemented in MATLAB. 

	To install MATLAB, please check the system requirements and download the software from MathWorks: 

	https://www.mathworks.com/support/requirements/matlab-system-requirements.html \
	https://www.mathworks.com/products/new_products/latest_features.html?s_tid=hp_release_2020b

-	DTIQC requires SPM12. 

	To install SPM12, please check the SPM website:

	https://www.fil.ion.ucl.ac.uk/spm/software/spm12/ 

-	To run through the pipeline, FSL and Freesurfer are needed. 

	To install and use FSL and Freesurfer, please check the following documentations:

	http://fsl.fmrib.ox.ac.uk/fsl/fslwiki \
	http://freesurfer.net/

-	For the usage of TRACULA, please see:

	https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula

-	In DTIQC testing, FSL v5.0.11 and Freesurfer v6.0 is used.

## Update

DTIQC is tested in the following environments:
-	Matlab2013b, Windows OS 7
-	Matlab2013b, Windows OS 10
-	Matlab2020a, Mac OS Catalina

Warning: DTIQC in Matlab2020a will write data into .csv format instead of Excel format.


##  Usage
Step 1. DTI and T1 preprocessing 
-	Run the Eddy correction toolbox from FMRIB Software Library (FSL) and FreeSurfer to preprocess DTI and T1-weighted structural images. 

Step 2. Quality Control Assessment
-	2.1 Run showFAandColorMap_GUI.m to generate the Color and FA images in GUI mode, or run showFAandColorMap_batch.m in batch mode.

-	2.2 Run outlierDetection_colorFA_GUI.m and outlierDetection_colorFA_batch.m to detect the outlier based on the color FA image in GUI and batch mode, respectively.

Step 3. Run TRACULA
-	Run TRACULA with default settings to reconstruct major white-matter pathways.

Step 4. Assess Tract Quality \
Run generateTagsOfSingleCurveTracts_auto_batch.m to automatically identify any unsuccessfully reconstructed tracts, output will be saved as an excel file.
-	4.1 Copy ../freesurfer/matlab tool, this folder is usually located at /user/local/freesurfer/matlab, i.e. where you installed freesurfer.

-	4.2 Generate an empty excel file, copy Tracula_QC_empty_withTMI_template.xlsx to Tracula_QC_empty_withTMI_yourStudyName.xlsx, copy the exam list and group tag to Tracula_QC_empty_withTMI_yourStudyName.xlsx.

-	4.3 Copy the pathTemplate to a location (e.g. ../pathTemplate) before running generateTagsOfSingleCurveTracts_auto_batch.m.

-	4.4 Set up the path in the generateTagsOfSingleCurveTracts_auto_batch.m accordingly then run generateTagsOfSingleCurveTracts_auto_batch.m.

-	4.5 Double check the results and tag single curve, tiny, unsymmetrical, unusual cases etc.

Step 5. Reinitialize Parameters
-	Re-run TRACULA for tagged unsuccessful tracts with a single curve or missing curve etc.

	Set reinit = 1 in the configuration file, e.g., dmrirc.studyName.Exam# then rerun \
	"trac-all -prior -c  dmrirc.studyName.Exam#" and  \
	"trac-all -path -c  dmrirc.studyName.Exam#"
 
Step 6. Estimate Control Points
-	6.1 Run the shell script tracula_showOutputs_batch.sh to double check the results and correct the FAR and FRR cases if necessary.

-	6.2 Edit the control points for partially reconstructed tracts by running the shell script tracula_editControlpoints_batch.sh.

-	6.3 Run ras2vox_batch.m, convert the coordinates of the control points (please see: https://surfer.nmr.mgh.harvard.edu/fswiki/CoordinateSystems) from Right-Anterior-Superior (RAS, anatomical coordinates) to voxel space.

-	6.4 Rerun TRACULA using edited control points.
	

##  Input 
Please select NIfTI files (filename extension .nii.gz) as inputs for the use of our tool.

## Disclaimer
Please note the scripts released in this repository are provided “as is” without warranty or guarantee of any kind, either express or implied, including but not limited to any warranty of noninfringement, merchantability, and/or fitness for a particular purpose.

The use of the scripts and the tools is At Your Own Risk, the user is responsible for reviewing before use in any environment. We are not liable for any losses, damages or other liabilities. 


## References

If you use this tool, please cite the following papers:

-	He X, Liu W, Li X, Li Q, Liu F, Rauh VA, Yin D, Bansal R, Duan Y, Kangarlu A, Peterson BS, Xu D (2014). Automated assessment of the quality of diffusion tensor imaging data using color cast of color-encoded fractional anisotropy images. Magnetic resonance imaging. https://doi.org/10.1016/j.mri.2014.01.013

-	He X, Stefan M, Pagliaccio D, Khamash L, Fontaine M, Marsh R (2021). A Quality Control Pipeline for Probabilistic Reconstruction of White-matter Pathways. Journal of Neuroscience Methods. https://doi.org/10.1016/j.jneumeth.2021.109099
