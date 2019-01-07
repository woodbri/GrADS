# Building on Ubuntu 16.04

I had to hack the build environment to be able to condifure, compile and link on Ubuntu 16.04. The following is a summary of the changes that I had to do to get a build.

1. made changes to configure.ac
2. made a change to m4/ga\_lib\_readline.m4 to remove editline
3. installed various missing ubuntu \*-dev packages
4. copied libpng15 from supplibs to /usr/lib as follows
```
sudo cp ubuntu/supplibs/libpng15\* /usr/lib
pushd /usr/lib
sudo ln -s libpng15.so.15.12.0 libpng15.so.15
sudo ln -s libpng15.so.15 libpng15.so
popd
# also symlinked libhdf5.so into supplibs so it is found when linking
cd ubuntu/supplibs
sudo ln -s /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so
cd ../../..
# symlink supplibs above GrADS directory
ln -s GrADS/ubuntu/supplibs
cd GrADS
```
5. run ``unbuntu/doit`` to configure (edit the paths for your environment)
6. sudo make
7. resolve any problems, most likely caused by missing \*-dev packages
8. sudo install
9. create ``lib/udpt`` file like following but change the abs path to your directory
```
# Type     Name     Full path to shared object file
# ----     ----     -------------------------------
gxdisplay  Cairo    /home/woodbri/work/grads/grads-2.2.1/lib/libgxdCairo.so
gxdisplay  X11      /home/woodbri/work/grads/grads-2.2.1/lib/libgxdX11.so
gxdisplay  gxdummy  /home/woodbri/work/grads/grads-2.2.1/lib/libgxdummy.so
*
gxprint    Cairo    /home/woodbri/work/grads/grads-2.2.1/lib/libgxpCairo.so
gxprint    GD       /home/woodbri/work/grads/grads-2.2.1/lib/libgxpGD.so
gxprint    gxdummy  /home/woodbri/work/grads/grads-2.2.1/lib/libgxdummy.so
```
10. if you want gradspy for python 2.7 then
```
cd src
sudo python setup.py install
```
11. sanity check your build will start (change paths for your environment)
```
export LD_LIBRARY_PATH=/home/woodbri/work/grads/grads-2.2.1/lib
export GAUDPT=/home/woodbri/work/grads/grads-2.2.1/lib/udpt
export GADDIR=/home/woodbri/work/grads/grads-2.2.1/data

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

