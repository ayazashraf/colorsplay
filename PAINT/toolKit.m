//
//  toolKit.m
//  Colors Play
//
//  Created by user on 19/09/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "toolKit.h"

@interface toolKit ()

@end

@implementation toolKit

@synthesize StrTitle,StrMessage;
@synthesize Title,message;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [Title setText:StrTitle];
    [message setText:StrMessage];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
