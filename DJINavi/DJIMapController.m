//
//  DJIMapController.m
//  DJINavi
//
//  Created by 何彦男 on 2018/7/11.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import "DJIMapController.h"

#import "RoutePathDetailViewController.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import <AMapSearchKit/AMapSearchObj.h>

#import "DemoUtility.h"


NSMutableArray *latitude;
NSMutableArray *longitude;
NSUInteger l_count;

@interface DJIMapController ()<AMapSearchDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) AMapSearchAPI *search;  // 地图内的搜索API类
@property (strong, nonatomic) AMapRoute *route;  //路径规划信息

@property (assign, nonatomic) CLLocationCoordinate2D startCoordinate; //起始点经纬度

@property (assign, nonatomic) NSUInteger totalRouteNums;  //总共规划的线路的条数
@property (assign, nonatomic) NSUInteger currentRouteIndex; //当前显示线路的索引值，从0开始


@end

@implementation DJIMapController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.editPoints = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)addPoint:(CGPoint)point withMapView:(MKMapView *)mapView
{

    CLLocationCoordinate2D coordinate = [mapView convertPoint:point toCoordinateFromView:mapView];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [_editPoints addObject:location];
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location.coordinate;
  //  [mapView addAnnotation:annotation];

}

//- (void)addPoint:(CGPoint)point withMapView:(MKMapView *)mapView withLocation:(CLLocationCoordinate2D)amapcoord
//{
//
//    CLLocationCoordinate2D coordinate = [mapView convertPoint:point toCoordinateFromView:mapView];
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//
//    self.search = [[AMapSearchAPI alloc] init];
//    self.search.delegate = self;
//
//    //初始化坐标数据
//    //self.startCoordinate = CLLocationCoordinate2DMake(31.141333, 121.661735);
//    self.startCoordinate = amapcoord;
//    CLLocation *start_location = [[CLLocation alloc] initWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
//
//    [_editPoints addObject:start_location];
//
////    NSLog(@"startLat: ",self.startCoordinate.latitude);
////    NSLog(@"startLog: ",self.startCoordinate.longitude);
////
////    NSLog(@"desLat: ",coordinate.latitude);
////    NSLog(@"desLog: ",coordinate.longitude);
//
//    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
//
//    //步行路线开始规划
//
//    /* 出发点. */
//    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
//                                           longitude:self.startCoordinate.longitude];
//    /* 目的地. */
//    //    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
//    //                                                longitude:self.destinationCoordinate.longitude];
//
//    navi.destination = [AMapGeoPoint locationWithLatitude:coordinate.latitude
//                                                longitude:coordinate.longitude];
//
//
//
//
//    [self.search AMapWalkingRouteSearch:navi];
//
//
//    //CLLocationDegrees temp_longitude = coordinate.longitude;
//    // [_editPoints addObject:location];
//    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
//    annotation.coordinate = location.coordinate;
//    [mapView addAnnotation:annotation];
//
//    NSLog(@"Over!");
//}
//
//
//#pragma mark - AMapSearchDelegate
//
////当路径规划搜索请求发生错误时，会调用代理的此方法
//- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
//    NSLog(@"Error: %@", error);
//    [self resetSearchResultAndXibViewsToDefault];
//}
//
////路径规划搜索完成回调.
//- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
//
//    NSLog(@"Enter Back!");
//
//    if (response.route == nil){
//        [self resetSearchResultAndXibViewsToDefault];
//        return;
//    }
//
//    self.route = response.route;
//
//    self.totalRouteNums = self.route.paths.count;
//
//    self.currentRouteIndex = 0;
//
//    NSArray <AMapPath *> *e_path = self.route.paths;
//    NSString *pre_pair = [NSString string];
//    latitude = [[NSMutableArray alloc] init];
//    longitude = [[NSMutableArray alloc] init];
//    NSUInteger s_count = self.route.paths[self.currentRouteIndex].steps.count;
//    for (NSUInteger i = 0; i < s_count; i++) {
//        NSString  *poly = e_path[self.currentRouteIndex].steps[i].polyline;
//        NSLog(@"%@",poly);
//        NSArray *s_array = [poly componentsSeparatedByString:@";"];
//        for (NSUInteger j = 0; j < s_array.count; j++) {
//            NSString *point_pair = [s_array objectAtIndex:j];
//            BOOL result = [point_pair isEqualToString:pre_pair];
//            if (!result) {
//                NSLog(@"%@",point_pair);
//                NSArray *point = [point_pair componentsSeparatedByString:@","];
//                NSString *s_long = [point objectAtIndex:0];
//                NSString *s_lat = [point objectAtIndex:1];
//                //[latitude addObject:s_long];
//                //[longitude addObject:s_lat];
//                CLLocationDegrees pass_latitude = [s_lat doubleValue];
//                CLLocationDegrees pass_longitude = [s_long doubleValue];
//                CLLocation *pass_point = [[CLLocation alloc] initWithLatitude:pass_latitude longitude:pass_longitude];
//                [_editPoints addObject:pass_point];
//            }
//            pre_pair = [NSString stringWithString:point_pair];
//        }
//    }
//
//    //    for (NSUInteger k = 0; k < latitude.count; k++) {
//    //        NSString *str1 = [latitude objectAtIndex:k];
//    //        NSString *str2 = [longitude objectAtIndex:k];
//    //        NSLog(@"%@",str1);
//    //        NSLog(@"%@",str2);
//    //    }
//
//
//}
//
////初始化或者规划失败后，设置view和数据为默认值
//- (void)resetSearchResultAndXibViewsToDefault {
//    self.totalRouteNums = 0;
//    self.currentRouteIndex = 0;
//}

