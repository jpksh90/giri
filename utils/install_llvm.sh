#!/bin/bash

# USAGE: export LLVM_HOME=llvm && $0 [VERSION]

if [ "giri$LLVM_HOME" == "giri" ]; then
	echo "Please set the LLVM_HOME env!"
	exit 1
fi

VERSION=3.4
[ $# -ge 1 ] && VERSION=$1
case $VERSION in
        "3.1")
                ;;
        "3.4")
                wget http://llvm.org/releases/3.4/clang-3.4.src.tar.gz
                wget http://llvm.org/releases/3.4/llvm-3.4.src.tar.gz
                wget http://llvm.org/releases/3.4/compiler-rt-3.4.src.tar.gz
                tar xf llvm-3.4.src.tar.gz && rm -f llvm-3.4.src.tar.gz 
                tar xf clang-3.4.src.tar.gz && rm -f clang-3.4.src.tar.gz 
                tar xf compiler-rt-3.4.src.tar.gz && rm -f compiler-rt-3.4.src.tar.gz
                mv llvm-3.4 $LLVM_HOME
                mv clang-3.4 $LLVM_HOME/tools/clang
                mv compiler-rt-3.4 $LLVM_HOME/projects/compiler-rt
				;;
		"11.0")
				wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-11.0.0.src.tar.xz
				wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/llvm-11.0.0.src.tar.xz
				wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/compiler-rt-11.0.0.src.tar.xz
				tar xf clang-11.0.0.src.tar.xz && rm -f clang-11.0.0.src.tar.xz
				tar xf llvm-11.0.0.src.tar.xz && rm -f llvm-11.0.0.src.tar.xz
				tar xf compiler-rt-11.0.0.src.tar.xz && rm -f compiler-rt-11.0.0.src.tar.xz
				mv llvm-11.0.0.src $LLVM_HOME
				mv clang-11.0.0.src $LLVM_HOME/tools/clang
				mv compiler-rt-11.0.0.src $LLVM_HOME/projects/compiler-rt
				;;
esac

mkdir -p $LLVM_HOME/build
cd $LLVM_HOME/build
../configure --enable-optimized \
			 --disable-debug-symbols \
			 --disable-docs \
			 --disable-terminfo \
			 --disable-bindings \
			 --enable-targets=host-only \
			 --enable-shared
make -j2
make install
