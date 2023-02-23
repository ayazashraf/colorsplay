//
//  purchaseParameters.m
//  Colors Play
//
//  Created by user on 11/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "purchaseParameters.h"

@implementation purchaseParameters

#define COLORBOOK_ID @"com.foreigntree.ColorsPlay.ColoringBook"

@synthesize includeColorBook;
@synthesize purchases;

-(id)inAppParameters
{
    purchaseParameters *para = [purchaseParameters new];
    [para setIncludeColorBook:YES];
    para.purchases = [NSMutableSet new];
    return para;
}

-(id)readFromDefaults
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* data = [defaults objectForKey:@"productIds"];
    if (!data)
    {
        NSMutableDictionary *productIds = [NSMutableDictionary new];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:COLORBOOK_ID];
        return productIds;
    }
    else
    {
        return [defaults dictionaryRepresentation];
    }
}

-(void)writeToDefaults: (NSMutableDictionary *)dic
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"productIds"];
//    [defaults setValue:dic forKey:@"productIds"];
    [defaults synchronize];
//    if ([defaults objectForKey:@"in-app-purchase"] == nil)
//    {
//            [defaults setValue:dic forKey:@"in-app-purchase"];
//    }
//    else
//    {
//        [defaults removeObjectForKey:@"in-app-purchase"];
//        [defaults setValue:dic forKey:@"in-app-purchase"];
//    }
//    
//    [defaults synchronize];
}

@end
