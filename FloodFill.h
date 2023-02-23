//
//  FloodFill.h
//  PAINT
//
//  Created by user on 15/08/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedListStack.h"

@interface FloodFill : NSObject

- (UIImage *) floodFillFromPoint:(UIImage *)image :(CGPoint)startPoint withColor:(UIColor *)newColor andTolerance:(int)tolerance startBg:(BOOL)startBg;

-(unsigned int)colorpicker:(UIImage *)image :(CGPoint)point startBg:(BOOL)startBg;

@end
