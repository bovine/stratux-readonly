# Read Only Pi

A very simple script to make a Pi read-only. Run this on your
desktop system and it will update the Pi. To do this:

First, copy your public key to the Pi's /etc/ssh/authorized_keys/root/ folder

    $ scp mykey.pub pi@[your pi's ip]:/etc/ssh/authorized_keys/root/

Next, set an environment variable for the Pi's IP address:

   $ export PIIP=10.0.1.70

Finally, run the setup.sh script:

    $ ./setup.sh


