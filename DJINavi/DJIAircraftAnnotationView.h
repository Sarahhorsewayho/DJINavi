//
//  DJIAircraftAnnotationView.h
//  DJINavi
//
//  Created by 何彦男 on 2018/7/11.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import <MapKit/MapKit.h>
@interface DJIAircraftAnnotationView : MKAnnotationView
-(void) updateHeading:(float)heading;
@end
