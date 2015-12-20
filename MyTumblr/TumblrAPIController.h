//
//  TumblrAPIController.h
//  MyTumblr
//
//  Created by Jakub Kaliszyk on 19.12.2015.
//  Copyright © 2015 Jakub Kaliszyk. All rights reserved.
//


@interface TumblrAPIController : NSObject

+ (BOOL)tumblrUserExists:(NSString*)name;
+ (NSMutableArray*)tumblrUserPhotoPosts:(NSString*)name;

@end
