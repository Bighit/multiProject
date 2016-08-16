//
//  UIViewController+NavigationManager.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/8/8.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationManager)
-(void)nextViewController;
-(void)previousViewController;
-(void)pushWithPath:(NSString *)path;
-(void)popWithClassName:(NSString *)VCName;
-(void)pushOrPopWithClassName:(NSString *)VCName;
@end
