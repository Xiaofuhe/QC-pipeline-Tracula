function ras2vox_batch() 
% you need to firstly run generateTagsOfSingleCurveTracts_auto_batch.m

% Xiaofu He,07/15/2016
% Brain Imaging Lab
% Division of Child&Adolescent Psychiatry,
% Columbia University Medical Center
% email: xiaofuhe2008@yahoo.com

global globalCodePath; 
globalCodePath='./Steps4-6';%Please set your ABSOLUTE path here
addpath(genpath(globalCodePath));


%..........................after first time editing, manual QC..........................
%read the excel file 
filename='Tracula_QC_manual_comments.xlsx';%please put your excel file name here
pathPrefix='where did you save the results\Tracula_firstEdit\'; 
savedPath_father='where did you save the results\Tracula_beforeEdit';
tagType={'single curve','enlarged','bad','misplaced','weired','tilted','not centralized'}; %extract those columns which labeld 'enlarged', 'tiny' or others
%with tag='tiny' or 'worse_tiny'
detectResultTxtFile='singleCurveTracts_manual.txt';
edittedControlPointsSuffix='ras.dat';%depends on the instrucitons for RA when editing, e.g.,lh.cab_PP_avg33_mni_bbr_cpts_4ras.dat in ...\Tracula_beforeEdit\subjectID\dlabel\diff
%edittedControlPointsSuffix='ras_edit.dat';%e.g.,lh.cab_PP_avg33_mni_bbr_cpts_4ras_edit.dat in ..\Tracula_beforeEdit\subjectID\dlabel\diff
orgControlPointsSuffix='ras.dat';%original control point, e.g.,lh.cab_PP_avg33_mni_bbr_cpts_4ras.dat in Tracula_beforeEdit\subjectID\dlabel\diff


[num,txt,raw]=xlsread(filename);
[rowNum,colNum]=size(raw);
for ii=2:rowNum %exclude the first row of title
    searchSuffix=edittedControlPointsSuffix;%default;
    examNumCell=raw(ii,:); %load from the second row to the last 
    examNum_org=examNumCell{1}; %for 1111,1112 or 3662 and so on
    examNum_str=num2str(examNum_org);  
    [examNum_str]=replaceInString(examNum_str,'''','');  
    disp(['......processing ',examNum_str]);
    address=strcat(pathPrefix,examNum_str,'\dlabel\diff\'); %get the address
    if length(savedPath_father)>0
        savedPath=mkdirMy(savedPath_father,examNum_str,filesep);%e.g., strcat(savedPath_father,examNum_str,'\dlabel\diff\'); %get the address
        savedPath=mkdirMy(savedPath,'dlabel',filesep);
        savedPath=mkdirMy(savedPath,'diff',filesep);
    else
        savedPath=address;%i.e., save the result in the same folder
    end%end if 
    
    %method1: read the single curve tracts from the 'singleCurveTracts.txt',i.e, strcat(address,'singleCurveTracts.txt')
    
    %method2: read the single curve tracts from the excel file with tagType!  
    for kk=1:length(tagType) %extract by different tags
        tinyNum=find(strcmp(tagType(kk),examNumCell)); %get the "tiny" colNum
        tinyTractsCell=raw(1,tinyNum); %get the "tiny" tract name e.g.,  5103-lh.cab and 5111-rh.cab
        for jj=1:length(tinyTractsCell)
            tractName=regexp(cell2mat(tinyTractsCell(jj)),'-','split'); % e.g., split '5103-lh.cab' by '-'
%             address=strcat(pathPrefix,examNum_str,'\dlabel\diff\'); %get the address
% %             fprintf('%s\n',[address,cell2mat(tractName(2))]); %check the result
            
            %fileName=dir(strcat(address,cell2mat(tractName(2)),'*ras.dat')); %match the possible files under current address
            fileName=dir(strcat(address,cell2mat(tractName(2)),'*',searchSuffix)); %match the possible files under current address
            if (length(fileName)~=1) %no or more than one   
                %%error(['There are too many ',cell2mat(tractName(2)),'*ras.dat in the ',address]);
                %error(['There are too many or no ',cell2mat(tractName(2)),'*',edittedControlPointsSuffix,' in the ',address]);
                warningStr=['There are too many or no ',cell2mat(tractName(2)),'*',searchSuffix,' in the ',address];
                %warningStr=[warningStr+tempStr];
                warning(warningStr);
                %try use original control point
                searchSuffix=orgControlPointsSuffix;%change to original one!
                fileName=dir(strcat(address,cell2mat(tractName(2)),'*',searchSuffix)); %match the possible files under current address
            end%end if 
                
            if (length(fileName)~=1) %no or more than one                
                warningStr=['There are too many or no ',cell2mat(tractName(2)),'*',searchSuffix,' in the ',address];
                %warningStr=[warningStr+tempStr];
                warning(warningStr);
                continue;
            else
                txtFile=strcat(address,fileName(1).name);
                [tempPath,tempFile,tempExt]=fileparts(txtFile);%e.g., tempFile='lh.cab_PP_avg33_mni_bbr_cpts_4ras.dat'
                [tempFind]=findstr([tempFile,tempExt],searchSuffix);
                outputTxtFile=[savedPath,filesep,tempFile(1:tempFind-1),'.txt'];%i.e., without 'ras', e.g., lh.cab_PP_avg33_mni_bbr_cpts_4.txt from lh.cab_PP_avg33_mni_bbr_cpts_4ras.dat
                if exist(outputTxtFile,'file')
                    warning([outputTxtFile, ' already exists, so backup firstly in order to avoid overlapping!']);                
                    copyfile(outputTxtFile,[savedPath,filesep,tempFile(1:tempFind-1),'_org.txt']);%backup firstly
                end%end if                 
                imageFile=strcat(pathPrefix,examNum_str,'\dmri\dtifit_FA.nii.gz');
                ras2vox(imageFile,txtFile,outputTxtFile);
            end%end if        
        end %for jj
    end % for kk
    %hxf 9/26/2016 
    copyfile([address,filesep,detectResultTxtFile],[savedPath,filesep,detectResultTxtFile]); 
end % for ii



