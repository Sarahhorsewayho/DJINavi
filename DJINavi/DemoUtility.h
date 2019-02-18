//
//  DemoUtility.h
//  DJINavi
//
//  Created by 何彦男 on 2018/7/11.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJISDK/DJISDK.h>

#ifndef DemoUtility_h
#define DemoUtility_h

#define WeakRef(__obj) __weak typeof(self) __obj = self
#define WeakReturn(__obj) if(__obj ==nil)return;

#define DEGREE(x) ((x)*180.0/M_PI)
#define RADIAN(x) ((x)*M_PI/180.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 667)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 568)

#endif

extern void ShowMessage(NSString *title, NSString *message, id target, NSString *cancleBtnTitle);
extern void ShowResult(NSString *format, ...);

@class DJIFlightController;

@interface DemoUtility : NSObject

+(DJIBaseProduct*) fetchProduct;
+(DJICamera*) fetchCamera;
+(DJIAircraft*) fetchAircraft;
+(DJIFlightController*) fetchFlightController;

@end
