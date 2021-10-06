#include <jni.h>
#include <string>
#include "sub.h"

extern "C" JNIEXPORT jstring JNICALL
Java_com_clementec_testjnilib_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = func();
    return env->NewStringUTF(hello.c_str());
}