function showFAandColorMap_GUI()
% show FA and colormap in a in a gui mode, i.e use GUI to load the data
%usage: show color FA image which is based on *.d  
%note: if you want to show only gray FA, please use MRIcro or FSLeyes
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
% email: DTIQC2020@yahoo.com


global globalCodePath;%will be used in showDiffusiionAnisotropyIndices.m at line#40
globalCodePath='./Step2';%please set your ABSOLUTE path here
addpath(genpath(globalCodePath));


cellCount=0;
cellCount=cellCount+1;
initialPathCell{cellCount}='./data/Derivatives/Eddy/sub-01/FDT';%set your ABSOLUTE data path here
maskPathCell{cellCount}=[];%no mask path, will load it in the GUI

tempCD=cd;
tensorFormat='FSL';%suppose you get the tensor file through FSL, i.e., upper triangular, i.e., Dxx,Dxy,Dxz,Dyy,Dyz,and Dzz

for i=1:length(initialPathCell)
    initialPath=initialPathCell{i};
    maskPath=maskPathCell{i};%hxf 6/2/2014
    cd(initialPath);%initial path
    fileName='temp';
    while ~strcmpi(fileName,'')
         [fileName,pathName,FilterIndex] = uigetfile({'*tensor*.*'},'Select a tensor file (*tensor*.*, *.d or *.mat)');%since *.mat is rare
        
        if (fileName==0)
            fileName='';
            break;
        end%end if 
        fullfileName=[pathName,filesep,fileName];

        [path,filename,ext] = fileparts(fullfileName);
        
        %hxf 6/2/2014
        if length(maskPath)<1
            maskPath=pathName;%use default mask path
        end%end if 
       
        switch ext
            case {'.gz','.nii'}%for processing fsl result!                
                maskFileFullname=selectACertainFileByDlg(maskPath,{'*b0_noskull.*';'*brain_mask.*';'*brainMask.*'},['Select a mask file for ',filename,ext]);
                showFAandColorMap(fullfileName,maskFileFullname,tensorFormat)
            otherwise
                error('The file type is not supported in this function!');
        end%end if
        cd(initialPath);%initial path
    end%end while
    cd(initialPath);%initial path       
end%for i
cd(tempCD); 
clear;
end%end function showFAandColorMap_GUI()