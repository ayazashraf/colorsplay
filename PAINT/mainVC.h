//
//  mainVC.h
//  Colors Play
//
//  Created by user on 07/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface mainVC : UIViewController<SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
//    purchaseParameters* inAppPurchaseParams;
    NSMutableDictionary* productsIds;
}

@property (strong, nonatomic) IBOutlet UIButton *btnBook;
@property (strong, nonatomic) IBOutlet UIButton *btnBlank;

- (IBAction)btnForBook:(UIButton *)sender;
- (IBAction)btnForBlank:(UIButton *)sender;
- (IBAction)restorePurchasesClicked:(id)sender;

- (void)setInAppParams;
@end
