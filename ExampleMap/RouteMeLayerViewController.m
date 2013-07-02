//
//  RouteMeLayerViewController.m
//  ExampleMap
//
//  Created by Tore Halset on 26.06.13.
//  Copyright (c) 2013 Electronic Chart Centre. All rights reserved.
//

#import "RouteMeLayerViewController.h"

#import "RMWMS.h"
#import "RMWMSSource.h"
#import "RMMapView.h"
#import "RMFractalTileProjection.h"
#import "RMOpenStreetMapSource.h"

@interface RouteMeLayerViewController ()

@end

@implementation RouteMeLayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // a wms layer tile source
    RMWMS *topowms = [[RMWMS alloc] init];
    topowms.urlPrefix = @"http://opencache.statkart.no/gatekeeper/gk/gk.open";
    topowms.layers = @"topo2";
    RMWMSSource *topoSource = [[RMWMSSource alloc] init];
    topoSource.wms = topowms;
    topoSource.uniqueTilecacheKey = @"abc";
    
    // set up a map view
    mapView = [[RMMapView alloc] initWithFrame:self.view.frame
                                            andTilesource:topoSource];
    mapView.showLogoBug = NO;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(60.03, 10.19);
    mapView.zoom = 11.0;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // add a tiled wms overlay
    RMWMS *bestandsdatawms = [[RMWMS alloc] init];
    bestandsdatawms.urlPrefix = @"http://213.236.220.139:6080/arcgis/services/Karttjenester/Bestandsdata_Buskerud_Cache2/MapServer/WMSServer?TRANSPARENT=TRUE";
    bestandsdatawms.crs = @"EPSG:3857";
    bestandsdatawms.layers = @"0";
    bestandsdatawms.queryLayers = @"0";
    bestandsdatawms.infoFormat = @"text/html";
    RMWMSSource *bestandsdatasource = [[RMWMSSource alloc] init];
    bestandsdatasource.wms = bestandsdatawms;
    bestandsdatasource.uniqueTilecacheKey = @"bestandsdata2";
    [mapView addTileSource:bestandsdatasource];

    // prepare for feature info
    featureInfoWMSSource = bestandsdatasource;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongMapPress:)];
    [mapView addGestureRecognizer:longPress];
    
    // add in map view
    [self.view addSubview:mapView];

}

-(void)handleLongMapPress:(UILongPressGestureRecognizer*)recognizer {
    
    // only handle state began. not continously
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // where, in xy space, the user clicked in the view
    mapMenuClickPoint = [recognizer locationInView:mapView];
    
    // create GetFeatureInfo URL
    NSString *featureInfoUrl = [featureInfoWMSSource featureInfoUrlForPoint:mapMenuClickPoint
                                                                      inMap:mapView];
    
    // load html feature info view in web view
    UIWebView *featureInfoView = [[UIWebView alloc] init];
    [featureInfoView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:featureInfoUrl]]];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = featureInfoView;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    [doneButton setTitle:@"Done"];
    [doneButton setTarget:self];
    [doneButton setAction:@selector(done:)];
    [doneButton setStyle:UIBarButtonItemStyleDone];
    [[viewController navigationItem] setRightBarButtonItem:doneButton];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
