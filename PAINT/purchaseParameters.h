//
//  purchaseParameters.h
//  Colors Play
//
//  Created by user on 11/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface purchaseParameters : NSObject

@property (nonatomic) BOOL includeColorBook;

@property (nonatomic, retain) NSMutableSet* purchases;

-(id)inAppParameters;
-(id)readFromDefaults;
-(void)writeToDefaults: (id)dic;

@end
