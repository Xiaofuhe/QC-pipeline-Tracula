function showFAandColorMap_batch()
%based on showFAandColorMap_GUI.m but automatically generate CFA and FA maps  that RAs can check the qc of CFA manually and visually

% show FA and colormap in a batch
% if you want to show CFA image only, please use showFAColorMap_basedonCMP_batch.m which is based on .cmp file, faster than this function since it need to generate CFA,FA,MD..from .d file
% similar with showFAandColorMap_GUI which is only show one data
% help:
%.....use downarrow  (slice#-1) and uparrow (slice#+1) in the direction keys to control slice number
%.....use 'Escape' key to exit
%.....use 's' key to save the DAI image based on the suffix(e.g.,*_CFA.bmp, *_FA.bmp,*_MD.bmp, *_ADC.bmp)
%.....use 'a' key to save all the slices of DAI images based on the suffix (e.g., *_CFA.bmp, *_FA.bmp,*_MD.bmp, *_ADC.bmp)
%.....use '2' to flip Y direction
%.....use 'c' key to crop images, in order to show all colored FA slices into one large image

% Xiaofu He,12/18/2020
% Division of Child&Adolescent Psychiatry,
% Columbia University Medical Center
% email: xiaofuhe2008@yahoo.com

global globalCodePath;%will be used in showDiffusiionAnisotropyIndices.m at line#40
globalCodePath='./Step2';%please set your ABSOLUTE path here
addpath(genpath(globalCodePath));

examParameter.examDataPath='./data/Derivatives/Eddy';%set your ABSOLUTE data path here
savedpath='./data/QC/CFA';%please set a ABSOLUTE path where you want to save the result
examParameter.examNumCell={'sub-01'};%set the exam list here
examParameter.ifAllExamsSavedInOneFolder=0;%you didn't save all data in one folder
%examParameter.existSecondLevel=0;% e.g., /sub-01/sub-01_dwi_eddy_tensor.nii.gz
examParameter.existSecondLevel=1;%e.g., /sub-01/FDT/sub-01_dwi_eddy_tensor.nii.gz
examParameter.subPath='FDT';

tempCD=cd;
examParameter.maskPath=[];%default no mask path, will auto load it below
showPara.savedImagePath=savedpath;
showPara.ifAutoSave=1;%autosave some maps
showPara.ifSaveCFA=1;%save CFA only which will speed up! but will only work for '.d' file instead of '.mat' which DAIdata was already generated
                     %so, you may regenerate '.mat' by set ifSaveDAI=1

examParameter.tensorSuffix='_eddy_tensor.nii.gz';%e.g., /sub-01/FDT/sub-01_dwi_eddy_tensor.nii.gz
examParameter.maskSuffix='_eddy_b0_noskull.nii.gz';%e.g., /sub-01/FDT/sub-01_dwi_eddy_b0_noskull.nii.gz
examParameter.analyzeHeadSuffix='';%don't need it for displaying a fsl tensor
tensorFormat='FSL';%suppose you get the tensor file through FSL, i.e., upper triangular, i.e., Dxx,Dxy,Dxz,Dyy,Dyz,and Dzz

examParameter.examAndSeriesNum=[];
tempCD=cd;
seriesCount=0;
for examI=1:length(examParameter.examNumCell)  
    examNum=examParameter.examNumCell{examI};
    tempFiles=dir([examParameter.examDataPath,filesep,examNum,'*']);%e.g.,'./data/Eddy/sub-01
    
    notFoundExam=1;
    for tempI=1:length(tempFiles)
        tempFound=0;
        if (examParameter.ifAllExamsSavedInOneFolder) 
            tempFound=1;
            pathName=examParameter.examDataPath;
        else
            if (tempFiles(tempI).isdir)
                tempFound=1;
                disp(['Processing....exam#',examNum,' in ',examParameter.examDataPath]);
                if (examParameter.existSecondLevel)%hxf 12/21/2013
                    pathName=[examParameter.examDataPath,filesep,tempFiles(tempI).name,filesep,examParameter.subPath];%for SUD and OCD, e.g., D:\dataprocess\shared\SUD\DICCCOL\SUD_71-0175-10\FDT
                else
                    pathName=[examParameter.examDataPath,filesep,tempFiles(tempI).name];
                end%end if  
            end%end if            
        end%end if 
        
        if (tempFound)
            tempSeriesFiles=dir([pathName,filesep,examNum,'*',examParameter.tensorSuffix]);%for examParameter.ifAllExamsSavedInOneFolder=1, tempSeriesFiles is equal to tempFiles
            for seriesI=1:length(tempSeriesFiles)
                tempSeriesFilesNameCell{seriesI}=tempSeriesFiles(seriesI).name;%will be used in getCertainIndex()
            end%end for seriesI
            if (length(tempSeriesFiles)<1)
                continue;
            end%end if 
            seriesI=1;%initial
            while (seriesI>0&&seriesI<=length(tempSeriesFiles))%since need to use examI to control the selection
            %for seriesI=1:length(tempSeriesFiles)
                if (~showPara.ifAutoSave)%hxf 1/23/2018
                    disp('...please input a key....');
                    [seriesI]=getCertainIndex(tempSeriesFilesNameCell,seriesI);
                    if (seriesI<0)
                        break;
                    end%end if 
                end%end if 
                
                fullfileName=[pathName,filesep,tempSeriesFiles(seriesI).name];
                tempIndex=findstr(tempSeriesFiles(seriesI).name,examParameter.tensorSuffix);                
                examAndSeriesNum=tempSeriesFiles(seriesI).name(1:tempIndex-1);

                cd(tempCD);%in order to use outlierDetection_colorFA_each.m
                seriesCount=seriesCount+1;
                disp(['..............exam#',examAndSeriesNum,'.............']);
                examParameter.examAndSeriesNum{seriesCount}=examAndSeriesNum;                 
       
                [path,filename,ext] = fileparts(fullfileName);
                
                %hxf 6/2/2014               
                if length(examParameter.maskPath)<1
                    maskPath=pathName;%use default mask path
                else
                    maskPath=[examParameter.maskPath,filesep,tempFiles(tempI).name,filesep,examParameter.maskPath_sub];
                end%end if   
                
                switch ext
                    case {'.gz','.nii'}%for processing fsl result! 
                        maskFileFullname =[maskPath,filesep,examAndSeriesNum,examParameter.maskSuffix];                        
                        showFAandColorMap(fullfileName,maskFileFullname,tensorFormat,showPara);
                    otherwise
                        error('The file type is not supported in this function!');
                end%end if
                notFoundExam=0; 
                seriesI=seriesI+1;%important!!!
            end%end  while 
        end%end if (tempFiles(tempI).isdir)
    end%end if 
    if (notFoundExam)
        %error('Can not find the related exam in the train path!');
        disp(['Can not find the related exam# ',examNum,' files in ',examParameter.examDataPath]);
        detectionResult{examI}=[];
    end%end for tempI 
    examI=examI+1;%important!!!
end%for while
clear examParameter;

end%end function showFAandColorMap_batch()

