//
//  NavigationManager.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/7/29.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NavigationNode.h"
#import "UIViewController+NavigaitonNode.h"

@interface NavigationManager : NSObject
+(instancetype)manager;
-(void)configWithTabBarController:(UITabBarController *)tabBarController;
//
-(void)setNavigationNode:(NavigationNode *)node;
-(void)configNavigationPathWithString:(NSString *)path identifier:(NSString *)identifier;
-(void)pushWithViewIdentifier:(NSString *)identifier animated:(BOOL)animated;
-(void)popWithIdentifier:(NSString *)identifier to:(NSString *)className animated:(BOOL)animated;
@end
