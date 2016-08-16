//
//  ServiceManager.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/8/5.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonServiceOperation.h"
#import "ServiceWithDataOperation.h"
@interface ServiceManager : NSObject


+(void)loadService:(NSString *)serviceName withCallBack:(void(^)())block;
+(void)loadService:(NSString *)serviceName withParams:(NSDictionary *)params withCallBack:(void(^)(NSDictionary *result))block synchronous:(BOOL)isSynchronous;
+(NSDictionary *)syncServiceData:(NSString *)serviceName withParams:(NSDictionary *)params;
@end
