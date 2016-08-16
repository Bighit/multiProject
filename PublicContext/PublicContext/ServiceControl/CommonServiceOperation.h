//
//  ServiceOperation.h
//  NavigationManager-OC
//
//  Created by hty on 16/8/8.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonServiceDelegate.h"

typedef void (^ ServiceCompleteBlock)();

@interface CommonServiceOperation : NSOperation
@property(nonatomic,assign)BOOL synchronous;
@property(nonatomic,copy,nullable)ServiceCompleteBlock completeBlock;

-(nullable instancetype )initWithService:(nonnull id<CommonServiceDelegate>)service;

- (void)syncService;
@end
