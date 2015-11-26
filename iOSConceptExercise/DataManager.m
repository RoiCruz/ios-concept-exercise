//
//  DataManager.m
//  iOSConceptExercise
//
//  Created by Roi Cruz on 25/11/2015.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DataManager.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *const BaseURLString = @"http://guarded-basin-2383.herokuapp.com/facts.json";

@implementation DataManager


+(void)getData:(void(^)(NSDictionary *info, NSError* err))completion {

    //1. convert url
    NSString *urlString = BaseURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2. parse data to dictionary
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil){
            if([responseObject isKindOfClass:[NSDictionary class]]) {
                NSLog(@"response object is %@", NSStringFromClass([responseObject class]));
                
                NSDictionary *dic1 = (NSDictionary *)responseObject;

                completion (dic1, nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //code
        
        NSLog(@"Error on AFHTTPRequestOperation");
        completion (nil, nil);
    }];
    
    [operation start];
    
    
}
     
@end
