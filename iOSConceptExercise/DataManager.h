//
//  DataManager.h
//  iOSConceptExercise
//
//  Created by Roi Cruz on 25/11/2015.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (strong, nonatomic) NSDictionary *dic1;

+(void)getData:(void(^)(NSDictionary *info, NSError* err))completion;



@end
