//
//  ViewController.m
//  iOSConceptExercise
//
//  Created by Roi Cruz on 24/11/2015.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

static NSString *const BaseURLString = @"http://guarded-basin-2383.herokuapp.com/facts.json";

@interface ViewController () {
    NSMutableArray *contentArray;
    NSMutableArray *imageArray;
    NSMutableArray *title;
    
    NSArray *recipes;
    NSArray *protoypeImageArray;
}

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated {



}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    contentArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    
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
            
            imageArray = [contentArray valueForKey:@"imageHref"];
            NSLog(@"image array is: %@", imageArray);

        }

        //data loaded asynchrously so got to call reloadData after setting JSON Values
        [_mTableView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //code
    }];
    [operation start];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"MenuCustomCell" bundle:nil] forCellReuseIdentifier:@"MenuItemCell"];


    
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    protoypeImageArray = [NSArray arrayWithObjects:@"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg", nil];

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
        
        NSString *CellTableIdentifier = @"MenuItemCell";
        //static NSString *CellTableIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        UILabel *label = nil;
        UIImageView *thumbView = nil;
        UILabel *subtitle = nil;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        }
        
        // fix - resize custom cell upon orientation change
        cell.frame =  CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height);
        
        label = (UILabel *)[cell.contentView viewWithTag:101];
        thumbView = (UIImageView*)[cell.contentView viewWithTag:100];
        subtitle = (UILabel *)[cell.contentView viewWithTag:102];
        
        if ([contentArray[indexPath.row][@"title"] isKindOfClass:[NSString class]]) {
            label.text = contentArray[indexPath.row][@"title"]; //add main title
        } else {
            label.text = @"";
        }
        if ([contentArray[indexPath.row][@"description"] isKindOfClass:[NSString class]]) {
            subtitle.text = contentArray [indexPath.row][@"description"]; //add subtitle
        } else {
            subtitle.text = @"";
        }

        if ([imageArray[indexPath.row] isKindOfClass:[NSString class]]) {
            NSLog(@"image array is string");
            
            [thumbView setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]]; //lazy load images
        } else {
            thumbView.image = [UIImage imageNamed:@"placeholder.png"];
        }

        
        //check if string inside array is empty, first, to avoid crash
//        if ([contentArray[indexPath.row][@"title"] isKindOfClass:[NSString class]]) {
//            cell.textLabel.text = contentArray[indexPath.row][@"title"]; //add main title
//        } else {
//            cell.textLabel.text = @"";
//        }
//        if ([contentArray[indexPath.row][@"description"] isKindOfClass:[NSString class]]) {
//            cell.detailTextLabel.text = contentArray [indexPath.row][@"description"]; //add subtitle
//        } else {
//            cell.detailTextLabel.text = @"";
//        }
        

//        [cell.imageView setFrame:CGRectMake(0, 0, 20, 20)];
//        [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
//        cell.imageView.layer.cornerRadius = 4;
//        cell.imageView.layer.masksToBounds = YES;
        //cell.imageView.clipsToBounds = YES;
        
//        if ([imageArray[indexPath.row] isKindOfClass:[NSString class]]) {
//            NSLog(@"image array is string");
//
//            [cell.imageView setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        } else {
//            cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
//        }


        return cell;

}




@end
