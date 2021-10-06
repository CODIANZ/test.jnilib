#　NDKのパスとAPIレベルの設定（外部で定義するも良し）
ANDROID_NDK_HOME=~/Library/Android/sdk/ndk/23.0.7599858
ANDROID_NATIVE_API_LEVEL=26

#　パスの設定（libsが成果物でアーキテクチャ毎サブディレクトリが生成される）
BUILD_PATH=build
LIBS_PATH=libs
BASE_PATH=`pwd`

# CMAKEの設定
CMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake
CMAKE_BUILD_TYPE=Release

# 並列ビルド数
PARALLEL=2

# ABI のアーキテクチャを列挙（このくらいあればOK？）
TARGETS="armeabi-v7a x86 arm64-v8a"

# 作業フォルダと成果物フォルダの削除
rm -rf ${BUILD_PATH}
rm -rf ${LIBS_PATH}

# ABIでループする
for ABI in ${TARGETS}
do    
  mkdir -p ${BUILD_PATH}/${ABI}
  cd ${BUILD_PATH}/${ABI}

  cmake \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
    -DANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL} \
    -DANDROID_NDK=${ANDROID_NDK_HOME} \
    -DANDROID_ABI=${ABI} \
    ${BASE_PATH}

  make -j${PARALLEL}
  cd -

  mkdir -p ${LIBS_PATH}/${ABI}
  cp ${BUILD_PATH}/${ABI}/*.a ${LIBS_PATH}/${ABI}
done
