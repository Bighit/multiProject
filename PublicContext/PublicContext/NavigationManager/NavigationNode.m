//
//  NavigationNode.m
//  NavigationManager-OC
//
//  Created by Hantianyu on 16/7/29.
//  Copyright © 2016年 HTY. All rights reserved.
//

#import "NavigationNode.h"
#import "UIViewController+NavigaitonNode.h"

@implementation NavigationNode
{
    
    UIViewController *_viewController;
}
-(instancetype)initWithViewController:(UIViewController *)viewController identifier:(NSString *)identifier
{
    self=[super init];
    if (self) {
        _identifier=identifier;
        _viewController=viewController;
        _viewController.node=self;
        
    }
    return self;
}

-(NavigationNode *)getNextNode
{
    if (self.nextNodePath) {
        NSMutableArray<NSString *> *classArray=[NSMutableArray arrayWithArray:[self.nextNodePath componentsSeparatedByString:@"=>"]];
        for (int i=0 ; i<classArray.count ;) {
            NSString *className=classArray[i];
            [classArray removeObjectAtIndex:i];
            if (className.length>0) {
                UIViewController *viewController=[[NSClassFromString(className) alloc]init];
                NavigationNode *node=[[NavigationNode alloc]initWithViewController:viewController identifier:self.identifier];
                viewController.node=node;
                node.previousNode=self;
                node.nextNodePath=[NSString stringWithFormat:@"=>%@",[classArray componentsJoinedByString:@"=>"]];
                return node;
                break;
            }
        }
    }
    return nil;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"identifier:%@  currentVC:%@ \nnextPath:%@",self.identifier,_viewController,self.nextNodePath];
}
-(UIViewController *)getViewController
{
    return _viewController;
}
@end



