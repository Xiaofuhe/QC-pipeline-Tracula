function outlierDetection_colorFA_GUI()
%Usage:detect the outlier based on the FA color map which was generated from tensor file  
 
%input parameter: 
%......imgFullName: the full file name of the image which includes path
%......maskFullName: the full file name of the mask which includes path
%output parameter:
%......detectionResult
%.....................imgQuality: the quality of the input image
%.....................measureMatrix: the measurement value for other directions
%.....................timeElapsed: the measurement value for other directions
%.....................measureMethod: same to input parameter
%.....................calRefImgMethod: same to input parameter

% Xiaofu He
% Brain Imaging Lab
% Division of Child&Adolescent Psychiatry,
% Columbia University Medical Center
% email: DTIQC2020@yahoo.com

global globalCodePath;
globalCodePath='./Step2';%Set your ABSOLUTE path here!
addpath(genpath(globalCodePath));

% %e.g.,
%savedPath='';%don't save the result
savedPath='./data/QC';%set your ABSOLUTE path to save outputs
iniDataPath='./data/Derivatives/Eddy/sub-01/FDT';%set your ABSOLUTE data path here

%for your study, please train the threshold firstly. The threshold below is following He 2014 paper: if mean or mean/std is greater than a threshold defined below, then the CFA image will be marked as bad
detectionPara.measureMethodCell={'Lab_meanByStd'};
detectionPara.LabThresholdCell={[14.3603 0.5693 NaN]};%for mean, mean/std, and zscore threshold respectively, NaN means we don't use this feature in the He 2014 paper

%detectionPara.badSlicesPercentThreshold=1;%too strict, will cause too high FRRs, 1% which means if exists even one bad slice, then label this subject's CFA image as bad!
detectionPara.badSlicesPercentThreshold=5;% if exists 5% bad slices, then label this subject's data as bad!
% %detectionPara.badSlicesPercentThreshold=20;%too loose, will cause too high FARs 
    
%get the tensor and mask files
tempCD=cd;
cd(iniDataPath);%initial path
fileName='temp';
while ~strcmpi(fileName,'')
    [fileName,pathName,FilterIndex] = uigetfile({'*tensor*.*'},'Select a tensor file (*tensor*.*)');
    if (fileName==0)
        fileName='';
        break;
    end%end if 
    fullfileName=[pathName,filesep,fileName];
    
    [path,filename,ext] = fileparts(fullfileName);
    switch ext
        case {'.gz','.nii'}%for processing fsl result!
            maskFileFullname=selectACertainFileByDlg(pathName,{'*b0_noskull.*';'*.seg.z';'*brain_mask.*';'*brainMask.*'},['Select a mask file for ',filename,ext]);
        otherwise
            error('The file type is not supported in this function!]');
    end%end if    
    cd(tempCD);%in order to use outlierDetection_colorFA_each.m
    [detectionResult]=outlierDetection_colorFA_each(detectionPara,savedPath,fullfileName,maskFileFullname);   
    cd(iniDataPath);%initial path
    clear detectionResult;
end%end while    
end%end function outlierDetection_colorFA_GUI()

