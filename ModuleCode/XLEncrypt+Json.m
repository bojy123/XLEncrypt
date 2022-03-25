//
//  XLEncrypt+Json.m
//  XLEncrypt
//
//  Created by 薄宇 on 2022/3/25.
//

#import "XLEncrypt+Json.h"

@implementation XLEncrypt (Json)

// 获取json 字符串
+ (NSString *)jsonEncode:(id)obj
{
    if (obj == nil) return nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//  获取json对象
+ (id)jsonDecode:(NSString *)str
{
    if (str == nil) return nil;
    return [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

@end
