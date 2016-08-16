//
//  ServiceDelegate.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/8/5.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonServiceDelegate <NSObject>
@required
- (void)callService;
@optional
- (void)cancelService;
@end
