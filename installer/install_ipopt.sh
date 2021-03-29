# https://coin-or.github.io/Ipopt/INSTALL.html
# https://www.coin-or.org/download/source/Ipopt/
# https://medium.com/@notus.li/install-ipopt-on-ubuntu-16-04-e2644fa93545
# https://github.com/udacity/CarND-MPC-Project/blob/master/install_Ipopt_CppAD.md 
# https://www.jianshu.com/p/8d80ba6afcfd

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev


# Pass the Ipopt source directory as the first argument
#if [ -z $1 ]
#then
#    echo "Specifiy the location of the Ipopt source directory in the first argument."
#    exit
#fi
#cd $1

if [ -z $1 ]
then
    echo "Specifiy the location of the Ipopt tar in the second argument."
    exit
fi

echo "Extracting Ipopt tar files from $1"
tar -xzvf $1 

prefix=/usr/local
tmp=$1
tmp_1=${tmp%.tgz*}
srcdir=${SCRIPT_DIR}/${tmp_1}

echo "Building Ipopt from ${srcdir}"
echo "Saving headers and libraries to ${prefix}"

# BLAS
cd $srcdir/ThirdParty/Blas
./get.Blas
mkdir -p build && cd build
../configure --prefix=$prefix --disable-shared --with-pic
make install

# Lapack
cd $srcdir/ThirdParty/Lapack
./get.Lapack
mkdir -p build && cd build
../configure --prefix=$prefix --disable-shared --with-pic \
    --with-blas="$prefix/lib/libcoinblas.a -lgfortran"
make install

# ASL
cd $srcdir/ThirdParty/ASL
./get.ASL

# MUMPS
cd $srcdir/ThirdParty/Mumps
./get.Mumps

# build everything
cd $srcdir
./configure --prefix=$prefix coin_skip_warn_cxxflags=yes \
    --with-blas="$prefix/lib/libcoinblas.a -lgfortran" \
    --with-lapack=$prefix/lib/libcoinlapack.a
make
make test
make -j1 install

#sudo apt-get install cppad

