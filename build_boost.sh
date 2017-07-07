echo "About to build boost"
pwd
sh bootstrap.sh
./b2 \
headers \
-sBOOST_ROOT=. \
-sZLIB_SOURCE="zlib" \
toolset=clang \
cxxflags="-std=c++11 -stdlib=libc++ -mmacosx-version-min=10.12 -fvisibility-inlines-hidden" \
architecture=x86 \
address-model=64 \
--prefix=/usr/local/i386 \
link=static \
runtime-link=shared \
--with-system \
--with-filesystem \
--with-thread \
--with-date_time \
--with-chrono \
--with-regex \
--with-iostreams \
stage
