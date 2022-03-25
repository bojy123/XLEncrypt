//
//  XLEncrypt+Json.h
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncryptBase.h"

@interface XLEncrypt (Json)


/**
 *  获取json 字符串
 *
 *  @param obj array or dic 对象
 *
 *  @return str
 */
+ (NSString *)jsonEncode:(id)obj;

/**
 *  获取json对象
 *
 *  @param str json字符串
 *
 *  @return obj
 */
+ (id)jsonDecode:(NSString *)str;

@end
