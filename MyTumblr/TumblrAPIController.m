//
//  TumblrAPIController.m
//  MyTumblr
//
//  Created by Jakub Kaliszyk on 19.12.2015.
//  Copyright © 2015 Jakub Kaliszyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TumblrAPIController.h"

@implementation TumblrAPIController

NSString* const API_KEY = @"ZNo69fqHQWuzkIjlbdqX1S7AKQyxUbEx4m93id9ibMTLTxNgiL";

//check if user exists on tumblr
+ (BOOL)tumblrUserExists:(NSString*)name {
    //construct url for json response
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@", @"https://api.tumblr.com/v2/blog/", name, @".tumblr.com/info?api_key=", API_KEY];
    //but json response not needed since response data nil if username not found
    NSData *responseData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:url]];
    if (responseData == nil)
        return FALSE;
    
    NSError *error;
    if( error ) {
        NSLog(@"%@", [error localizedDescription]);
        return FALSE;
    }
    return TRUE;
}

//retrieve user's (photo) posts
+ (NSMutableArray*)tumblrUserPhotoPosts:(NSString*)name {
    
    NSMutableArray *photoPostsArray = [NSMutableArray array];
    //construct url for json response
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@", @"https://api.tumblr.com/v2/blog/", name, @".tumblr.com/posts/photo?api_key=", API_KEY];
    NSData *responseData = [[NSData alloc] initWithContentsOfURL:
                            [NSURL URLWithString:url]];
    if (responseData == nil)
        return nil;
    
    NSError *error;
    NSDictionary *parsedJson = [NSJSONSerialization
                                JSONObjectWithData:responseData
                                options:0
                                error:&error];
    
    if( error ) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    }
    else {
        //parse json
        //json arrays
        NSArray *results = [parsedJson valueForKey:@"response"];
        NSArray *posts = [results valueForKey:@"posts"];
        //json dictionary
        for (NSDictionary *post in posts) {
            NSMutableDictionary *details = [[NSMutableDictionary alloc] init];
            [details setObject:[post objectForKey:@"summary"] forKey:@"summary"];
            //check if response is of NSArray class then get first element
            if ([[[[post objectForKey:@"photos"] valueForKey:@"original_size"] valueForKey:@"url"] isKindOfClass:[NSArray class]]) {
                [details setObject:[[[[post objectForKey:@"photos"] valueForKey:@"original_size"] valueForKey:@"url"] objectAtIndex:0 ] forKey:@"url"];
            //or simple string (if that's possible...)
            } else {
                [details setObject:[[[post objectForKey:@"photos"] valueForKey:@"original_size"] valueForKey:@"url"] forKey:@"url"];
            }
            //store summary and original photo to array
            [photoPostsArray addObject:details];
        }
    }
    return photoPostsArray;
}

@end