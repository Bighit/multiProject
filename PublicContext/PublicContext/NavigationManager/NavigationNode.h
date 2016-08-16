//
//  NavigationNode.h
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/7/29.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavigationNode : NSObject

@property(nonatomic,copy)NSString *nextNodePath;
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,strong)NavigationNode *previousNode;
@property(nonatomic,copy)NSDictionary *context;

-(instancetype)initWithViewController:(UIViewController *)viewController identifier:(NSString *)identifier;
-(NavigationNode *)getNextNode;
-(UIViewController *)getViewController;
@end
