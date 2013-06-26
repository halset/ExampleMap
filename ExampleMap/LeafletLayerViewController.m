//
//  LeafletLayerViewController.m
//  ExampleMap
//
//  Created by Tore Halset on 26.06.13.
//  Copyright (c) 2013 Electronic Chart Centre. All rights reserved.
//

#import "LeafletLayerViewController.h"

@interface LeafletLayerViewController ()

@end

@implementation LeafletLayerViewController

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
    
    NSString *leafletPath=[[NSBundle mainBundle] pathForResource:@"leaflet" ofType:@"html" inDirectory:@"www"];
    NSURL *url = [NSURL fileURLWithPath:leafletPath];

    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
