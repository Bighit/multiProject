//
//  UINavigationController+HookPushMethod.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/8/10.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HookPushMethod)

- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)hook_popViewControllerAnimated:(BOOL)animated;
- (void)hook_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
-(void)hook_setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
-(void)hook_setViewControllers:(NSArray *)viewControllers;
@end
