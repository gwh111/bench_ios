//
//  PlatformConfig.h
//  HelloCpp
//
//  Created by gwh on 2017/12/19.
//

/**
 *
 #if TARGET_IPHONE_SIMULATOR
 [CASStyler defaultStyler].watchFilePath = path;
 #endif
 */

#define ZZ_PLATFORM_UNKNOWN            0
#define ZZ_PLATFORM_ANDROID            1
#define ZZ_PLATFORM_WIN32              2
#define ZZ_PLATFORM_IOS_SIMULATOR      3
#define ZZ_PLATFORM_IOS_IPHONE         4

// Determine target platform by compile environment macro.
#define ZZ_TARGET_PLATFORM             ZZ_PLATFORM_UNKNOWN

// Apple: Mac and iOS
#if defined(__APPLE__) && !defined(ANDROID) // exclude android for binding generator.
    #include <TargetConditionals.h>
    #undef  ZZ_TARGET_PLATFORM
    #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_IOS_IPHONE
    #if TARGET_IPHONE_SIMULATOR
        #undef  ZZ_TARGET_PLATFORM
        #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_IOS_SIMULATOR
    #elif TARGET_OS_IPHONE
        #undef  ZZ_TARGET_PLATFORM
        #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_IOS_IPHONE
    #elif TARGET_OS_MAC
        #undef  ZZ_TARGET_PLATFORM
        #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_MAC
    #endif
#endif

// android
#if defined(ANDROID)
    #undef  ZZ_TARGET_PLATFORM
    #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_ANDROID
#endif

// win32
#if defined(_WIN32) && defined(_WINDOWS)
    #undef  ZZ_TARGET_PLATFORM
    #define ZZ_TARGET_PLATFORM         ZZ_PLATFORM_WIN32
#endif


