# Building on Ubuntu 18.04

I had to hack the build environment to be able to condifure, compile and link on Ubuntu 18.04. The following is a summary of the changes that I had to do to get a build.

1. made changes to configure.ac
2. made a change to m4/ga\_lib\_readline.m4 to remove editline
3. installed various missing ubuntu \*-dev packages
4. copied libpng15 from supplibs to /usr/lib as follows
6. change libpng15.la for install in /usr/lib
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
5. run ``unbuntu/doit`` to configure (edit the paths for your environment)
6. make
7. resolve any problems, most likely caused by missing \*-dev packages
8. sudo install
9. create ``/usr/local/lib/grads/udpt`` file like following but change the abs path to your directory
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
10. if you want gradspy for python 2.7 then
```
cd src
sudo python setup.py install
```
11. sanity check your build will start (change paths for your environment)
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

