//
//  DJIPlaybackMultiSelectViewController.h
//  DJINavi
//
//  Created by 何彦男 on 2018/7/12.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJIPlaybackMultiSelectViewController : UIViewController

@property (copy, nonatomic) void (^selectItemBtnAction)(int index);
@property (copy, nonatomic) void (^swipeGestureAction)(UISwipeGestureRecognizerDirection direction);

@end
