# Building on Ubuntu 18.04

I had to hack the build environment to be able to condifure, compile and link on Ubuntu 18.04. The following is a summary of the changes that I had to do to get a build.

1. made changes to configure.ac
2. made a change to m4/ga\_lib\_readline.m4 to remove editline
3. installed various missing ubuntu \*-dev packages
4. copied libpng15 from supplibs to /usr/lib as follows
5. change libpng15.la for install in /usr/lib
6. create symlink for libhdf5.so as follows
```
sudo cp ubuntu/supplibs/libpng15\* /usr/lib
pushd /usr/lib
sudo ln -s libpng15.so.15.12.0 libpng15.so.15
sudo ln -s libpng15.so.15 libpng15.so

cd /usr/lib/x86_64-linux-gnu/
sudo ln -s libhdf5_serial.so.100 libhdf5.so

popd

# symlink supplibs above GrADS directory
cd ..
ln -s GrADS/ubuntu/supplibs
cd GrADS
```

My default package repository did not include Jasper library packages, so:
```
# check to see if you have them and install them
apt-cache search libjasper-dev

# if not then
sudo echo 'deb http://ftp.fau.de/trinity/trinity-builddeps-r14.0.0/ubuntu/ bionic main' >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.quickbuild.io --recv-keys F5CFC95C
sudo apt-get update
sudo apt-get install libjasper-dev

# or you can download the .deb files with:
wget http://ftp.fau.de/trinity/trinity-builddeps-r14.0.0/ubuntu/pool/main/j/jasper/libjasper-dev_1.900.1-debian1-2.5ubuntu18.04.0+5_amd64.deb
wget http://ftp.fau.de/trinity/trinity-builddeps-r14.0.0/ubuntu/pool/main/j/jasper/libjasper1_1.900.1-debian1-2.5ubuntu18.04.0+5_amd64.deb

# and install them with:
sudo dpkg -i libjasper1_1.900.1-debian1-2.5ubuntu18.04.0+5_amd64.deb libjasper-dev_1.900.1-debian1-2.5ubuntu18.04.0+5_amd64.deb

Adding them to the package manager means they will get updated if changes are made available for them.
```


7. run ``unbuntu/doit`` to configure (edit the paths for your environment)
8. make
9. resolve any problems, most likely caused by missing \*-dev packages
10. sudo install
11. create ``/usr/local/lib/grads/udpt`` file like following but change the abs path to your directory

```
# Type     Name     Full path to shared object file
# ----     ----     -------------------------------
gxdisplay  Cairo    /usr/local/lib/libgxdCairo.so
gxdisplay  X11      /usr/local/lib/libgxdX11.so
gxdisplay  gxdummy  /usr/local/lib/libgxdummy.so
*
gxprint    Cairo    /usr/local/lib/libgxpCairo.so
gxprint    GD       /usr/local/lib/libgxpGD.so
gxprint    gxdummy  /usr/local/lib/libgxdummy.so
```

12. if you want gradspy for python 2.7 then
```
cd src
sudo python setup.py install
```
13. sanity check your build will start (change paths for your environment)
```
export LD_LIBRARY_PATH=/usr/local/lib
export GAUDPT=/usr/local/lib/grads/udpt
export GADDIR=/usr/local/share/grads/data

grads -bl
q config
q gxconfig
quit

python
import gradspy
gradspy.start('-bl')
gradspy.cmd('q config')
quit()
```

