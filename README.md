# cryodrgn_biorxiv2020

This repository contains input files and commands for reproducing the cryoDRGN heterogeneous reconstruction experiments in [Zhong et al](https://www.biorxiv.org/content/10.1101/2020.03.27.003871v1). 

Each directory describes one of the analyzed datasets and all required inputs excluding particle images, which can be downloaded from [EMPIAR](https://www.ebi.ac.uk/pdbe/emdb/empiar/). 
The commands provided here are compatible with cryodrgn version 0.3.0. The commands that were used to preprocess the input files are described in a `README` file in the `inputs` directory. The command to run cryodrgn is provided in the `run.sh` executable.

The outputs of the experiments (trained models and reconstructed volumes), which are too large to put in a github repository, can be found on zenodo (link).

## EMPIAR-10028: Pf80S ribosome

Primary reference: 
[Wong, W. et al. Cryo-EM structure of the Plasmodium falciparum 80S ribosome bound to the anti-protozoan drug emetine. Elife 3, e01963 (2014).](https://elifesciences.org/articles/03080)

### Pre-procesing inputs

```
$ cat empiar10028/inputs/README
# This directory contains all input files for cryodrgn training except for the particle stack from EMPIAR-10028

# Download EMPIAR-10028 particles, then move the downloaded .mrcs files to this directory
ascp -QT -l 200M -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh emp_ext3@hx-fasp-1.ebi.ac.uk:/10028 .

# Downsample dataset
cryodrgn downsample shiny_2sets.star --datadir 10028/data -D 256 -o particles.256.mrcs -D 50000

# Extract pose and ctf information from cryoSPARC refinement
cryodrgn parse_ctf_csparc cryosparc_P11_J4_003_particles.cs -o ctf.pkl
cryodrgn parse_pose_csparc cryosparc_P11_J4_003_particles.cs -D 360 -o poses.pkl
```

### Running cryoDRGN
```
$ cat empiar10028/run.sh
PARTICLES=inputs/particles.256.txt
POSES=inputs/poses.pkl
CTF=inputs/ctf.pkl
IND=filtered.ind.pkl
OUTDIR='outputs'

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF --ind $IND -o $OUTDIR --zdim 10 --enc-dim 1024 --dec-dim 1024 --amp -n 50 --domain hartley > run.log &
```

## EMPIAR-10049: RAG1-RAG2 complex

Primary reference: 
[Ru, H. et al. Molecular Mechanism of V(D)J Recombination from Synaptic RAG1-RAG2 Complex Structures. Cell 163, 1138–1152 (2015).](https://pubmed.ncbi.nlm.nih.gov/26548953/)

### Pre-procesing inputs

```
$ cat empiar10049/inputs/README
# This directory contains all input files for cryodrgn training except for the particle stack from EMPIAR-10049

# Download EMPIAR-10049 particles, then move the downloaded .mrcs files to this directory
ascp -QT -l 200M -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh emp_ext3@hx-fasp-1.ebi.ac.uk:/10049 .
mv 10049/data/ragSEC_150309.mrcs .
mv 10049/data/ragSEC_150311.mrcs .

# Extract pose and ctf information from cryoSPARC refinement
cryodrgn parse_ctf_csparc cryosparc_P53_J26_006_particles.cs -o ctf.pkl
cryodrgn parse_pose_csparc cryosparc_P53_J26_006_particles.cs -D 192 -o poses.pkl
```

### Running cryoDRGN
```
$ cat empiar10049/run.sh
PARTICLES=inputs/allimg.star
POSES=inputs/poses.pkl
CTF=inputs/ctf.pkl
OUTDIR='outputs'

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF -o $OUTDIR --zdim 10 --enc-dim 1024 --dec-dim 1024 --amp -n 50 --domain hartley > run.log &
```

## EMPIAR-10076: Assembling bacterial 50S ribosome

Primary reference: 
[Davis, J. H. et al. Modular Assembly of the Bacterial Large Ribosomal Subunit. Cell 167, 1610--1622.e15 (2016).](https://pubmed.ncbi.nlm.nih.gov/27912064/)

### Pre-procesing inputs

```
$ cat empiar10076/inputs/README
# This directory contains all input files for cryodrgn training except for the particle stack from EMPIAR-10076

# Download EMPIAR-10076 particles, then move the downloaded .mrc file to this directory
ascp -QT -l 200M -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh emp_ext3@hx-fasp-1.ebi.ac.uk:/10076 .
mv 10076/data/L17Combine_weight_local.mrc L17Combine_weight_local.mrcs

# Downsample images to D=256
cryodrgn downsample Parameters.star -D 256 -o particles.256.mrcs --chunk 50000

# Extract pose and ctf information from cryoSPARC refinement
cryodrgn parse_ctf_csparc cryosparc_P4_J33_004_particles.cs -o ctf.pkl
cryodrgn parse_pose_csparc cryosparc_P4_J33_004_particles.cs -D 320 -o poses.pkl
```

### Running cryoDRGN
```
$ cat empiar10076/run.sh
PARTICLES=inputs/particles.256.txt
CTF=inputs/ctf.pkl
POSES=inputs/poses.pkl
IND=inputs/filtered.ind.pkl
OUTDIR=outputs

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --ctf $CTF --poses $POSES --ind $IND -o $OUTDIR --zdim 10 -n 50 --enc-dim 1024 --dec-dim 1024 --amp > run.log &
```

## EMPIAR-10180: Pre-catalytic spliceosome

Primary reference: 
[Plaschka, C., Lin, P.-C. & Nagai, K. Structure of a pre-catalytic spliceosome. Nature 546, 617–621 (2017).](https://www.nature.com/articles/nature22799)

### Pre-procesing inputs

```
$ cat empiar10180/inputs/README
# This directory contains all input files for cryodrgn training except for the particle stack from EMPIAR-10180

# Download EMPIAR-10180 particles, then move the downloaded .star file to this directory
ascp -QT -l 200M -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh emp_ext3@hx-fasp-1.ebi.ac.uk:/10180 .
mv 10180/data/Example/consensus_data.star .

# Downsample to D=256
cryodrgn dowsample consensus_data.star --datadir 10180/data -D 256 -o particles.256.mrcs --chunk 50000

# Extract pose and ctf information from RELION consensus refinement
cryodrgn parse_pose_star consensus_data.star -D 320 -o poses.pkl 
cryodrgn parse_ctf_star consensus_data.star -D 320 --Apix 1.7 -o ctf.pkl 
```

### Running cryoDRGN
```
$ cat empiar10180/run.sh
PARTICLES=inputs/particles.256.txt
CTF=inputs/ctf.pkl
POSES=inputs/poses.pkl
IND=inputs/filtered.ind.pkl
OUTDIR='outputs'

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF -o $OUTDIR --ind $IND --zdim 10 --enc-dim 1024 --dec-dim 1024 --amp -n 50 --domain hartley > run.log &
```
