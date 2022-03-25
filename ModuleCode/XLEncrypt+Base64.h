//
//  XLEncrypt+Base64.h
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncryptBase.h"

@interface XLEncrypt (Base64)

#pragma mark - encode

/**
 @brief base 64编码
 @param string 要编码的字段
 @return string 编码后的字段
 */
+ (NSString *)base64Encode:(NSString *)string;

/**
 @brief base 64编码
 @param string 要编码的字段
 @return NSData 编码后的data
 */
+ (NSData *)base64EncodeDataFromString:(NSString *)string;

/**
 @brief base 64编码
 @param data 要编码的data
 @return data 编码后的data
 */
+ (NSData *)base64EncodeDataFromData:(NSData *)data;

/**
 @brief base 64编码
 @param data 要编码的字段
 @return string 编码后的字段
 */
+ (NSString *)base64EncodeStringFromData:(NSData *)data;


#pragma mark - decode

/**
 @brief base 64 解码
 @param string 编码后的字段
 @return string 解码后的字段
 */
+ (NSString *)base64Decode:(NSString *)string;

/**
 @brief base 64 解码
 @param string 编码后的字段
 @return data 解码后的字段
 */
+ (NSData *)base64DecodeDataFromString:(NSString *)string;

/**
 @brief base 64 解码
 @param data 编码后的字段
 @return data 解码后的字段
 */
+ (NSData *)base64DecodeDataFromData:(NSData *)data;

/**
 @brief base 64 解码
 @param data 编码后的字段
 @return string 解码后的字段
 */
+ (NSString *)base64DecodeStringFromData:(NSData *)data;


@end
