//
//  FloodFill.m
//  PAINT
//
//  Created by user on 15/08/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "FloodFill.h"

@implementation FloodFill

- (UIImage *) floodFillFromPoint:(UIImage *)image :(CGPoint)startPoint withColor:(UIColor *)newColor andTolerance:(int)tolerance startBg:(BOOL)startBg;
{
    @try
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGImageRef imageRef = [image CGImage];
        
        NSUInteger width = CGImageGetWidth(imageRef);
        NSUInteger height = CGImageGetHeight(imageRef);
        
        unsigned char *imageData = malloc(height * width * 4);
        
        NSUInteger bytesPerPixel = CGImageGetBitsPerPixel(imageRef) / 8;
        NSUInteger bytesPerRow = CGImageGetBytesPerRow(imageRef);
        NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
        
        CGContextRef context = CGBitmapContextCreate(imageData,
                                                     width,
                                                     height,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpace,
                                                     CGImageGetBitmapInfo(imageRef));
        CGColorSpaceRelease(colorSpace);
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        
        //Get color at start point
        unsigned int byteIndex = (bytesPerRow * startPoint.y) + startPoint.x * bytesPerPixel;
        
        unsigned int ocolor = getColorCode(byteIndex, imageData,startBg);
        
        //Convert newColor to RGBA value so we can save it to image.
        int newRed, newGreen, newBlue, newAlpha;
        
        const CGFloat *components = CGColorGetComponents(newColor.CGColor);
        
        if(CGColorGetNumberOfComponents(newColor.CGColor) == 2)
        {
            newRed   = newGreen = newBlue = components[0] * 255;
            newAlpha = components[1];
        }
        else if (CGColorGetNumberOfComponents(newColor.CGColor) == 4)
        {
            newRed   = components[0] * 255;
            newGreen = components[1] * 255;
            newBlue  = components[2] * 255;
            newAlpha = components[3] * 255;
        }
        
        unsigned int ncolor = (newRed << 24) | (newGreen << 16) | (newBlue << 8) | newAlpha;
                LinkedListStack *points = [[LinkedListStack alloc] initWithCapacity:500 incrementSize:500 andMultiplier:height];
        
        int x = startPoint.x;
        int y = startPoint.y;
        
        [points pushFrontX:x andY:y];
        
        unsigned int color;
        BOOL spanLeft,spanRight;
        
        while ([points popFront:&x andY:&y] != INVALID_NODE_CONTENT)
        {
            byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            
            color = getColorCode(byteIndex, imageData,startBg);
            
            while(y >= 0 && compareColor(ocolor, color, tolerance))
            {
                y--;
                
                if(y >= 0)
                {
                    byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData,startBg);
                }
            }
            
            y++;
            
            spanLeft = spanRight = NO;
            
            byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            
            color = getColorCode(byteIndex, imageData,startBg);
            
            while (y < height && compareColor(ocolor, color, tolerance) && ncolor != color)
            {
                //Change old color with newColor RGBA value
//                NSLog(@"%hhu",imageData[byteIndex+0]);
                if (startBg)
                {
                    imageData[byteIndex + 0] = (char) newRed;
                    imageData[byteIndex + 1] = (char) newGreen;
                    imageData[byteIndex + 2] = (char) newBlue;
                    imageData[byteIndex + 3] = (char) newAlpha;
                }
                else
                {
                    imageData[byteIndex + 0] = (char) newBlue;
                    imageData[byteIndex + 1] = (char) newGreen;
                    imageData[byteIndex + 2] = (char) newRed;
                    imageData[byteIndex + 3] = (char) newAlpha;
                }
                
                
                if(x > 0)
                {
                    byteIndex = (bytesPerRow * y) + (x - 1) * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData,startBg);
                    
                    if(!spanLeft && x > 0 && compareColor(ocolor, color, tolerance))
                    {
                        [points pushFrontX:(x - 1) andY:y];
                        
                        spanLeft = YES;
                    }
                    else if(spanLeft && x > 0 && !compareColor(ocolor, color, tolerance))
                    {
                        spanLeft = NO;
                    }
                }
                
                if(x < width - 1)
                {
                    byteIndex = (bytesPerRow * y) + (x + 1) * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData,startBg);
                    
                    if(!spanRight && compareColor(ocolor, color, tolerance))
                    {
                        [points pushFrontX:(x + 1) andY:y];
                        
                        spanRight = YES;
                    }
                    else if(spanRight && !compareColor(ocolor, color, tolerance))
                    {
                        spanRight = NO;
                    }
                }
                
                y++;
                
                if(y < height)
                {
                    byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData,startBg);
                }
            }
        }
        
        //Convert Flood filled image row data back to UIImage object.
        
        CGImageRef newCGImage = CGBitmapContextCreateImage(context);
        
        UIImage *result = [UIImage imageWithCGImage:newCGImage];
        
        CGImageRelease(newCGImage);
        
        CGContextRelease(context);
        
        free(imageData);
        
        return result;
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception : %@", exception);
    }
}

unsigned int getColorCode (unsigned int byteIndex, unsigned char *imageData,BOOL startbg)
{
    unsigned int red;
    unsigned int green;
    unsigned int blue;
    unsigned int alpha;
    if (startbg)
    {
        red   = imageData[byteIndex];
        green = imageData[byteIndex + 1];
        blue  = imageData[byteIndex + 2];
        alpha = imageData[byteIndex + 3];
    }
    else
    {
        blue   = imageData[byteIndex];
        green = imageData[byteIndex + 1];
        red  = imageData[byteIndex + 2];
        alpha = imageData[byteIndex + 3];
        
    }
    return (red << 24) | (green << 16) | (blue << 8) | alpha;
}

bool compareColor (unsigned int color1, unsigned int color2, int tolorance)
{
    if(color1 == color2)
        return true;
    
    int red1   = ((0xff000000 & color1) >> 24);
    int green1 = ((0x00ff0000 & color1) >> 16);
    int blue1  = ((0x0000ff00 & color1) >> 8);
    int alpha1 =  (0x000000ff & color1);
    
    int red2   = ((0xff000000 & color2) >> 24);
    int green2 = ((0x00ff0000 & color2) >> 16);
    int blue2  = ((0x0000ff00 & color2) >> 8);
    int alpha2 =  (0x000000ff & color2);
    
    int diffRed   = abs(red2   - red1);
    int diffGreen = abs(green2 - green1);
    int diffBlue  = abs(blue2  - blue1);
    int diffAlpha = abs(alpha2 - alpha1);
    
    if( diffRed   > tolorance ||
       diffGreen > tolorance ||
       diffBlue  > tolorance ||
       diffAlpha > tolorance  )
    {
        return false;
    }
    
    return true;
}

-(unsigned int)colorpicker:(UIImage *)image :(CGPoint)point startBg:(BOOL)startBg;
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    unsigned char *imageData = malloc(height * width * 4);
    
    NSUInteger bytesPerPixel = CGImageGetBitsPerPixel(imageRef) / 8;
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(imageRef);
    NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    CGContextRef context = CGBitmapContextCreate(imageData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 CGImageGetBitmapInfo(imageRef));
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    //Get color at start point
    unsigned int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    
    return getColorCode(byteIndex, imageData,startBg);
}

@end
