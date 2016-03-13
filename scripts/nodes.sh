
echo "otp" > /tmp/otp
# Add prelude-correlator
prelude-admin registration-server prelude-manager --no-confirm --passwd-file=/tmp/otp &

sleep 1

prelude-admin register prelude-correlator "idmef:rw admin:r" localhost --uid 0 --gid 0 --passwd-file=/tmp/otp

# Add prelude-lml
prelude-admin registration-server prelude-manager --no-confirm  --passwd-file=/tmp/otp & 

sleep 1

prelude-admin register prelude-lml "idmef:rw admin:r" localhost --uid 0 --gid 0 --passwd-file=/tmp/otp
