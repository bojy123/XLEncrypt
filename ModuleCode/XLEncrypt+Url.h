//
//  XLEncrypt+Url.h
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncryptBase.h"

@interface XLEncrypt (Url)

/// url编码，不会对特殊符号编码
+ (NSString *)urlEncode:(NSString *)string;

/// url编码，会对特殊符号编码
+ (NSString *)urlAllEncode:(NSString *)string;

/// url解码
+ (NSString *)urlDecode:(NSString *)string;

@end
