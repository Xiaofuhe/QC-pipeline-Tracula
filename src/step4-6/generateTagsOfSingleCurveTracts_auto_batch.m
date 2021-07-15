function generateTagsOfSingleCurveTracts_auto_batch()
% this function automatically detect the single curve fibers, then
%output them to an excel file and convert those vox to ras for those single curve fibers so that you can edit the control points

global globalCodePath; 
globalCodePath='./Steps4-6';%Please set your ABSOLUTE path here
addpath(genpath(globalCodePath));


% Xiaofu He
% Division of Child&Adolescent Psychiatry,
% Columbia University Medical Center
% email: DTIQC2020@yahoo.com

%set up parameters here for your study
projectTag='Test';%cab used 4 points, ccg used 5 points
longitudinal.tag='';%e.g.,  e.g., for cross-sectional data
%longitudinal.tag='longitudinal';%e.g., "exam#_MRI1.long.exam#'
longitudinal.TPprefix='_MRI';%not useful if you set longitudinal.tag='' 
pathTemplate_father='./pathTemplate/dpath';%Please set your ABSOLUTE path here
emptyExcelFile.filename='./Tracula_QC_empty_withTMI_test.xlsx';%Please set your ABSOLUTE path here
emptyExcelFile.sheetname='Sheet1';
savedPath='./data/QC/Tracula/beforeEdit';%Please set your ABSOLUTE path to save the result
traculaPath='./data/Derivatives/Tracula/beforeEdit';%set up you ABSOLUTE Tracula path
%e.g., data structure should follow below
%./data/Derivatives/Tracula/beforeEdit/sub-01
%./data/Derivatives/Tracula/beforeEdit/sub-01/dlabel
%./data/Derivatives/Tracula/beforeEdit/sub-01/dmri
%./data/Derivatives/Tracula/beforeEdit/sub-01/dpath
%detectMethod='singleCurves';%method1: default, but you may miss some small tracts!  
detectMethod='singleCurvesAndSmall';%method2, will exclude small tracts besides single curves, but may casuse false alarm, so need to ask RAs to manally and visually recheck them
pathlist=['#lh.cst_AS 6##rh.cst_AS 6#'...
'#lh.ilf_AS 5##rh.ilf_AS 5#'...
'#lh.unc_AS 5##rh.unc_AS 5#'...
'#fmajor_PP 7##fminor_PP 5#'...
'#lh.atr_PP 5##rh.atr_PP 5#'...
'#lh.cab_PP 4##rh.cab_PP 4#'...
'#lh.ccg_PP 5##rh.ccg_PP 5#'...
'#lh.slfp_PP 5##rh.slfp_PP 5#'...
'#lh.slft_PP 5##rh.slft_PP 5#'];  
%_______________________________________________________________________________________

generateTagsOfSingleCurveTracts_auto(pathlist,projectTag,emptyExcelFile,savedPath,traculaPath,detectMethod,longitudinal,pathTemplate_father);
end%function generateTagsOfSingleCurveTracts_auto_OCD()
