//
//  P2Service.m
//  Project2
//
//  Created by Hantianyu on 16/8/16.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import "P2Service.h"
#import "PublicContext.h"
@implementation P2Service
-(NSDictionary *)callService:(NSDictionary *)dic
{
    NSNumber *number=dic[paramkey];
    float sqrt=sqrtf(number.floatValue);
    return @{resultkey:@(sqrt)};
}
@end
