PARTICLES=inputs/particles.256.txt
CTF=inputs/ctf.pkl
POSES=inputs/poses.pkl
IND=inputs/filtered.ind.pkl
OUTDIR=outputs

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --ctf $CTF --poses $POSES --ind $IND -o $OUTDIR --zdim 10 -n 50 --enc-dim 1024 --dec-dim 1024 --amp > run.log &
