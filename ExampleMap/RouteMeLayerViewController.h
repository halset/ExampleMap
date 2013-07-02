//
//  RouteMeLayerViewController.h
//  ExampleMap
//
//  Created by Tore Halset on 26.06.13.
//  Copyright (c) 2013 Electronic Chart Centre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMMapView.h"
#import "RMWMS.h"
#import "RMWMSSource.h"

@interface RouteMeLayerViewController : UIViewController <CLLocationManagerDelegate> {
    
    RMMapView *mapView;
    RMWMSSource *featureInfoWMSSource;
    CGPoint mapMenuClickPoint;
    
}

-(IBAction)done:(id)sender;

@end
