//
//  ViewController.m
//  iOSConceptExercise
//
//  Created by Roi Cruz on 24/11/2015.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

static NSString *const BaseURLString = @"http://guarded-basin-2383.herokuapp.com/facts.json";

@interface ViewController () {
    NSMutableArray *content;
    NSMutableArray *title;
}

@end

@implementation ViewController

//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//    [self.mTableView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1. convert url
    NSString *urlString = BaseURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2. parse data to dictionary
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"View loaded here");

        NSDictionary *dic = (NSDictionary *)responseObject;
        title = [dic objectForKey:@"title"];
        NSLog(@"title array is: %@", title);
        
        NSDictionary *dic1 = (NSDictionary *)responseObject;
        content = [dic1 objectForKey:@"rows"];
        NSLog(@"content array is: %@", content);


        
//        NSString *str1 = [things objectAtIndex:2];
//        NSLog(@"%@", str1);
        
//        int count = 0;
//        for (NSDictionary *dict in [dic objectForKey:@"title"]) {
//            //statements
//            if (count==2) {
//                NSString *nname = [dict valueForKey:@"thing"];
//                    NSLog(@"%@", nname);
//            }
//            count++;
//        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //code
    }];
    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    /*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    UILabel *label = nil;
    UIImageView *thumbView = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }else {
        label = (UILabel *)[cell.contentView viewWithTag:101];
        thumbView = (UIImageView*)[cell.contentView viewWithTag:100];
        
        label.text = content[indexPath.row][@"title"];
        thumbView.image = content[indexPath.row][@"imageHref"];
        
//        cell.textLabel.text =content[indexPath.row][@"title"];

    }
    
    return cell;
}


@end
