//
//  XLEncrypt+AES.h
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncryptBase.h"

@interface XLEncrypt (AES)

#pragma mark - AES字符串加密 Base64
/************************************************************************************************************************
                                                AES字符串加密 Base64
 ************************************************************************************************************************/

/**
 AES字符串加密（AES 128位 CBC PKCS7Padding）
 
 @param str 需要加密字符串
 @param key 加密Key
 @return Base64加密字符串
 */
+ (NSString *)aesEncryptString:(NSString *)str key:(NSString *)key;

/**
 AES字符串解密（AES 128位 CBC PKCS7Padding）
 
 @param str 加密字符串
 @param key 加密Key
 @return 解密字符串
 */
+ (NSString *)aesDecryptString:(NSString *)str key:(NSString *)key;


#pragma mark - AES字符串加密 Base64 IV
/************************************************************************************************************************
                                                AES字符串加密 Base64 IV
 ************************************************************************************************************************/

/**
 AES字符串加密（AES 128位 CBC PKCS7Padding）

 @param str 需要加密字符串
 @param key 加密Key
 @param iv 偏移量
 @return Base64加密字符串
 */
+ (NSString *)aesEncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

/**
  AES字符串解密（AES 128位 CBC PKCS7Padding）

 @param str 加密字符串
 @param key 加密Key
 @param iv 偏移量
 @return 解密字符串
 */
+ (NSString *)aesDecryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;


#pragma mark - AES字符串加密 16进制 IV
/************************************************************************************************************************
                                                AES字符串加密 16进制 IV
 ************************************************************************************************************************/

/**
 AES字符串加密（AES 128位 CBC PKCS7Padding）
 
 @param str 需要加密字符串
 @param key 加密Key
 @param iv 偏移量
 @return 16进制加密字符串
 */
+ (NSString *)aesEncryptHexString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

/**
 AES字符串解密（AES 128位 CBC PKCS7Padding）
 
 @param str 加密字符串
 @param key 加密Key
 @param iv 偏移量
 @return 解密字符串
 */
+ (NSString *)aesDecryptHexString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;


#pragma mark - AES加密 NSData IV
/************************************************************************************************************************
                                                AES加密 NSData IV
 ************************************************************************************************************************/

/**
 AES加密（AES 128位 CBC PKCS7Padding）

 @param data 数据流
 @param key 加密Key
 @param iv 偏移量
 @return 加密数据流
 */
+ (NSData *)aesEncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

/**
 AES解密（AES 128位 CBC PKCS7Padding）

 @param data 数据流
 @param key 加密Key
 @param iv 偏移量
 @return 解密数据流
 */
+ (NSData *)aesDecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

@end
