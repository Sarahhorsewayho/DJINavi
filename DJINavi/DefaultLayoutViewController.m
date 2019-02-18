//
//  DefaultLayoutViewController.m
//  DJINavi
//
//  Created by 何彦男 on 2018/7/12.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import "DefaultLayoutViewController.h"
#import "DemoUtility.h"

@interface DefaultLayoutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *playbackBtn;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

- (IBAction) outBtnAction:(id)sender;

@end

@implementation DefaultLayoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IS_IPAD) {
        [self.playbackBtn setImage:[UIImage imageNamed:@"playback_icon_iPad"] forState:UIControlStateNormal];
    }else{
        [self.playbackBtn setImage:[UIImage imageNamed:@"playback_icon"] forState:UIControlStateNormal];
    }
}

- (void)outBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
