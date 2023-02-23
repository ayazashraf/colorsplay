//
//  FloodFill.m
//  PAINT
//
//  Created by user on 15/08/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "FloodFill.h"

@implementation FloodFill


- (UIImage *) floodFillFromPoint:(UIImage *)image :(CGPoint)startPoint withColor:(UIColor *)newColor andTolerance:(int)tolerance;
{
    @try
    {
        /*
         First We create rowData from UIImage.
         We require this conversation so that we can use detail at pixel like color at pixel.
         You can get some discussion about this topic here:
         http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics
         */
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGImageRef imageRef = [image CGImage];
        
        NSUInteger width = CGImageGetWidth(imageRef);
        NSUInteger height = CGImageGetHeight(imageRef);
        unsigned char *imageData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
//        unsigned char *imageData = malloc(height * width * 4);
        
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
        
        unsigned int ocolor = getColorCode(byteIndex, imageData);
        
        //Convert newColor to RGBA value so we can save it to image.
        int newRed, newGreen, newBlue, newAlpha;
        
        const CGFloat *components = CGColorGetComponents(newColor.CGColor);
        
        /*
         If you are not getting why I use CGColorGetNumberOfComponents than read following link:
         http://stackoverflow.com/questions/9238743/is-there-an-issue-with-cgcolorgetcomponents
         */
        
        if(CGColorGetNumberOfComponents(newColor.CGColor) == 2)
        {
            newRed   = newGreen = newBlue = components[0] * 255;
            newAlpha = components[1];
        }
        else if (CGColorGetNumberOfComponents(newColor.CGColor) == 4)
        {
//            [newColor getRed:&newRed green:&newGreen blue:&newBlue alpha:&newAlpha];
            newRed   = components[0] * 255;
            newGreen = components[1] * 255;
            newBlue  = components[2] * 255;
            newAlpha = 255;
        }
        
        unsigned int ncolor = (newRed << 24) | (newGreen << 16) | (newBlue << 8) | newAlpha;
        
        /*
         We are using stack to store point.
         Stack is implemented by LinkList.
         To incress speed I have used NSMutableData insted of NSMutableArray.
         To see Detail Of This implementation visit following leink.
         http://iwantmyreal.name/blog/2012/09/29/a-faster-array-in-objective-c/
         */
        
        LinkedListStack *points = [[LinkedListStack alloc] initWithCapacity:500 incrementSize:500 andMultiplier:height];
        
        int x = startPoint.x;
        int y = startPoint.y;
        
        [points pushFrontX:x andY:y];
        
        /*
         This algorithem is prety simple though it llook odd in Objective C syntex.
         To get familer with this algorithm visit following link.
         http://lodev.org/cgtutor/floodfill.html
         You can read hole artical for knowledge.
         If you are familer with flood fill than got to Scanline Floodfill Algorithm With Stack (floodFillScanlineStack)
         */
        
        unsigned int color;
        BOOL spanLeft,spanRight;
        
        while ([points popFront:&x andY:&y] != INVALID_NODE_CONTENT)
        {
            byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            
            color = getColorCode(byteIndex, imageData);
            
            while(y >= 0 && compareColor(ocolor, color, tolerance))
            {
                y--;
                
                if(y >= 0)
                {
                    byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData);
                }
            }
            
            y++;
            
            spanLeft = spanRight = NO;
            
            byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            
            color = getColorCode(byteIndex, imageData);
            
            while (y < height && compareColor(ocolor, color, tolerance) && ncolor != color)
            {
                //Change old color with newColor RGBA value
//                NSLog(@"%hhu",imageData[byteIndex+0]);
                imageData[byteIndex + 0] =  (char)0;
//                NSLog(@"%hhu",imageData[byteIndex+0]);
                imageData[byteIndex + 1] =  (char)0;
                imageData[byteIndex + 2] =  (char)255;
                imageData[byteIndex + 3] =  (char)255;
                
                if(x > 0)
                {
                    byteIndex = (bytesPerRow * y) + (x - 1) * bytesPerPixel;
                    
                    color = getColorCode(byteIndex, imageData);
                    
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
                    
                    color = getColorCode(byteIndex, imageData);
                    
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
                    
                    color = getColorCode(byteIndex, imageData);
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

unsigned int getColorCode (unsigned int byteIndex, unsigned char *imageData)
{
    unsigned int blue   = imageData[byteIndex];
    unsigned int green = imageData[byteIndex + 1];
    unsigned int red  = imageData[byteIndex + 2];
    unsigned int alpha = imageData[byteIndex + 3];
    
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

-(UIColor *)colorpicker:(UIImage *)image :(CGPoint)point
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
    
    float blue   = (float) imageData[byteIndex]/255;
    float green = (float) imageData[byteIndex + 1]/255;
    float red  = (float) imageData[byteIndex + 2]/255;
    float alpha = (float) imageData[byteIndex + 3]/255;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return color;
    
//    return getColorCode(byteIndex, imageData);
}


void ManipulateImagePixelData(CGImageRef inImage)
{
    // Create the bitmap context
    CGContextRef cgctx = CreateARGBBitmapContext(inImage);
    if (cgctx == NULL)
    {
        // error creating context
        return;
    }
    
    // Get image width, height. We'll use the entire image.
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    void *data = CGBitmapContextGetData (cgctx);
    if (data != NULL)
    {
        
        // **** You have a pointer to the image data ****
        
        // **** Do stuff with the data here ****
        NSLog((__bridge NSString *)(data));
        
    }
    
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data)
    {
        free(data);
    }
    
}

CGContextRef CreateARGBBitmapContext (CGImageRef inImage)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceModelRGB);
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}




@end
