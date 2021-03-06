# Read Only Stratux

A very simple script to make a Stratux read-only and reduce the chances of your
filesystem becoming corrupted when the power is unplugged uncleanly. 

First, download the tarball (stratux-readonly-xxxx.tar.gz) of the latest release
from the following location and save it to your laptop/desktop computer:
https://github.com/bovine/stratux-readonly/releases

Power up your Stratux device and join your laptop/desktop computer
to the "stratux" WiFi network.

Transfer the saved tarball to 192.168.10.1 using scp,
logging in as user "pi" password "raspberry" and putting the file into
the directory /home/pi/ (Windows users can use WinSCP or another program
that supports scp)

    $ scp stratux-readonly-xxxx.tar.gz pi@192.168.10.1:/home/pi/

Now SSH into the stratux with the same password as above (Windows users can use Putty):

    $ ssh pi@192.168.10.1

Once connected by SSH, extract the tarball and run the setup.sh script:

    $ tar xvzf stratux-readonly-xxxx.tar.gz
    $ cd stratux-readonly-xxxx
    $ sudo ./setup.sh

If the installation appears successful you can reboot the Stratux with following:

    $ sudo reboot


