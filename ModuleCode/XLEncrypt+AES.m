//
//  XLEncrypt+AES.m
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncrypt+AES.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "XLEncrypt+MD5.h"
#import "XLEncrypt+Base64.h"

@implementation XLEncrypt (AES)

#pragma mark -
#pragma mark - 字符串加密 base64

+ (NSString *)aesEncryptString:(NSString *)str key:(NSString *)key
{
    return [self aesEncryptString:str key:key iv:[self encrypt_iv]];
}

+ (NSString *)aesDecryptString:(NSString *)str key:(NSString *)key
{
    return [self aesDecryptString:str key:key iv:[self encrypt_iv]];
}

#pragma mark -
#pragma mark - 字符串加密 base64 iv

+ (NSString *)aesEncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self aesEncryptData:strData key:key iv:iv];
    return [XLEncrypt base64EncodeStringFromData:resultData];
}

+ (NSString *)aesDecryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *strData = [XLEncrypt base64DecodeDataFromString:str];
    NSData *resultData = [self aesDecryptData:strData key:key iv:iv];
    NSString *decoded = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    return [self processDecodedString:decoded];
}

#pragma mark -
#pragma mark - 字符串加密 16进制 iv

+ (NSString *)aesEncryptHexString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self aesEncryptData:strData key:key iv:iv];
    return [self dataToHexString:resultData];
}

+ (NSString *)aesDecryptHexString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *strData = [self dataFromHexString:str];
    NSData *resultData = [self aesDecryptData:strData key:key iv:iv];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

#pragma mark -
#pragma mark - Data加密 iv
// 加密
+ (NSData *)aesEncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCEncrypt data:data key:key iv:iv];
}

// 解密
+ (NSData *)aesDecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self AES128Operation:kCCDecrypt data:data key:key iv:iv];
}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        偏移量
 *  @return          数据流
 */
+ (NSData *)AES128Operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
     这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
     */
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            keyPtr,
                                            kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes],
                                            [data length],
                                            buffer,
                                            bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
    }
    free(buffer);
    return nil;
}

+ (NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr = [decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
}

#pragma mark - iv

#define XOR_KEY 0xBB

+ (NSString *)encrypt_iv {
    unsigned char str[] = {
        (XOR_KEY ^ 'k'),
        (XOR_KEY ^ 'X'),
        (XOR_KEY ^ 'L'),
        (XOR_KEY ^ 'E'),
        (XOR_KEY ^ 'n'),
        (XOR_KEY ^ 'c'),
        (XOR_KEY ^ 'r'),
        (XOR_KEY ^ 'y'),
        (XOR_KEY ^ 'p'),
        (XOR_KEY ^ 't'),
        (XOR_KEY ^ '1'),
        (XOR_KEY ^ '2'),
        (XOR_KEY ^ '3'),
        (XOR_KEY ^ '4'),
        (XOR_KEY ^ '5'),
        (XOR_KEY ^ '6'),
        (XOR_KEY ^ '\0')};
    [self xorString:str key:XOR_KEY];
    static unsigned char result[17];
    memcpy(result, str, 17);
    return [NSString stringWithFormat:@"%s",result];
}

+ (void)xorString:(unsigned  char *)str key:(unsigned char)key {
    unsigned  char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

/**
 data转16进制字符串
 
 @param data 数据流
 @return 16进制字符串
 */
+ (NSString *)dataToHexString:(NSData *)data {
    
    if (data==nil)
        return (@"");
    
    const unsigned char *bytes = [data bytes];
    NSMutableString *string = [NSMutableString stringWithCapacity:(data.length*2)];
    for (int loop=0; loop<(data.length); loop++) {
        [string appendFormat:@"%02x", *bytes];
        bytes++;
    }
    return (string);
}


/**
 16进制字符串转data
 
 @param string 16进制字符串
 @return 数据流
 */
+ (NSData *)dataFromHexString:(NSString *)string
{
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    int length = (int) string.length;
    
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

@end
