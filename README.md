# cryodrgn_biorxiv2020

This repository contains input files and commands for reproducing the cryoDRGN heterogeneous reconstruction experiments in Zhong et al. (https://www.biorxiv.org/content/10.1101/2020.03.27.003871v1). 

The outputs of the experiments (trained models and reconstructed volumes), which are too large to put in a github repository, can be found on zenodo (link).

Each directory describes one of the analyzed datasets and all required inputs excluding particle images, which can be downloaded from EMPIAR (https://www.ebi.ac.uk/pdbe/emdb/empiar/). The associated command for running cryodrgn with software version 0.3.0 is provided in a `run.sh` executable.

## EMPIAR-10028: Pf80S ribosome

Primary reference: https://elifesciences.org/articles/03080

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

### Pre-procesing inputs

```

```

### Running cryoDRGN
```

```

## EMPIAR-10049: RAG1-RAG2 complex

Primary reference: 

### Pre-procesing inputs

```

```

### Running cryoDRGN
```

```

## EMPIAR-10049: RAG1-RAG2 complex

Primary reference: 

### Pre-procesing inputs

```

```

### Running cryoDRGN
```

```
