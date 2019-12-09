#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib
export GAUDPT=/usr/local/lib/grads/udpt
export GADDIR=/usr/local/share/grads/data

echo 'Content-Type: application/json'
echo
python $*  # 2>&1  > /dev/null
