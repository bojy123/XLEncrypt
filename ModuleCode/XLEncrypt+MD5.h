//
//  XLEncrypt+MD5.h
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncryptBase.h"

@interface XLEncrypt (MD5)

/// MD5
+ (NSString *)md5:(NSString *)string;

/// 对文件MD5
+ (NSString *)md5WithFilePath:(NSString*)path;

@end
