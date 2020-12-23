#!/bin/sh

#####################################################
## Batch Command file for showing Tracula  output  ##
##     -Xiaofu He Feb 2, 2016                      ##
#####################################################

datapath='./data/Derivatives/Tracula/beforeEdit' #set you Tracula ouput path here
examlist='sub-01'

export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
for examI in  ${examlist}  
do
    echo -----exam#=${examI}--------------------------
    cd ${datapath}
    tracula_outputs_path=${examI}

   #step2 visualize tract by tract
   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/fmajor_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=fmajor \
            ${tracula_outputs_path}/dpath/fminor_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=fminor
 
   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.atr_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.atr \
            ${tracula_outputs_path}/dpath/lh.atr_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.atr
  
   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.cab_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.cab \
            ${tracula_outputs_path}/dpath/lh.cab_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.cab


   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.ccg_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.ccg \
            ${tracula_outputs_path}/dpath/lh.ccg_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.ccg
 
   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.cst_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.cst \
            ${tracula_outputs_path}/dpath/lh.cst_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.cst

   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.ilf \
            ${tracula_outputs_path}/dpath/lh.ilf_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.ilf
 
   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.slfp_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.slfp \
            ${tracula_outputs_path}/dpath/lh.slfp_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.slfp

   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.slft_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.slft \
            ${tracula_outputs_path}/dpath/lh.slft_PP_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.slft

   freeview -v ${tracula_outputs_path}/dmri/dtifit_FA.nii.gz \
            ${tracula_outputs_path}/dpath/rh.unc_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=rh.unc \
            ${tracula_outputs_path}/dpath/lh.unc_AS_avg33_mni_bbr/path.pd.nii.gz:colormap=jet:isosurface=0,0:color='Red':name=lh.unc

done #examI

