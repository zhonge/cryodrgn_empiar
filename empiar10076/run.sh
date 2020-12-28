PARTICLES=inputs/particles.256.txt
CTF=inputs/ctf.pkl
POSES=inputs/poses.pkl
IND=inputs/filtered.ind.pkl
OUTDIR='outputs' # rename as desired

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF --ind $IND -o $OUTDIR --zdim 8 --enc-dim 1024 --dec-dim 1024 --amp -n 50 > run.log &
