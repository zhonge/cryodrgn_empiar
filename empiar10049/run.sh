PARTICLES=inputs/allimg.star
POSES=inputs/poses.pkl
CTF=inputs/ctf.pkl
OUTDIR='outputs'

# To run with cryodrgn version 0.3.0
cryodrgn train_vae $PARTICLES --poses $POSES --ctf $CTF -o $OUTDIR --zdim 10 --enc-dim 1024 --dec-dim 1024 --amp -n 50 --domain hartley > run.log &
