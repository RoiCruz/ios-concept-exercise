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
    NSMutableArray *contentArray;
    NSMutableArray *title;
    
    NSArray *recipes;
}

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated {



}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    contentArray = [[NSMutableArray alloc] init];

    
    //1. convert url
    NSString *urlString = BaseURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2. parse data to dictionary
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"response object is %@", NSStringFromClass([responseObject class]));
        if([responseObject isKindOfClass:[NSDictionary class]]) {
        
        
//            NSDictionary *dic = (NSDictionary *)responseObject;
//            title = [dic objectForKey:@"title"];
//            NSLog(@"title array is: %@", title);
            
            NSDictionary *dic1 = (NSDictionary *)responseObject;
            //content = [dic1 objectForKey:@"rows"];
            //contentArray = [dic1 valueForKeyPath:@"rows"];
            [contentArray addObjectsFromArray:[dic1 valueForKeyPath:@"rows"]];
            
            NSLog(@"content array is: %@", contentArray);

        }

        //data loaded asynchrously so got to call reloadData after setting JSON Values
        [_mTableView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //code
    }];
    [operation start];
    

    
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        NSLog(@"content count is %lu", (unsigned long)[contentArray count]);
        return [contentArray count];
        //return [recipes count];
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellTableIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        }
        
        
        //check if string inside array is empty, first, to avoid crash
        if ([contentArray[indexPath.row][@"title"] isKindOfClass:[NSString class]]) {
            cell.textLabel.text = contentArray[indexPath.row][@"title"]; //add main title
        } else {
            cell.textLabel.text = @"";
        }
        if ([contentArray[indexPath.row][@"description"] isKindOfClass:[NSString class]]) {
            cell.detailTextLabel.text = contentArray [indexPath.row][@"description"]; //add subtitle
        } else {
            cell.detailTextLabel.text = @"";
        }
        
        cell.imageView.image = [UIImage imageNamed:@"sample.png"];

        

        return cell;
}



@end
