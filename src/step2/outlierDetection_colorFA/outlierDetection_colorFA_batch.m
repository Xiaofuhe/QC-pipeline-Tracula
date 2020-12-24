function outlierDetection_colorFA_batch()
%similar to outlierDetection_colorFA_GUI.m but this function runs in the batch mode

%Usage:detect the outlier based on the FA color map which is generated from tensor file 

%input examParameter: 
%......imgFullName: the full file name of the image which includes path
%......maskFullName: the full file name of the mask which includes path
%output examParameter:
%......detectionResult
%.....................imgQuality: the quality of the input image
%.....................measureMatrix: the measurement value for other directions
%.....................timeElapsed: the measurement value for other directions
%.....................measureMethod: same to input examParameter
%.....................calRefImgMethod: same to input examParameter

% Xiaofu He
% Brain Imaging Lab
% Division of Child&Adolescent Psychiatry,
% Columbia University Medical Center
% email: DTIQC2020@yahoo.com 

global globalCodePath; 
globalCodePath='./Step2';%please put your ABSOLUTE script path here
addpath(genpath(globalCodePath));

% %e.g.,
savedFilePrefix='allSubs';%all subjects
%examParameter.savedPath='';%don't save the result
examParameter.savedPath='./data/QC';%please set your ABSOLUTE path here
examParameter.examDataPath='./data/Derivatives/Eddy';%please set your ABSOLUTE data path here
examParameter.examNumCell={'sub-01'};%set your exam list here
examParameter.existSecondLevel=1;%e.g., ./data/Eddy/sub-01/FDT
examParameter.subPath='FDT';%e.g., ./data/Eddy/sub-01/FDT
examParameter.tensorSuffix='_eddy_tensor.nii.gz';%e.g., /sub-01/FDT//sub-01_dwi_eddy_tensor.nii.gz
examParameter.maskSuffix='_eddy_b0_noskull.nii.gz';%e.g.,FSL seg result, e.g., /sub-01/FDT/sub-01_dwi_eddy_b0_noskull.nii.gz

%for your study, please train the threshold firstly. The threshold below is following He 2014 paper: if mean or mean/std is greater than a threshold defined below, then the CFA image will be marked as bad
detectionPara.measureMethodCell={'Lab_meanByStd'};
detectionPara.LabThresholdCell={[14.3603 0.5693 NaN]};%for mean, mean/std, and zscore threshold respectively, NaN means we don't use this feature in the He 2014 paper
 
%detectionPara.badSlicesPercentThreshold=1;%too strict, will cause too high FRRs, 1% which means if exists even one bad slice, then label this subject's CFA image as bad!
detectionPara.badSlicesPercentThreshold=5;% if exists 5% bad slices, then label this subject's data as bad!
% %detectionPara.badSlicesPercentThreshold=20;%too loose, will cause too high FARs 

examParameter.examAndSeriesNum=[];
tempCD=cd;
seriesCount=0;
for examI=1:length(examParameter.examNumCell)
    examNum=examParameter.examNumCell{examI};    
    tempFiles=dir([examParameter.examDataPath,filesep,examNum,'*']);
    notFoundExam=1;
    for tempI=1:length(tempFiles)
        if (tempFiles(tempI).isdir)
            disp(['Processing....exam# ',examNum,' in ',examParameter.examDataPath]);
            %error([examParameter.useSeriesTag,' is not available']);
            if (examParameter.existSecondLevel)%hxf 12/21/2013
                pathName=[examParameter.examDataPath,filesep,tempFiles(tempI).name,filesep,examParameter.subPath];                
            else
                pathName=[examParameter.examDataPath,filesep,tempFiles(tempI).name];
            end%end if                         

            tempSeriesFiles=dir([pathName,filesep,examNum,'*',examParameter.tensorSuffix]);
            for seriesI=1:length(tempSeriesFiles)               
                fullfileName=[pathName,filesep,tempSeriesFiles(seriesI).name];
                tempIndex=findstr(tempSeriesFiles(seriesI).name,examParameter.tensorSuffix);                
                examAndSeriesNum=tempSeriesFiles(seriesI).name(1:tempIndex-1);
                                
                maskFileFullname =[pathName,filesep,examAndSeriesNum,examParameter.maskSuffix];

                cd(tempCD);%in order to use outlierDetection_colorFA_each.m
                seriesCount=seriesCount+1;
                disp(['..............exam# ',examAndSeriesNum,'.............']);
                examParameter.examAndSeriesNum{seriesCount}=examAndSeriesNum;
                detectionResult{seriesCount}=outlierDetection_colorFA_each(detectionPara,examParameter.savedPath,fullfileName,maskFileFullname);%dont save the result in this function() if you set examParameter.savedPath=''
                %detectionResult{seriesCount}=[];
                notFoundExam=0; 
            end%end if 
        end%end if (tempFiles(tempI).isdir)
    end%end if 
    if (notFoundExam)
        %error('Can not find the related exam in the train path!');
        disp(['Can not find the related exam#',examNum,' files in ',examParameter.examDataPath]);
        detectionResult{examI}=[];
    end%end for tempI 
end%for examI

if (~notFoundExam)
    measurePara=detectionResult{1}(1).measurePara;
    if (measurePara.ifUseImgMask)
        if (measurePara.ifUseInscribedImg)
            save([examParameter.savedPath,filesep,savedFilePrefix,'_Outlier_useMaskAndInscribedImg'], 'detectionResult','examParameter');
        else
            save([examParameter.savedPath,filesep,savedFilePrefix,'_Outlier_useMask'], 'detectionResult','examParameter');
        end%end if 
    else
        save([examParameter.savedPath,filesep,savedFilePrefix,'_Outlier'], 'detectionResult','examParameter');
    end%end if 
    clear measurePara;
end%end if 
end%end function outlierDetection_colorFA_batch()
