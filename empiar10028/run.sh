PARTICLES=inputs/particles.256.txt
POSES=inputs/poses.pkl
CTF=inputs/ctf.pkl
IND=filtered.ind.pkl
OUTDIR='outputs' # rename as desired

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF --ind $IND -o $OUTDIR --zdim 8 --enc-dim 1024 --dec-dim 1024 --amp -n 25 > run.log &
