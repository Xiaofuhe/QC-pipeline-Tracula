step4: Assess Tract Quality.
	run generateTagsOfSingleCurveTracts_auto_batch.m to automatically check if there are any single curve cases
	the output will be saved in the excel file

	step4.1. copy ../freesurfer/matlab tool
		freeSurfer_matlab comes from /usr/local/freesurfer/matlab  where you have installed freesurfer before.

	step4.2. generate an empty excel file
		copy Tracula_QC_empty_withTMI_template.xlsx
		to Tracula_QC_empty_withTMI_test.xlsx
		then copy and paste the exam list and group tag to the Tracula_QC_empty_withTMI_test.xlsx
	
	step4.3. copy the pathTemplate to a location, e.g., ../pathTemplate
			which is needed to run generateTagsOfSingleCurveTracts_auto_batch.m  

	step4.4 set up the path in the generateTagsOfSingleCurveTracts_auto_batch.m accordingly
		then run generateTagsOfSingleCurveTracts_auto_batch.m  

	step4.5 ask RA to double check the results
		tags: singlecurve, tiny, unsymmetrical, unusual etc.


step5: Reinitialize Parameters
	rerun those tracts with a single curve or missing curve
	set reinit = 1 in the configuration file, e.g., dmrirc.studyName.Exam#
	then rerun 
	"trac-all -prior -c  dmrirc.studyName.Exam#" and  
	"trac-all -path -c  dmrirc.studyName.Exam#"
 
step6: Estimate Control Points
	step6.1	ask your RAs to double check the results and correct them the FAR and FRR cases if necessary!
		by running the shell script tracula_showOutputs_batch.sh
	step6.2 edit the control points by running the shell script tracula_editControlPoints_batch.sh
	step6.3 run ras2vox_batch.m 
		converted the coordinates of the control points (https://surfer.nmr.mgh.harvard.edu/fswiki/CoordinateSystems) from Right-Anterior-Superior (RAS, anatomical coordinates) to voxel space
		in order to rerun Tracula
	step6.4 rerun the Tracula using the edited control points