//
//  ViewController.m
//  iOSConceptExercise
//
//  Created by Roi Cruz on 24/11/2015.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://jsonplaceholder.typicode.com/users" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        
        self.data = responseObject;
        
        //NSLog(@"data: %@", self.data);
        
        // now we will print 0 no index
        
        NSString *index0AddressGeoLat = [[[[self.data objectAtIndex:0]objectForKey:@"address"]objectForKey:@"geo"]objectForKey:@"lat"];
        
        NSLog(@"index0AddressGeoLat: %@", index0AddressGeoLat);
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
