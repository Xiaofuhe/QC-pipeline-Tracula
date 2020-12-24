# DTIQC  Step 4-6 Assess Tract Quality, Reinitialize Parameters and Estimate Control Points

##  Usage
Step 4. Assess Tract Quality \
Run generateTagsOfSingleCurveTracts_auto_batch.m to automatically identify any unsuccessfully reconstructed tracts, output will be saved as an excel file.
-	4.1 Copy ../freesurfer/matlab tool, this folder is usually located at /user/local/freesurfer/matlab, i.e. where you installed freesurfer.

-	4.2 Generate an empty excel file, copy Tracula_QC_empty_withTMI_template.xlsx to Tracula_QC_empty_withTMI_yourStudyName.xlsx, copy the exam list and group tag to Tracula_QC_empty_withTMI_yourStudyName.xlsx.

-	4.3 Copy the pathTemplate to a location (e.g. ../pathTemplate) before running generateTagsOfSingleCurveTracts_auto_batch.m.

-	4.4 Set up the path in the generateTagsOfSingleCurveTracts_auto_batch.m accordingly then run generateTagsOfSingleCurveTracts_auto_batch.m.

-	4.5 Ask RAs to double check the results, tags: singlecurve, tiny, unsymmetrical, unusual etc.

Step 5. Reinitialize Parameters
-	Re-run TRACULA for tagged unsuccessful tracts with a single curve or missing curve etc.

	Set reinit = 1 in the configuration file, e.g., dmrirc.studyName.Exam# then rerun \
	"trac-all -prior -c  dmrirc.studyName.Exam#" and  \
	"trac-all -path -c  dmrirc.studyName.Exam#"
 
Step 6. Estimate Control Points
-	6.1 Ask your RAs to double check the results and correct them the FAR and FRR cases if necessary by running the shell script tracula_showOutputs_batch.sh.

-	6.2 Edit the control points for partially reconstructed tracts by running the shell script tracula_editControlpoints_batch.sh.

-	6.3 Run ras2vox_batch.m, convert the coordinates of the control points (please see: https://surfer.nmr.mgh.harvard.edu/fswiki/CoordinateSystems) from Right-Anterior-Superior (RAS, anatomical coordinates) to voxel space.

-	6.4 Rerun TRACULA using edited control points.