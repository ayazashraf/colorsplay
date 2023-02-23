//
//  EXTRAVC.m
//  Colors Play
//
//  Created by user on 11/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "EXTRAVC.h"

@interface EXTRAVC ()

@end

@implementation EXTRAVC

#define PURCHASE_INGAME_SAUCERS @"com.beltcommander.ingame.saucers"
#define PURCHASE_INGAME_POWERUPS @"com.beltcommander.ingame.powerups"
//....
- (void)viewDidLoad
{
    [super viewDidLoad];
    idsToProducts = [NSMutableDictionary new];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    //Get set of product ids
    NSSet* potentialProducts = [NSSet setWithObjects:PURCHASE_INGAME_SAUCERS,
                                PURCHASE_INGAME_POWERUPS, nil];
    SKProductsRequest* request = [[SKProductsRequest alloc] initWithProductIdentifiers:potentialProducts];
    [request setDelegate:self];
    [request start];
    [self setGameParams: [purchaseParameters readFromDefaults]];
}

-(void)setGameParams:(purchaseParameters*)params
{
    purchaseParams = params;
    NSSet* purchases = [purchaseParams purchases];
    if ([params includeAsteroids]){
        [_asteroidButton setImage:[UIImage imageNamed:@"asteroid active"] forState:UIControlStateNormal];
    } else {
        [_asteroidButton setImage:[UIImage imageNamed:@"asteroid inactive"] forState:UIControlStateNormal];
    }
    if ([purchases containsObject:PURCHASE_INGAME_SAUCERS]){
        if ([params includeSaucers]){
            [_saucerButton setImage:[UIImage imageNamed:@"saucer active"] forState:UIControlStateNormal]; } else {
                [_saucerButton setImage:[UIImage imageNamed:@"saucer inactive"] forState:UIControlStateNormal]; }
    } else {
        [_saucerButton setImage:[UIImage imageNamed:@"saucer purchase"] forState:UIControlStateNormal];
    }
    if ([purchases containsObject:PURCHASE_INGAME_POWERUPS])
    {
        if ([params includePowerups])
        {
            [_powerupButton setImage:[UIImage imageNamed:@"powerup active"] forState:UIControlStateNormal];
        }
        else
        {
                [_powerupButton setImage:[UIImage imageNamed:@"powerup inactive"] forState:UIControlStateNormal];
        }
    }
        else
        {
            [_powerupButton setImage:[UIImage imageNamed:@"powerup purchase"] forState:UIControlStateNormal];
        }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    for (SKProduct* aProduct in response.products)
    {
        if ([aProduct.productIdentifier isEqualToString:PURCHASE_INGAME_SAUCERS])
        {
            [_saucerButton setEnabled:YES];
            [_saucerButton setHidden:NO];
            [idsToProducts setObject:aProduct forKey:PURCHASE_INGAME_SAUCERS];
        }
        else if ([aProduct.productIdentifier isEqualToString:PURCHASE_INGAME_POWERUPS])
        {
            [_powerupButton setEnabled:YES];
            [_powerupButton setHidden:NO];
            [idsToProducts setObject:aProduct forKey:PURCHASE_INGAME_POWERUPS];
        }
    }
}

- (IBAction)saucerButtonClicked:(id)sender
{
    if ([purchaseParams.purchases containsObject:PURCHASE_INGAME_SAUCERS]){
        [purchaseParams setIncludeSaucers:![purchaseParams includeSaucers]];
        [self setGameParams:purchaseParams];
        [purchaseParams writeToDefaults];
    } else {
        SKProduct* product = [idsToProducts objectForKey:PURCHASE_INGAME_POWERUPS];
        SKPayment* payRequest = [SKPayment paymentWithProduct: product]; [[SKPaymentQueue defaultQueue]
                                                                          addPayment:payRequest]; }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction* transaction in transactions)
    {
        if (transaction.transactionState == SKPaymentTransactionStatePurchased || transaction.
            transactionState == SKPaymentTransactionStateRestored){
            NSString* productIdentifier = transaction.payment.productIdentifier;
            [[purchaseParams purchases] addObject: productIdentifier];
            [purchaseParams writeToDefaults];
            [self setGameParams:purchaseParams];
            [queue finishTransaction:transaction];
        }
    }
}

- (IBAction)restorePurchasesClicked:(id)sender
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
