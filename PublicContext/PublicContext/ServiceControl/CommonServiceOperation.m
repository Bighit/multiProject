//
//  ServiceOperation.m
//  NavigationManager-OC
//
//  Created by hty on 16/8/8.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import "CommonServiceOperation.h"

@interface CommonServiceOperation ()
{
    BOOL                        _isExecuting;
    BOOL                        _isFinished;
    id <CommonServiceDelegate>  _service;
}
@end
@implementation CommonServiceOperation
- (void)main
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self handleService];
    
}

- (BOOL)isConcurrent
{
    if (self.synchronous) {
        return NO;
    } else {
        return YES;
    }
}

- (void)finish
{
    if (_isFinished || !_isExecuting) {
        return;
    }

    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];

    _isExecuting = NO;
    _isFinished = YES;

    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancel
{
    [super cancel];

    if (!self.synchronous && _service) {
        if ([_service respondsToSelector:@selector(cancelService)]) {
            [_service cancelService];
        }
    }

    [self finish];
}

- (instancetype)initWithService:(id <CommonServiceDelegate>)service
{
    self = [super init];

    if (self) {
        _service = service;
    }

    return self;
}

- (void)handleService
{
    if (self.isCancelled) {
        [self cancel];
    }

    if (!_service) {
        [self finish];
        return;
    }

    if ([_service respondsToSelector:@selector(callService)]) {
        [_service callService];
    }

    if (self.completeBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completeBlock();
        });
        
    }
}

- (void)syncService
{
    if (self.isCancelled) {
        [self cancel];
    }

    if (!_service) {
        [self finish];
        return;
    }

    if ([_service respondsToSelector:@selector(callService)]) {
        [_service callService];
    }
}

@end
