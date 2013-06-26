//
//  ViewController.m
//  ExampleMap
//
//  Created by Tore Halset on 26.06.13.
//  Copyright (c) 2013 Electronic Chart Centre. All rights reserved.
//

#import "ViewController.h"

#import "RMWMS.h"
#import "RMWMSSource.h"
#import "RMMapView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // a wms layer tile source
    RMWMS *topowms = [[RMWMS alloc] init];
    topowms.urlPrefix = @"http://opencache.statkart.no/gatekeeper/gk/gk.open";
    topowms.layers = @"topo2";
    RMWMSSource *topoSource = [[RMWMSSource alloc] init];
    topoSource.wms = topowms;
    topoSource.uniqueTilecacheKey = @"abc";
    
    // set up a map view
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.frame
                                            andTilesource:topoSource];
    mapView.centerCoordinate = CLLocationCoordinate2DMake(60.03, 10.19);
    mapView.zoom = 11.0;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    // add in map view
    [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
