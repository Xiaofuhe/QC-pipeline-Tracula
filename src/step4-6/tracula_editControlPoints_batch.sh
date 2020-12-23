#!/bin/sh

#####################################################
##     Xiaofu He November 1st,2018                 ##
##     editing control points for abnormal tracts  ##
#####################################################

datapath='./data/Derivatives/Tracula/afterEdit' #set you Tracula ouput path here
examlist='sub-01' #set your exam list here
abnormalTractTextFile='singleCurveTracts_manual.txt' #e.g., based on manually and visually qc result

export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
for examI in  ${examlist}  
do
    echo -----exam#=${examI}--------------------------
    cd ${datapath}
    echo `pwd`
    tracula_outputs_path=${examI}
    source read_file.sh ${tracula_outputs_path}/dlabel/diff/${abnormalTractTextFile}	
    echo "${pathlist[*]}"
    echo "${ncpts[*]}"
    #cd ${tracula_outputs_path}/dlabel/diff
   singleTractNum=${#pathlist[@]}
   for ((i = 0 ;  i < ${singleTractNum};  i++  ))
   do
      singleCurveTract=${pathlist[i]}
      controlPoint=${ncpts[i]}
      echo "i=$i, $singleCurveTract, $controlPoint"

   case "${singleCurveTract}" in 
       "fmajor_PP" | "fminor_PP")  echo "#......${singleCurveTract}......"           
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/fmajor_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=fmajor \
            ${tracula_outputs_path}/dpath/fminor_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=fminor \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5' 
	   ;;
       "rh.atr_PP" | "lh.atr_PP")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.atr_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.atr \
            ${tracula_outputs_path}/dpath/lh.atr_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.atr \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
	   ;;
       "rh.cab_PP" | "lh.cab_PP")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.cab_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.cab \
            ${tracula_outputs_path}/dpath/lh.cab_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.cab \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
 	   ;;
       "rh.ccg_PP" | "lh.ccg_PP")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.ccg_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.ccg \
            ${tracula_outputs_path}/dpath/lh.ccg_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.ccg \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5' 
 	   ;;
       "rh.cst_AS" | "lh.cst_AS")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.cst_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.cst \
            ${tracula_outputs_path}/dpath/lh.cst_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.cst \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
	   ;;
       "rh.ilf_AS" | "lh.ilf_AS")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.ilf \
            ${tracula_outputs_path}/dpath/lh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.ilf \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
 	   ;;
       "rh.slfp_PP" | "lh.slfp_PP")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.slfp_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.slfp \
            ${tracula_outputs_path}/dpath/lh.slfp_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.slfp \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
 	   ;;
       "rh.slft_PP" | "lh.slft_PP")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.slft_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.slft \
            ${tracula_outputs_path}/dpath/lh.slft_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.slft \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
	   ;;
       "rh.unc_AS" | "lh.unc_AS")  echo "#......${singleCurveTract}......"
	   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            -v ${tracula_outputs_path}/dlabel/diff/aparc+aseg.bbr.nii.gz:colormap=lut:opacity=0.2 \
            ${tracula_outputs_path}/dpath/rh.unc_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.unc \
            ${tracula_outputs_path}/dpath/lh.unc_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.unc \
	    -c ${tracula_outputs_path}/dlabel/diff/${singleCurveTract}_avg33_mni_bbr_cpts_${controlPoint}ras.dat:color='Red':radius='5'
	   ;;
       *)  echo "INVALID tract name=${singleCurveTract}!" 
	   #exit
	   ;;
   esac
   done #for i
done #examI

