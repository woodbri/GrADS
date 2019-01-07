#!/bin/sh
export LD_LIBRARY_PATH=/home/woodbri/work/grads/grads-2.2.1/lib
export GAUDPT=/home/woodbri/work/grads/grads-2.2.1/lib/udpt
export GADDIR=/home/woodbri/work/grads/grads-2.2.1/data

echo 'Content-Type: application/json'
echo
python $*  # 2>&1  > /dev/null
