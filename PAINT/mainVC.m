//
//  mainVC.m
//  Colors Play
//
//  Created by user on 07/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "mainVC.h"
#import "ViewController.h"
#import "bookCategoryVC.h"


@interface mainVC ()

@property (nonatomic) BOOL includeColorBook;

@end

@implementation mainVC

@synthesize includeColorBook;

#define COLORBOOK_ID @"com.foreigntree.ColorsPlay.ColoringBook"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    productsIds = [NSMutableDictionary new];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    NSSet* potentialProducts = [NSSet setWithObjects:COLORBOOK_ID, nil];
    SKProductsRequest* request = [[SKProductsRequest alloc] initWithProductIdentifiers:potentialProducts];
    [request setDelegate:self];
    [request start];
    [self setInAppParams];
    
}

- (void)setInAppParams
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:COLORBOOK_ID])
    {
        [self.btnBook setBackgroundImage:[UIImage imageNamed:@"button_colorbook_unlock.png"] forState:UIControlStateNormal];
        includeColorBook=YES;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:COLORBOOK_ID];
        [self.btnBook setBackgroundImage:[UIImage imageNamed:@"button_colorbook_lock.png"] forState:UIControlStateNormal];
        includeColorBook=NO;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ColorBook Available"])
    {
        [self.btnBook setEnabled:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ColorBook Available"];
        [self.btnBook setEnabled:NO];
    }
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    for (SKProduct* aProduct in response.products)
    {
        if ([aProduct.productIdentifier isEqualToString:COLORBOOK_ID])
        {
            [self.btnBook setEnabled:YES];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ColorBook Available"];
            [productsIds setObject:aProduct forKey:COLORBOOK_ID];
            break;
        }
        else
        {
            [self.btnBook setEnabled:NO];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ColorBook Available"];
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction* transaction in transactions)
    {
        if (transaction.transactionState == SKPaymentTransactionStatePurchased || transaction.
            transactionState == SKPaymentTransactionStateRestored)
        {
            NSString* productIdentifier = transaction.payment.productIdentifier;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
            [self setInAppParams];
            [queue finishTransaction:transaction];
        }
    }
}

- (IBAction)restorePurchasesClicked:(id)sender
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnForBook:(UIButton *)sender
{
    if (includeColorBook)
    {
        bookCategoryVC *bookcategoryvc = (bookCategoryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"book"];
        [self presentViewController:bookcategoryvc animated:YES completion:nil];
    }
    else
    {
        SKProduct* product = [productsIds objectForKey:COLORBOOK_ID];
        SKPayment* payRequest = [SKPayment paymentWithProduct: product]; [[SKPaymentQueue defaultQueue]
                                                                          addPayment:payRequest];
    }
    
}

- (IBAction)btnForBlank:(UIButton *)sender
{
    ViewController *VC = (ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"paintingView"];
    VC.IVmainImageName = @"white.jpg";
    [self presentViewController:VC animated:YES completion:nil];
    
}
@end