- (void)cleanAllPointsWithMapView:(MKMapView *)mapView
{
    [_editPoints removeAllObjects];
    NSArray* annos = [NSArray arrayWithArray:mapView.annotations];
    for (int i = 0; i < annos.count; i++) {
        id<MKAnnotation> ann = [annos objectAtIndex:i];

        if (![ann isEqual:self.aircraftAnnotation]) { //Add it to check if the annotation is the aircraft's and prevent it from removing
            [mapView removeAnnotation:ann];
        }

    }
}

- (NSArray *)wayPoints
{
    return self.editPoints;
}

-(void)updateAircraftLocation:(CLLocationCoordinate2D)location withMapView:(MKMapView *)mapView
{
    if (self.aircraftAnnotation == nil) {
        self.aircraftAnnotation = [[DJIAircraftAnnotation alloc] initWithCoordiante:location];
        [mapView addAnnotation:self.aircraftAnnotation];
    }
    
    [self.aircraftAnnotation setCoordinate:location];
}

-(void)updateAircraftHeading:(float)heading
{
    if (self.aircraftAnnotation) {
        [self.aircraftAnnotation updateHeading:heading];
    }
}

//- (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location
//{
//    return [self gcj02Decrypt:location.latitude gjLon:location.longitude];
//}
//
//+ (CLLocationCoordinate2D)gcj02Decrypt:(double)gjLat gjLon:(double)gjLon {
//    CLLocationCoordinate2D  gPt = [self gcj02Encrypt:gjLat bdLon:gjLon];
//    double dLon = gPt.longitude - gjLon;
//    double dLat = gPt.latitude - gjLat;
//    CLLocationCoordinate2D pt;
//    pt.latitude = gjLat - dLat;
//    pt.longitude = gjLon - dLon;
//    return pt;
//}
//
//- (CLLocationCoordinate2D)gcj02Encrypt:(double)ggLat bdLon:(double)ggLon
//{
//    CLLocationCoordinate2D resPoint;
//    double mgLat;
//    double mgLon;
//    if ([self outOfChina:ggLat bdLon:ggLon]) {
//        resPoint.latitude = ggLat;
//        resPoint.longitude = ggLon;
//        return resPoint;
//    }
//    double dLat = [self transformLat:(ggLon - 105.0)bdLon:(ggLat - 35.0)];
//    double dLon = [self transformLon:(ggLon - 105.0) bdLon:(ggLat - 35.0)];
//    double radLat = ggLat / 180.0 * M_PI;
//    double magic = sin(radLat);
//    magic = 1 - jzEE * magic * magic;
//    double sqrtMagic = sqrt(magic);
//    dLat = (dLat * 180.0) / ((jzA * (1 - jzEE)) / (magic * sqrtMagic) * M_PI);
//    dLon = (dLon * 180.0) / (jzA / sqrtMagic * cos(radLat) * M_PI);
//    mgLat = ggLat + dLat;
//    mgLon = ggLon + dLon;
//
//    resPoint.latitude = mgLat;
//    resPoint.longitude = mgLon;
//    return resPoint;
//}
//
//- (BOOL)outOfChina:(double)lat bdLon:(double)lon
//{
//    if (lon < RANGE_LON_MIN || lon > RANGE_LON_MAX)
//        return true;
//    if (lat < RANGE_LAT_MIN || lat > RANGE_LAT_MAX)
//        return true;
//    return false;
//}
//
//- (double)transformLat:(double)x bdLon:(double)y
//{
//    double ret = LAT_OFFSET_0(x, y);
//    ret += LAT_OFFSET_1;
//    ret += LAT_OFFSET_2;
//    ret += LAT_OFFSET_3;
//    return ret;
//}
//
//-(double)transformLon:(double)x bdLon:(double)y
//{
//    double ret = LON_OFFSET_0(x, y);
//    ret += LON_OFFSET_1;
//    ret += LON_OFFSET_2;
//    ret += LON_OFFSET_3;
//    return ret;
//}
@end

