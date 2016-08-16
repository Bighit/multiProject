//
//  NavigationManager.m
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/7/29.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import "NavigationManager.h"
#import "UINavigationController+HookPushMethod.h"

#define tabChildViewControllerIdentifier @"tab"
#define navigationConfig @[@"ViewController=>ViewController1=>ViewController1",@"ViewController2=>ViewController4"]

@implementation NavigationManager
{
    NSMutableDictionary<NSString *, NavigationNode*> *_nodeDictionary;
}
-(instancetype)init
{
    self=[super init];
    
    if (self) {
        _nodeDictionary=[[NSMutableDictionary alloc]init];;
    }
    return self;
}
+(instancetype)manager
{
    static NavigationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    
    return manager;
}
-(void)configWithTabBarController:(UITabBarController *)tabBarController
{
    for (UINavigationController *navViewController in tabBarController.viewControllers) {
        if ([navViewController isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc=navViewController.topViewController;
            NavigationNode *node=[[NavigationNode alloc]initWithViewController:vc identifier:[NSString stringWithFormat:@"%@%u",tabChildViewControllerIdentifier,[tabBarController.viewControllers indexOfObject:navViewController]]];
   
            [_nodeDictionary setObject:node forKey:node.identifier];
            
        }
    }
}
-(void)setNavigationNode:(NavigationNode *)node
{
    if (node) {
        [_nodeDictionary setObject:node forKey:node.identifier];
    }
}
-(void)configNavigationPathWithString:(NSString *)path identifier:(NSString *)identifier
{
    NavigationNode *node=_nodeDictionary[identifier];
    node.nextNodePath=path;
}
-(void)pushWithViewIdentifier:(NSString *)identifier animated:(BOOL)animated
{
    NavigationNode *node=_nodeDictionary[identifier];
    if (!node.nextNodePath||[node.nextNodePath isEqualToString:@"=>"]) {
        for (NSString *configString in navigationConfig) {
            NSMutableArray *array= [NSMutableArray arrayWithArray:[configString componentsSeparatedByString:@"=>"]];
            for (int i=0 ; i<array.count ;) {
                    NSString *className=array[i];
                [array removeObjectAtIndex:0];
                if ([className isEqualToString:NSStringFromClass([node getViewController].class)]) {
                    node.nextNodePath=[NSString stringWithFormat:@"=>%@",[array componentsJoinedByString:@"=>"]];
                    break;
                }
                
            }
            
        }
        
        
    }
    if ([node getNextNode]) {
        NavigationNode *nextNode=[node getNextNode];
        [_nodeDictionary setObject:nextNode forKey:nextNode.identifier];
        [[node getViewController].navigationController hook_pushViewController:[nextNode getViewController] animated:animated];
        NSLog(@"%@",nextNode.description);
    }
    
}
-(void)popWithIdentifier:(NSString *)identifier to:(NSString *)className animated:(BOOL)animated
{
    NavigationNode *node=_nodeDictionary[identifier];
    if (node.previousNode&&[node getViewController]) {
        if (className.length>0) {
            node=node.previousNode;
            while  (![className isEqualToString:NSStringFromClass([node getViewController].class)]&&node.previousNode)   {
                node=node.previousNode;
            }
            [_nodeDictionary setObject:node forKey:node.identifier];
            _nodeDictionary[node.identifier]=node;
            NSLog(@"%@",node.description);
            [[node getViewController].navigationController hook_popToViewController:[node getViewController] animated:animated];
        }else{
            [_nodeDictionary setObject:node.previousNode forKey:node.previousNode.identifier];
            NSLog(@"%@",node.previousNode.description);
            
            [[node getViewController].navigationController hook_popViewControllerAnimated:animated];
        }
    }
}
@end
