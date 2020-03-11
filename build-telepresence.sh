#!/bin/bash

BUILD_LIBS=${HOME}/telecom/build_libs
DOUBANGO_INC=${HOME}/telecom/doubango/doubango/bindings/_common
 
export PATH=${BUILD_LIBS}/bin:${PATH}
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${BUILD_LIBS}/lib/pkgconfig:${PKG_CONFIG_PATH}
 
make clean

# autoreconf -fiv
 
if [ ! -d tinywrap ]; then
    mkdir tinywrap
    cp ${DOUBANGO_INC}/* tinywrap
fi

./autogen.sh
 
./configure \
      --prefix=${BUILD_LIBS} \
     CFLAGS="-I${BUILD_LIBS}/include -I${DOUBANGO_INC}" \
   CXXFLAGS="-I${BUILD_LIBS}/include -I${DOUBANGO_INC}" \
    LDFLAGS="-L${BUILD_LIBS}/lib -L/usr/lib/x86_64-linux-gnu" \
       LIBS="-lsrtp -lssl -lcrypto -ldl -lpthread" 

make 
make install
