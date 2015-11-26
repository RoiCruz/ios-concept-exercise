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
#import "DataManager.h"


@interface ViewController () {
    NSMutableArray *contentArray;
    NSMutableArray *imageArray;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //get dictionary info then put to workable arrays
    [DataManager getData:^(NSDictionary *info, NSError *err) {
        NSLog(@"Called getData info %@", [info description]);
        if(info != nil) {
            contentArray = [info valueForKey:@"rows"];
            NSLog(@"content array is: %@", contentArray);
            
            imageArray = [contentArray valueForKey:@"imageHref"];
            NSLog(@"image array is: %@", imageArray);
            
            //data loaded asynchrously so got to call reloadData after setting JSON Values
            [_mTableView reloadData];
        }
        else {
            NSLog(@"Info is nil");
        }

    }];
    
    //register custom cell to be used for uitableview
    [self.mTableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"ItemCell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        NSLog(@"content count is %lu", (unsigned long)[contentArray count]);
        return [contentArray count];
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        NSString *CellTableIdentifier = @"ItemCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        //initializing elements on the custom cell nib:
        UILabel *label = nil;
        UIImageView *thumbView = nil;
        UILabel *subtitle = nil;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //remove uitableview selection color
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        }
        
        //resize custom cell upon orientation change
        cell.frame =  CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height);
        
        //connect custom cell's xib elements using tags
        label = (UILabel *)[cell.contentView viewWithTag:101];
        thumbView = (UIImageView*)[cell.contentView viewWithTag:100];
        subtitle = (UILabel *)[cell.contentView viewWithTag:102];
        
        
        //check if a string is valid before output to prevent errors
        
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

        return cell;

}




@end
