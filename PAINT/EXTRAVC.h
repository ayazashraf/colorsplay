//
//  EXTRAVC.h
//  Colors Play
//
//  Created by user on 11/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "purchaseParameters.h"

@interface EXTRAVC : UIViewController<SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    purchaseParameters* purchaseParams;
    NSMutableDictionary* idsToProducts;
}

@property (strong, nonatomic) IBOutlet UIButton *asteroidButton;
@property (strong, nonatomic) IBOutlet UIButton *saucerButton;
@property (strong, nonatomic) IBOutlet UIButton *powerupButton;

-(void)setGameParams:(purchaseParameters*)params;

@end
