PARTICLES=inputs/particles.256.txt
CTF=inputs/ctf.pkl
POSES=inputs/poses.pkl
IND=inputs/filtered.ind.pkl
OUTDIR='outputs'

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF -o $OUTDIR --ind $IND --zdim 10 --enc-dim 1024 --dec-dim 1024 --amp -n 50 --domain hartley > run.log &
