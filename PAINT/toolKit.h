//
//  toolKit.h
//  Colors Play
//
//  Created by user on 19/09/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface toolKit : UIViewController

@property (strong,nonatomic) NSString *StrTitle;
@property (strong,nonatomic) NSString *StrMessage;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UILabel *Title;

@end
