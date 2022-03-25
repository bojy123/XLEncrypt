//
//  XLEncrypt+Url.m
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncrypt+Url.h"

@implementation XLEncrypt (Url)

// url编码，不会对特殊符号编码
+ (NSString *)urlEncode:(NSString *)string
{
    NSString *result = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return result;
}

// url编码，会对特殊符号编码
+ (NSString *)urlAllEncode:(NSString *)string
{
    NSString *result = [string stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];
    return result;
}

// url解码
+ (NSString *)urlDecode:(NSString *)string
{
    NSString *result = [string stringByRemovingPercentEncoding];
    return result;
}

@end
