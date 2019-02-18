//
//  RoutePathDetailViewController.h
//  DJINavi
//
//  Created by 何彦男 on 2018/7/11.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMapRoute;
@class AMapPath;

@interface RoutePathDetailViewController : UIViewController

@property (strong, nonatomic) AMapRoute *route;
@property (strong, nonatomic) AMapPath *path;

@end

