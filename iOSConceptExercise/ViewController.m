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
    
    NSArray *recipes;
}

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated {



}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    content = [[NSMutableArray alloc] init];

    
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
        NSLog(@"first content count is %lu", (unsigned long)content.count);
        NSLog(@"content array is: %@", content);

        //data loaded asynchrously so got to call reloadData after setting JSON Values
        [_mTableView reloadData];

        
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
    

    
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        NSLog(@"content count is %lu", (unsigned long)[content count]);
        return [content count];
        //return [recipes count];
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellTableIdentifier = @"Celll";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        }
        
        cell.textLabel.text = content[indexPath.row][@"description"];

        return cell;
}



@end
