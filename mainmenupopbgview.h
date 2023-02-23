//
//  mainmenupopbgview.h
//  RLPOS
//
//  Created by user on 9/19/13.
//  Copyright (c) 2013 foreigntree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIPopoverBackgroundView.h>

@interface mainmenupopbgview : UIPopoverBackgroundView
{
    UIImageView *_borderImageView;
    UIImageView *_arrowView;
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}
@end
