//
//  ViewController.m
//  PAINT
//
//  Created by user on 05/08/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "ViewController.h"
#import"NonRotatingUIImagePickerController.h"
#import "mainmenupopbgview.h"
@interface ViewController ()

@end

@implementation ViewController

#define kTextString "Hello From Quartz"
#define kTextStringLength strlen(kTextString)

@synthesize IVmainImage,IVtempImage;
@synthesize btnRedo,btnUndo;
@synthesize adBannerView;
//@synthesize firstImage,secondImage,thirdImage;
//@synthesize next1Image,next2Image,next3Image;
@synthesize txtBox;
@synthesize capJoinWidthImageView;
@synthesize FontPicker;
@synthesize rslider,gslider,bslider,aslider;
@synthesize rvalue,gvalue,bvalue,avalue;
@synthesize IVmainImageName;

-(void)gesture
{
    UILongPressGestureRecognizer *LongPressgesture;
    UIView *button;
    for (int i=2; i<18; i++)
    {
        LongPressgesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
        button = [self.viewFooter viewWithTag:i];
        [button addGestureRecognizer:LongPressgesture];
    }
}

- (void) handleLongPressFrom: (UILongPressGestureRecognizer *)recognizer
{
    int width = 0,height;
    UIGestureRecognizer *recog = (UIGestureRecognizer*) recognizer;
    if ([recog state]== UIGestureRecognizerStateBegan)
    {
        
        int tag = recog.view.tag;
        UIButton *button=(UIButton *)[self.viewFooter viewWithTag:tag];
        toolkit = (toolKit *)[self.storyboard instantiateViewControllerWithIdentifier:@"toolkit"];
        //    myPopoverController.delegate =self;
        switch (button.tag)
        {
//            case 1:
//                toolkit.StrTitle = [NSString stringWithFormat:@"HELP"];
//                toolkit.StrMessage=[NSString stringWithFormat:@"Press and Hold a Button For a While For its HELP "];
//                width=300;height=75;
//                break;
            case 2:
                toolkit.StrTitle = [NSString stringWithFormat:@"Image Selector"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Select an Image From Your Camera Roll Folder "];
                width=300;height=75;
                break;
            case 3:
                toolkit.StrTitle = [NSString stringWithFormat:@"Image Capture"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Capture an Image From Device Camera "];
                width=300;height=75;
                break;
            case 4:
                toolkit.StrTitle = [NSString stringWithFormat:@"Image Saver"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Save This Image to Your Camera Roll Folder "];
                width=300;height=75;
                break;
            case 5:
                toolkit.StrTitle = [NSString stringWithFormat:@"Line & Point Settings"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Sets the Line's Width, Cap and Join and Point's Width and Cap "];
                width=300;height=75;
                break;
            case 6:
                toolkit.StrTitle = [NSString stringWithFormat:@"Shapes"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Select a Geometry Shape To Draw on Canvas "];
                width=300;height=75;
                break;
            case 7:
                toolkit.StrTitle = [NSString stringWithFormat:@"Text"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Add Text and Select its Font, Size, Char Spacing & Style "];
                width=300;height=75;
                break;
            case 8:
                toolkit.StrTitle = [NSString stringWithFormat:@"Paint Brush"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Tap or Drag Finger to Paint on Canvas "];
                width=300;height=75;
                break;
            case 9:
                toolkit.StrTitle = [NSString stringWithFormat:@"Pencil"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Tap or Drag Finger to Draw on Canvas "];
                width=300;height=75;
                break;
            case 10:
                toolkit.StrTitle = [NSString stringWithFormat:@"Eraser"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Tap or Drag Finger to Erase From Canvas "];
                width=300;height=75;
                break;
            case 11:
                toolkit.StrTitle = [NSString stringWithFormat:@"Paint Bucket"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Fill the Selected Area with Fill Color "];
                width=300;height=75;
                break;
            case 12:
                toolkit.StrTitle = [NSString stringWithFormat:@"Color Picker"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Tap any Where to Pick a Custom Color "];
                width=300;height=75;
                break;
            case 13:
                toolkit.StrTitle = [NSString stringWithFormat:@"Stroke Color Selector"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Select a Stroke/ Outline Color For any Tool "];
                width=300;height=75;
                break;
            case 17:
                toolkit.StrTitle = [NSString stringWithFormat:@"Fill Color Selector"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Select a Fill/ Inner Color For any Tool "];
                width=300;height=75;
                break;
            case 14:
                toolkit.StrTitle = [NSString stringWithFormat:@"Reset"];
                toolkit.StrMessage=[NSString stringWithFormat:@"Reset the Whole canvas for New Drawing "];
                width=300;height=75;
                break;
            
            default:
                width=height=0;
                break;
        }
        myPopoverController = [[UIPopoverController alloc] initWithContentViewController:toolkit];
                        myPopoverController.popoverContentSize=CGSizeMake(width, height);
        myPopoverController.popoverBackgroundViewClass=[mainmenupopbgview class];
        [myPopoverController presentPopoverFromRect:button.frame
                                             inView:self.viewFooter
                           permittedArrowDirections:UIPopoverArrowDirectionDown
                                           animated:YES];
    }
    else if ([recog state]== UIGestureRecognizerStateEnded)
        [myPopoverController dismissPopoverAnimated:YES];
}

- (IBAction)btnForHelp:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HELP"
                                                    message:@"Press and Hold a Button For a While For its HELP"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)colorSlider:(UISlider *)sender
{
    rvalue.text = [NSString stringWithFormat:@"%f",rslider.value];
    gvalue.text = [NSString stringWithFormat:@"%f",gslider.value];
    bvalue.text = [NSString stringWithFormat:@"%f",bslider.value];
    avalue.text = [NSString stringWithFormat:@"%f",aslider.value];
    
    Sred=rslider.value;
    Sgreen=gslider.value;
    Sblue=bslider.value;
    Salpha=aslider.value;
    
    Fred=rslider.value;
    Fgreen=gslider.value;
    Fblue=bslider.value;
    Falpha=aslider.value;
    
    [self.btnScolor setBackgroundColor:[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha]];
    [self.btnFcolor setBackgroundColor:[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha]];
}

-(void)starting
{
    [self.IVmainImage setImage:[UIImage imageNamed:IVmainImageName]];
    selected=@"pencil";
    typeSelected=@"none";
    prevSelectedImagebtn=(UIButton*)[self.viewFooter viewWithTag:9];
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:prevSelectedImagebtn :imageName];
    Scolor=YES;
    [self.btnScolor.backgroundColor getRed:&(Sred) green:&(Sgreen) blue:&(Sblue) alpha:&(Salpha)];
    [self.btnFcolor.backgroundColor getRed:&(Fred) green:&(Fgreen) blue:&(Fblue) alpha:&(Falpha)];
    selection=[[NSArray alloc]initWithObjects:@"pencil",@"line",@"rectangle",@"circle",@"triangle",@"arc",@"erasor",@"text",@"droper",@"paint",@"polygon",@"curve",@"brush",@"upload",@"camera", nil];
    typeSelection=[[NSArray alloc]initWithObjects:@"stroke",@"fill",@"strokefill",@"strokeshadow",@"fillshadow",@"strokefillshadow",@"strokedash", nil];
    Fonts=[[NSArray alloc]initWithObjects:@"ArialRoundedMTBold",@"TimesNewRomanPS-BoldMT",@"Chalkduster",@"Courier",@"Georgia",@"Helvetica",@"Zapfino", nil];
    [FontPicker selectRow:0 inComponent:0 animated:YES];
    fontName=[Fonts objectAtIndex:[FontPicker selectedRowInComponent:0]];
    fontSize=[self.lblFontSize.text floatValue];
    charSpace=[self.lblCharSpacing.text floatValue];
    undoStack=[[NSMutableArray alloc]init];
    redoStack=[[NSMutableArray alloc]init];
    curveControl=NO;

    [self viewImageLoading];
    capJoinWidthImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 334)];
    cap=kCGLineCapRound;
    join=kCGLineJoinMiter;
    lineWidth=self.lineWidthSlider.value;
    [self drawCapJoinWidthLines];
    btnUndo.enabled=NO;
    btnRedo.enabled=NO;
    startBg = YES;
    [self gesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self starting];

    
    adBannerView = [[ADInterstitialAd alloc] init];
    adBannerView.delegate = self;

	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{

  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    if ([touch view]==self.IVtempImage)
    {
        viewSelection=0;
        mouseSwiped = NO;
        Ipoint = Fpoint= [touch locationInView:self.IVtempImage];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch view]==self.IVtempImage)
    {
        mouseSwiped = YES;
        CGPoint currentPoint = [touch locationInView:self.IVtempImage];
        
        switch ([selection indexOfObject:selected])
        {
            case 0:
                [self drawPoint:Fpoint :currentPoint:1.0];
                break;
            case 1:
                self.IVtempImage.image = self.IVmainImage.image;
                [self drawLine:Ipoint :currentPoint];
                break;
            case 2:
                self.IVtempImage.image = self.IVmainImage.image;
                [self drawRect:Ipoint :(Fpoint.x-Ipoint.x):(Fpoint.y-Ipoint.y)];
                break;
            case 3:
                self.IVtempImage.image = self.IVmainImage.image;
                [self drawCircle:Ipoint :(currentPoint.x-Ipoint.x):(currentPoint.y-Ipoint.y)];
                break;
            case 5:
                self.IVtempImage.image = self.IVmainImage.image;
                [self drawArc:Ipoint :Fpoint:(Fpoint.y-Ipoint.y)];
                break;
            case 6:
                [self drawPoint:Fpoint :currentPoint:lineWidth];
                break;
            case 10:
                self.IVtempImage.image = self.IVmainImage.image;
                if (poly)
                {
                    [self drawPolygon:Ipoint :currentPoint];
                    polyPoints=[[NSMutableArray alloc]init];
                    NSNumber *x=[[NSNumber alloc]initWithFloat:Ipoint.x];
                    NSNumber *y=[[NSNumber alloc]initWithFloat:Ipoint.y];
                    [polyPoints addObject:x];
                    [polyPoints addObject:y];
                }
                else
                    [self drawPolygon:LastPolyPoint :currentPoint];
                break;
            case 11:
                if (curveControl)
                {
                    self.IVmainImage.image=[self undoPop];
                    [self undoPush:self.IVmainImage.image];
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawCurve:curve1 :curve2 :currentPoint];
                }
                else
                {
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawLine:Ipoint :currentPoint];
                    curve1=Ipoint;
                    curve2=currentPoint;
                }
                break;
            case 12:
                [self drawPoint:Fpoint :currentPoint:lineWidth];
                break;
        }
        
        Fpoint = currentPoint;
        //    Ipoint=currentPoint;
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch view]==self.IVtempImage)
    {
        if (!mouseSwiped)
        {
            Fpoint=Ipoint;
            
            switch ([selection indexOfObject:selected])
            {
                case 0:
                    [self drawPoint:Fpoint :Fpoint:1.0];
                    break;
                case 1:
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawLine:Ipoint :Fpoint];
                    break;
                case 2:
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawRect:Ipoint :(Fpoint.x-Ipoint.x):(Fpoint.y-Ipoint.y)];
                    break;
                case 3:
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawCircle:Ipoint :(Fpoint.x-Ipoint.x):(Fpoint.y-Ipoint.y)];
                    break;
//                case 4:
//                    break;
                case 5:
                    self.IVtempImage.image = self.IVmainImage.image;
                    [self drawArc:Ipoint :Fpoint:(Fpoint.y-Ipoint.y)];
                    break;
                case 6:
                    [self drawPoint:Fpoint :Fpoint:lineWidth];
                    break;
                case 7:
                {
                    [self textplacement];
                    
                    UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
                    
                    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
                    selected=[array objectAtIndex:0];
                    typeSelected=[array objectAtIndex:1];
                    
                    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
                    prevSelectedImagebtn=PressedButton;
                    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
                    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
                    [self updateSelectedBtnPic:PressedButton :imageName];
                    break;
                }
                case 8:
                    [self colorPicker];
                    break;
                case 9:
                    [self paintBucketNew:Ipoint];
                    break;
                case 10:
                    self.IVtempImage.image = self.IVmainImage.image;
                    if (poly)
                    {
                        [self drawPolygon:Ipoint :Fpoint];
                        polyPoints=[[NSMutableArray alloc]init];
                        NSNumber *x=[[NSNumber alloc]initWithFloat:Ipoint.x];
                        NSNumber *y=[[NSNumber alloc]initWithFloat:Ipoint.y];
                        [polyPoints addObject:x];
                        [polyPoints addObject:y];
                    }
                    else
                        [self drawPolygon:LastPolyPoint :Fpoint];
                    LastPolyPoint=Fpoint;
                    break;
                case 11:
                    if (curveControl)
                        curveControl=NO;
                    else
                        curveControl=YES;
                    break;
                case 12:
                    [self drawPoint:Fpoint :Fpoint:lineWidth];
                    break;
                case 13:
                {
                    [self textplacement];
                    UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
                    
                    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
                    selected=[array objectAtIndex:0];
                    typeSelected=[array objectAtIndex:1];
                    
                    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
                    prevSelectedImagebtn=PressedButton;
                    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
                    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
                    [self updateSelectedBtnPic:PressedButton :imageName];
                    break;
                }
                case 14:
                {
                    [self textplacement];
                    UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
                    
                    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
                    selected=[array objectAtIndex:0];
                    typeSelected=[array objectAtIndex:1];
                    
                    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
                    prevSelectedImagebtn=PressedButton;
                    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
                    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
                    [self updateSelectedBtnPic:PressedButton :imageName];
                    break;
                }
            }
        }
        if ([selected isEqualToString:@"polygon"])
        {
            poly=NO;
            LastPolyPoint=Fpoint;
        }
        if ([selected isEqualToString:@"curve"])
        {
            if (curveControl)
                curveControl=NO;
            else
                curveControl=YES;
        }
        if (![selected isEqualToString:@"paint"])
        {
            UIGraphicsBeginImageContext(self.IVmainImage.frame.size);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
            [self.IVmainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98) blendMode:kCGBlendModeNormal alpha:1.0];
            [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)     blendMode:kCGBlendModeNormal alpha:Salpha];
            [self undoPush:self.IVmainImage.image];
            //            || ([selected isEqualToString:@"curve"] && curveControl) )
            //            [self undoPop];
            btnUndo.enabled=YES;
            self.IVmainImage.image = UIGraphicsGetImageFromCurrentImageContext();
            self.IVtempImage.image = nil;
            UIGraphicsEndImageContext();
            startBg=NO;
        }
    }
}

-(void)undoPush: (UIImage *)image
{
    [undoStack addObject:image];
}

-(void)redoPush: (UIImage *)image
{
    [redoStack addObject:image];
}

-(UIImage *)undoPop
{
    UIImage *image=[undoStack objectAtIndex:undoStack.count-1];
    [undoStack removeLastObject];
    return image;
}

-(UIImage *)redoPop
{
    UIImage *image=[redoStack objectAtIndex:redoStack.count-1];
    [redoStack removeLastObject];
    return image;
}

-(void)colorPicker
{
    FloodFill *obj=[[FloodFill alloc]init];
    unsigned int color;
    color = [obj colorpicker:IVmainImage.image :Ipoint startBg:startBg];
    Sred   = ((0xff000000 & color) >> 24)/255.0;
    Sgreen = ((0x00ff0000 & color) >> 16)/255.0;
    Sblue  = ((0x0000ff00 & color) >> 8)/255.0;
    Salpha =  (0x000000ff & color)/255.0;
    [self.btnScolor setBackgroundColor:[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha]];
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    [self shapeSelection:(UIButton *)[self.viewFooter viewWithTag:8]];
}

-(void)textplacement
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    UIImage *img=imgvw.image;
    //                CGImageRef image=[img CGImage];
    //                CGContextDrawImage(UIGraphicsGetCurrentContext(), testVw.frame, image);
    [img drawInRect:CGRectMake(testVw.frame.origin.x, testVw.frame.origin.y, imgvw.frame.size.width, imgvw.frame.size.height)];
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",self.IVtempImage.image.size.width,self.IVtempImage.image.size.height);
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
    [testVw removeFromSuperview];
}

-(void)start: (NSString *)forWhat
{
    [testVw removeFromSuperview];
    
    //In visible background view
    testVw = [[UIView alloc]initWithFrame:CGRectMake(400, 150, 200, 200)];
    testVw.backgroundColor = [UIColor clearColor];
    testVw.userInteractionEnabled=YES;
    testVw.tag=500;
    [self.view addSubview:testVw];

//    //Content view
    imgvw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, testVw.frame.size.width, testVw.frame.size.height)];
    imgvw.backgroundColor = [UIColor clearColor];
    imgvw.layer.borderColor = [[UIColor brownColor]CGColor];
    imgvw.layer.borderWidth = 2.0f;
    if ([forWhat isEqualToString:@"text"])
        [self textDraw];
    else
        [self imageDraw];
    imgvw.userInteractionEnabled = YES;
    UIPanGestureRecognizer * imgMove = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImg:)];
    [imgvw addGestureRecognizer:imgMove];
    [testVw addSubview:imgvw];
    
    //Close button view which is in top left corner
    closeVw = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -10, 40, 40)];
    closeVw.backgroundColor = [UIColor clearColor];
    closeVw.image = [UIImage imageNamed:@"main_close.png" ];
    closeVw.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [closeVw addGestureRecognizer:singleTap];
    
    [testVw addSubview:closeVw];
    
    //Resizing view which is in bottom right corner
    resizeVw = [[UIImageView alloc]initWithFrame:CGRectMake(testVw.frame.size.width-30, testVw.frame.size.height-30, 40, 40)];
    resizeVw.backgroundColor = [UIColor clearColor];
    resizeVw.userInteractionEnabled = YES;
    resizeVw.image = [UIImage imageNamed:@"main_resize.png" ];
    
    [testVw addSubview:resizeVw];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [resizeVw addGestureRecognizer:panResizeGesture];
    
    //Rotating view which is in bottom left corner
//    rotateVw = [[UIImageView alloc]initWithFrame:CGRectMake(-12, testVw.frame.size.height-12, 24, 24)];
//    rotateVw.backgroundColor = [UIColor clearColor];
//    rotateVw.image = [UIImage imageNamed:@"9.png" ];
//    rotateVw.userInteractionEnabled = YES;
//    [testVw addSubview:rotateVw];
//    
//    UIPanGestureRecognizer * panRotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
//    [rotateVw addGestureRecognizer:panRotateGesture];
//    [panRotateGesture requireGestureRecognizerToFail:panResizeGesture];
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    testVw.transform = CGAffineTransformScale(testVw.transform, scale, scale);
    pinchRecognizer.scale = 1.0;
}

-(void)moveImg:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.IVtempImage];

    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        NSLog(@"%f",[recognizer view].superview.frame.origin.x);
        NSLog(@"%f",[recognizer view].superview.frame.origin.y);
        xDiff = point.x-[recognizer view].superview.frame.origin.x;
        yDiff = point.y-[recognizer view].superview.frame.origin.y;
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        point = [recognizer locationInView:self.view];
        CGRect rect= CGRectMake(point.x-xDiff, point.y-yDiff, testVw.bounds.size.width, testVw.bounds.size.height);
        testVw.frame = rect;
    }
}

-(void)singleTap:(UIPanGestureRecognizer *)recognizer
{
    UIView * close = (UIView *)[recognizer view];
    [close.superview removeFromSuperview];
    
    UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
    
    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
    selected=[array objectAtIndex:0];
    typeSelected=[array objectAtIndex:1];
    
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    prevSelectedImagebtn=PressedButton;
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:PressedButton :imageName];
    
//    if ([selected isEqual:@"upload"])
//    {
//        UIButton *button=(UIButton *)[self.viewFooter viewWithTag:2];
//        [self updateSelectedBtnPic:button :@"main_upload.png"];
//        selected=@"pencil";
//        typeSelected=@"none";
//    }
//    else if ([selected isEqual:@"camera"])
//    {
//        UIButton *button=(UIButton *)[self.viewFooter viewWithTag:3];
//        [self updateSelectedBtnPic:button :@"main_camera.png"];
//        selected=@"pencil";
//        typeSelected=@"none";
//    }
    
}

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:testVw.superview];
        [testVw setNeedsDisplay];
        
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (testVw.bounds.size.width < 20)
        {            
            testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, 20, testVw.bounds.size.height);
            imgvw.frame = CGRectMake(0, 0, testVw.frame.size.width, testVw.frame.size.height);
            resizeVw.frame =CGRectMake(testVw.frame.size.width-30, testVw.frame.size.height-30, 40, 40);
//            rotateVw.frame = CGRectMake(-12, testVw.frame.size.height-20, 30, 30);
            closeVw.frame = CGRectMake(-10, -10, 40, 40);
        }
        
        if(testVw.bounds.size.height < 20)
        {
            testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, testVw.bounds.size.width, 20);
            imgvw.frame = CGRectMake(0, 0, testVw.frame.size.width, testVw.frame.size.height);
            resizeVw.frame =CGRectMake(testVw.frame.size.width-30, testVw.frame.size.height-30, 40, 40);
//            rotateVw.frame = CGRectMake(-12, testVw.frame.size.height-12, 24, 24);
            closeVw.frame = CGRectMake(-10, -10, 40, 40);
            
            
        }
        
        CGPoint point = [recognizer locationInView:testVw.superview];
        float wChange = 0.0, hChange = 0.0;
        
        wChange = (point.x - prevPoint.x); //Slow down increment
        hChange = (point.y - prevPoint.y); //Slow down increment
        
        
        testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, testVw.bounds.size.width + (wChange), testVw.bounds.size.height + (hChange));
        imgvw.frame = CGRectMake(0, 0, testVw.frame.size.width, testVw.frame.size.height);
        if ([selected isEqualToString:@"text"])
            [self textDraw];
        else
            [self imageDraw];
        resizeVw.frame =CGRectMake(testVw.frame.size.width-30, testVw.frame.size.height-30, 40, 40);
//        rotateVw.frame = CGRectMake(-12, testVw.frame.size.height-12, 24, 24);
        closeVw.frame = CGRectMake(-10, -10, 40, 40);
        
        prevPoint = [recognizer locationInView:testVw.superview];
        
        [testVw setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        
        prevPoint = [recognizer locationInView:testVw.superview];
        [testVw setNeedsDisplay];
    }
}

-(void)rotateViewPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        deltaAngle = atan2([recognizer locationInView:testVw].y-testVw.center.y, [recognizer locationInView:testVw].x-testVw.center.x);
        startTransform = testVw.transform;
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        float ang = atan2([recognizer locationInView:testVw.superview].y - testVw.center.y, [recognizer locationInView:testVw.superview].x - testVw.center.x);
        float angleDiff = deltaAngle - ang;
        testVw.transform = CGAffineTransformMakeRotation(-angleDiff);
        [testVw setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        deltaAngle = atan2([recognizer locationInView:testVw].y-testVw.center.y, [recognizer locationInView:testVw].x-testVw.center.x);
        startTransform = testVw.transform;
        [testVw setNeedsDisplay];
    }
}

- (IBAction)viewSelection:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    
        switch (viewSelection)
        {
            case 13:
                [self viewMoveDown:13];
                @try {
                    if ([PressedButton.titleLabel.text isEqualToString:@"SCOLOR"])
                        Scolor=YES;
                    else
                        Scolor=NO;
                }
                @catch (NSException *exception) {
                    NSLog(@"%@",exception.reason);
                }
                
                if (PressedButton.tag!=13)
                    [self viewMoveUp:PressedButton.tag];
                break;
            case 17:
                [self viewMoveDown:17];
                @try {
                    if ([PressedButton.titleLabel.text isEqualToString:@"SCOLOR"])
                        Scolor=YES;
                    else
                        Scolor=NO;
                }
                @catch (NSException *exception) {
                    NSLog(@"%@",exception.reason);
                }
                
                if (PressedButton.tag!=17)
                    [self viewMoveUp:PressedButton.tag];
                break;
            case 7:
                [self viewMoveDown:7];
//                
                if (PressedButton.tag!=7)
                    [self viewMoveUp:PressedButton.tag];
                break;
            case 6:
            {
                [self viewMoveDown:6];
                if (PressedButton.tag!=6)
                    [self viewMoveUp:PressedButton.tag];
                break;
            }
            case 5:
                [self viewMoveDown:5];
                if (PressedButton.tag!=5)
                    [self viewMoveUp:PressedButton.tag];
                break;
            default:
                @try {
                    if ([PressedButton.titleLabel.text isEqualToString:@"SCOLOR"])
                        Scolor=YES;
                    else if ([PressedButton.titleLabel.text isEqualToString:@"FCOLOR"])
                        Scolor=NO;
                }
                @catch (NSException *exception) {
                    NSLog(@"%@",exception.reason);
                }
                [self viewMoveUp:PressedButton.tag];
                break;
        }
}

-(void)viewMoveUp:(int)tag
{
//    if (tag==200) {
//        [self start];
//    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    
    if (tag==13)
    {
        self.viewColourSelection.hidden=NO;
        self.viewStationarySelection.hidden=YES;
        self.viewsettings.hidden=YES;
        self.viewTextSelection.hidden=YES;
        
        self.viewSettings.frame = CGRectMake(0, 382, 1024, 300);
        [UIView commitAnimations];
        viewSelection=13;
    }
    if (tag==17)
    {
        self.viewColourSelection.hidden=NO;
        self.viewStationarySelection.hidden=YES;
        self.viewsettings.hidden=YES;
        self.viewTextSelection.hidden=YES;
        
        self.viewSettings.frame = CGRectMake(0, 382, 1024, 300);
        [UIView commitAnimations];
        viewSelection=17;
    }
    else if (tag==7)
    {
//        selected=@"text";
        txtBox.backgroundColor=[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha];
        txtBox.textColor=[UIColor colorWithRed:Fred green:Fgreen blue:Fblue alpha:Falpha];
        
        self.viewColourSelection.hidden=YES;
        self.viewStationarySelection.hidden=YES;
        self.viewsettings.hidden=YES;
        self.viewTextSelection.hidden=NO;
        
        self.viewSettings.frame = CGRectMake(0, 382, 1024, 300);
        [UIView commitAnimations];
        viewSelection=7;
    }
    else if (tag==6)
    {
        self.viewColourSelection.hidden=YES;
        self.viewStationarySelection.hidden=NO;
        self.viewsettings.hidden=YES;
        self.viewTextSelection.hidden=YES;
        
        self.viewSettings.frame = CGRectMake(0, 382, 1024, 300);
        [UIView commitAnimations];
        viewSelection=6;
    }
    else if (tag==5)
    {
        self.viewColourSelection.hidden=YES;
        self.viewStationarySelection.hidden=YES;
        self.viewsettings.hidden=NO;
        self.viewTextSelection.hidden=YES;
        
        self.viewSettings.frame = CGRectMake(0, 382, 1024, 300);
        [UIView commitAnimations];
        viewSelection=5;
    }
}

-(void)viewMoveDown:(int)tag
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];

    if (tag==13 && viewSelection == 13)
    {
        self.viewSettings.frame = CGRectMake(0, 650, 1024, 300);
        [UIView commitAnimations];
        viewSelection=0;
    }
    else if (tag==17 && viewSelection == 17)
    {
        self.viewSettings.frame = CGRectMake(0, 650, 1024, 300);
        [UIView commitAnimations];
        viewSelection=0;
    }
    else if (tag==7 && viewSelection == 7)
    {
        self.self.viewSettings.layer.frame = CGRectMake(0, 650, 1024, 300);
        [UIView commitAnimations];
        viewSelection=0;
    }
    else if (tag==6 && viewSelection == 6)
    {
        self.self.viewSettings.layer.frame = CGRectMake(0, 650, 1024, 300);
        [UIView commitAnimations];
        viewSelection=0;
    }
    else if (tag==5 && viewSelection == 5)
    {
        self.self.viewSettings.layer.frame = CGRectMake(0, 650, 1024, 300);
        [UIView commitAnimations];
        viewSelection=0;
    }
}

- (void)flipViews
{
//    [UIView transitionWithView:self.viewColourSelection
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{ [self.viewColourSelection removeFromSuperview]; [self.view addSubview:self.viewStationarySelection]; }
//                    completion:NULL];
    
	[UIView transitionFromView:(viewSelection==100) ? self.viewStationarySelection : self.viewColourSelection
						toView:(viewSelection==100) ? self.viewColourSelection : self.viewStationarySelection
					  duration:0.75
					   options:(viewSelection==100 ? UIViewAnimationOptionTransitionFlipFromBottom : UIViewAnimationOptionTransitionFlipFromTop)
					completion:^(BOOL finished) {
						if (finished) {
							viewSelection= 200;
						}
					}];
}

- (IBAction)btnRedo:(id)sender
{
    if (redoStack.count>0) {
        
        [self undoPush:self.IVmainImage.image];
        self.IVmainImage.image=[self redoPop];
        btnUndo.enabled=YES;
        if (redoStack.count==0)
            btnRedo.enabled=NO;
    }
//    btnUndo.enabled=YES;
//    undo++;
//    if (--redo<1)
//        btnRedo.enabled=NO;
//    thirdImage=secondImage;
//    secondImage=firstImage;
//    firstImage=IVmainImage.image;
//    IVmainImage.image=next1Image;
//    next1Image=next2Image;
//    next2Image=next3Image;
}

- (IBAction)btnUndo:(id)sender
{
    if (undoStack.count>0)
    {
        [self redoPush:self.IVmainImage.image];
        self.IVmainImage.image=[self undoPop];
        btnRedo.enabled=YES;
        if (undoStack.count==0)
            btnUndo.enabled=NO;
    }
    
//    btnRedo.enabled=YES;
//    redo++;
//    if (--undo<1)
//        btnUndo.enabled=NO;
//    next3Image=next2Image;
//    next2Image=next1Image;
//    next1Image=IVmainImage.image;
//    IVmainImage.image=firstImage;
//    firstImage=secondImage;
//    secondImage=thirdImage;
}

- (IBAction)btnReset:(id)sender
{
    UIImage *iamge=[UIImage imageNamed:@"white.jpg"];
//    [self undoPush:self.IVmainImage.image];
    self.IVmainImage.image=iamge;
//    [self viewDidLoad];
    testVw=nil;
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    [self starting];
}

- (IBAction)btnPencil:(id)sender
{
//    brush = 1.0;
//    pencil = YES;
    selected=@"pencil";
//    lineSelected=@"stroke";
}

- (IBAction)btnText:(id)sender
{
//    text=YES;
//    pencil=line=arc=rectangle=circle=triangle=NO;
    selected=@"text";
    txtBox.hidden=NO;
    [self start:@"text"];
}

- (IBAction)txtChanged:(id)sender
{
    [self textDraw];
}

- (IBAction)txtBegin:(id)sender
{
    UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:7];
    
    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
    selected=[array objectAtIndex:0];
    typeSelected=[array objectAtIndex:1];
    
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    prevSelectedImagebtn=PressedButton;
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:PressedButton :imageName];
    [self start:@"text"];
}

- (IBAction)btnColorPicker:(id)sender
{
    [self updateSelectedBtnPic:sender:@"hover_droper.png"];
    selected = @"picker";
}

- (IBAction)btnBrush:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    selected=@"brush";
    [self updateSelectedBtnPic:PressedButton:@"hover_upload.png"];
}

- (IBAction)btnTextDone:(UIButton *)sender
{
//    if (viewSelection==7) {
//        [self start:@"text"];
//        [self viewMoveDown:7];
//    }
}

-(void)textDraw
{
    imgvw.image=nil;
    UIGraphicsBeginImageContext(imgvw.frame.size);
    [imgvw.image drawInRect:CGRectMake(0, 0, imgvw.frame.size.height, imgvw.frame.size.width)];
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGFloat w, h;
    w = imgvw.frame.size.width;
    h = imgvw.frame.size.height;
    
    CGContextSelectFont(context, [fontName UTF8String], fontSize, kCGEncodingMacRoman);
    CGContextSetCharacterSpacing(context, charSpace);
    CGContextSetTextDrawingMode (context, textDrawMode); // 5
    
    CGContextSetRGBFillColor(context, Fred, Fgreen, Fblue, Falpha);
	CGContextSetRGBStrokeColor(context, Sred, Sgreen, Sblue, Salpha);

    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
	CGContextShowTextAtPoint(context, 0, imgvw.center.y, [txtBox.text UTF8String], strlen([txtBox.text UTF8String]));
	
    imgvw.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)drawText: (CGPoint)point :(const char*)str :(int)strLength
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetRGBFillColor(context, Fred, Fgreen, Fblue, Falpha);
	CGContextSetRGBStrokeColor(context, Sred, Sgreen, Sblue, Salpha);
    
	// Some initial setup for our text drawing needs.
	// First, we will be doing our drawing in Helvetica-36pt with the MacRoman encoding.
	// This is an 8-bit encoding that can reference standard ASCII characters
	// and many common characters used in the Americas and Western Europe.
	CGContextSelectFont(context, "Helvetica", 36.0, kCGEncodingMacRoman);
	// Next we set the text matrix to flip our text upside down. We do this because the context itself
	// is flipped upside down relative to the expected orientation for drawing text (much like the case for drawing Images & PDF).
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
	// And now we actually draw some text. This screen will demonstrate the typical drawing modes used.
	CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextShowTextAtPoint(context, point.x, point.y, str, strLength);
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",self.IVtempImage.image.size.width,self.IVtempImage.image.size.height);
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (IBAction)colorSelected:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    UIColor *color=PressedButton.backgroundColor;
    if (Scolor)
    {
        [color getRed:&(Sred) green:&(Sgreen) blue:&(Sblue) alpha:&(Salpha)];
        self.btnScolor.backgroundColor=[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha];
    }
    else
    {
        [color getRed:&(Fred) green:&(Fgreen) blue:&(Fblue) alpha:&(Falpha)];
        self.btnFcolor.backgroundColor=[UIColor colorWithRed:Fred green:Fgreen blue:Fblue alpha:Falpha];
    }
}

-(IBAction)shapesSelected:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    NSArray *arr = [[NSArray alloc]initWithObjects:@"hello",@"hehehe", nil];
    switch ([arr indexOfObject:@"hello"])
    {
        case 0:
            NSLog(@"%@",[arr objectAtIndex:0]);
            break;
        default:
            break;
    }
    switch(PressedButton.tag)
    {
        case 11:
            selected=@"rectangle";
//            rectangle=YES;
//            circle=triangle=arc=line=erasor=pencil=NO;
            break;
        case 12:
            selected=@"triangle";
//            triangle=YES;
//            circle=rectangle=arc=line=erasor=pencil=NO;
            break;
        case 13:
            selected=@"circle";
//            circle=YES;
//            rectangle=triangle=arc=line=erasor=pencil=NO;
            break;
        case 14:
            selected=@"line";
//            line=YES;
//            rectangle=triangle=circle=erasor=arc=pencil=NO;
            break;
        case 15:
            selected=@"line";
//            line=YES;
            [[UIColor whiteColor] getRed:&(Sred) green:&(Sgreen) blue:&(Sblue) alpha:&(Salpha)];
//            red=green=blue=255;
//            rectangle=triangle=circle=erasor=arc=pencil=NO;
            break;
        case 16:
            selected=@"arc";
//            arc=YES;
//            rectangle=triangle=circle=line=erasor=pencil=NO;
            break;
        case 17:
            selected=@"paint";
//            rectangle=triangle=circle=line=erasor=arc=pencil=NO;
            break;
        case 18:
            selected=@"polygon";
            poly=YES;
            //            rectangle=triangle=circle=line=erasor=arc=pencil=NO;
            break;
            
    }
}

- (IBAction)shapeSelection:(id)sender
{
    if (viewSelection!=0)
        [self viewMoveDown:viewSelection];
    if ([selected isEqual:@"upload"] && [testVw superview]!=NULL)
    {
        [self textplacement];
        UIButton *button=(UIButton *)[self.viewFooter viewWithTag:2];
        [self updateSelectedBtnPic:button :@"main_upload.png"];
    }
    else if ([selected isEqual:@"camera"] && [testVw superview]!=NULL)
    {
        [self textplacement];
        UIButton *button=(UIButton *)[self.viewFooter viewWithTag:3];
        [self updateSelectedBtnPic:button :@"main_camera.png"];
    }
    else if ([selected isEqualToString:@"text"])
        [self textplacement];
    UIButton * PressedButton = (UIButton*)sender;
    
    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
    selected=[array objectAtIndex:0];
    typeSelected=[array objectAtIndex:1];
    
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    prevSelectedImagebtn=PressedButton;
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:PressedButton :imageName];
    if ([selected isEqualToString:@"polygon"])
        poly=YES;
    else if([selected isEqualToString:@"bucket"])
        selected=@"paint";
    else if ([selected isEqualToString:@"ereaser"])
    {
        selected=@"erasor";
//        Sred=Sgreen=Sblue=Salpha=1;
//        self.btnScolor.backgroundColor=[UIColor colorWithRed:Sred green:Sgreen blue:Sblue alpha:Salpha];
    }
}

- (IBAction)ToolKitByLongPress:(UILongPressGestureRecognizer *)sender
{
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*) sender;
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        
    int tag = recognizer.view.tag;
    UIButton *button=(UIButton *)[self.viewFooter viewWithTag:tag];
    toolkit = (toolKit *)[self.storyboard instantiateViewControllerWithIdentifier:@"toolkit"];
    //    myPopoverController.delegate =self;
    switch (button.tag)
    {
        case 1:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 2:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 3:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 4:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 5:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 6:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 7:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 8:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 9:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 10:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 11:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 12:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 13:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 14:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
        case 15:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",button.tag];
            break;
            
        default:
            break;
    }
    myPopoverController = [[UIPopoverController alloc] initWithContentViewController:toolkit];
    myPopoverController.popoverContentSize=CGSizeMake(50, 50);
    [myPopoverController presentPopoverFromRect:button.frame
                                         inView:self.viewFooter
                       permittedArrowDirections:UIPopoverArrowDirectionDown
                                       animated:YES];
    }
    else if ([recognizer state]== UIGestureRecognizerStateEnded)
         [myPopoverController dismissPopoverAnimated:YES];
}

- (IBAction)repeat:(UIButton *)sender
{
    toolkit = (toolKit *)[self.storyboard instantiateViewControllerWithIdentifier:@"toolkit"];
    //    myPopoverController.delegate =self;
    switch (sender.tag)
    {
        case 1:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 2:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 3:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 4:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 5:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 6:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 7:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 8:
                toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 9:
            toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 10:
                           toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 11:
                     toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 12:
                           toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 13:
                           toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 14:
                          toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
        case 15:
                            toolkit.StrMessage=[NSString stringWithFormat:@"%i",sender.tag];
            break;
            
        default:
            break;
    }
    myPopoverController = [[UIPopoverController alloc] initWithContentViewController:toolkit];
    myPopoverController.popoverContentSize=CGSizeMake(50, 50);
    [myPopoverController presentPopoverFromRect:sender.frame
                                         inView:self.viewFooter
                       permittedArrowDirections:UIPopoverArrowDirectionDown
                                       animated:YES];
    
}

- (void)paintBucketNew:(CGPoint)ipoint
{
    FloodFill *abc=[[FloodFill alloc]init];
    UIImage *image1 = [abc floodFillFromPoint:[self.IVmainImage image] :ipoint withColor:[UIColor colorWithRed:Fred green:Fgreen blue:Fblue alpha:Falpha] andTolerance:5 startBg:startBg];
    [self undoPush:self.IVmainImage.image];
    btnUndo.enabled=YES;
    self.IVmainImage.image = image1;
}

-(void)bucket: (NSArray *)pointss
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0 );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    for (int i=0; i<pointss.count; i=i+2) {
        CGFloat x=[[pointss objectAtIndex:i] floatValue];
        CGFloat y=[[pointss objectAtIndex:i+1] floatValue];
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x, y);
        CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
        CGContextStrokePath(context);
    }
    
    CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
    CGContextStrokePath(context);
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (void)drawRect:(CGPoint)ipoint :(float)width :(float)height
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGRect rect = CGRectMake(ipoint.x,ipoint.y,width,height);
    
    switch ([typeSelection indexOfObject:typeSelected])
    {
        case 0:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokeRect(context,rect);
            break;
        case 1:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextFillRect(context, rect);
            break;
        case 2:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextStrokeRect(context,rect);
            CGContextFillRect(context, rect);
            break;
        case 3:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokeRect(context,rect);
            break;
        case 4:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextFillRect(context, rect);
            break;
        case 5:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokeRect(context,rect);
            CGContextFillRect(context, rect);
            break;
        case 6:
        {   CGFloat patterns[] = {10.0,10.0};
            CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokeRect(context,rect);
            break;
        }
        default:
            break;
    }
    CGContextAddRect(context, rect);
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (IBAction)btnforHome:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)drawCircle:(CGPoint)ipoint :(float)width :(float)height
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGRect rect = CGRectMake(ipoint.x,ipoint.y,width,height);
    
    switch ([typeSelection indexOfObject:typeSelected])
    {
        case 0:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokeEllipseInRect(context, rect);
            break;
        case 1:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextFillEllipseInRect(context, rect);
            break;
        case 2:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextStrokeEllipseInRect(context, rect);
            CGContextFillEllipseInRect(context, rect);
            break;
        case 3:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokeEllipseInRect(context, rect);
            break;
        case 4:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextFillEllipseInRect(context, rect);
            break;
        case 5:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokeEllipseInRect(context, rect);
            CGContextFillEllipseInRect(context, rect);
            break;
        case 6:
        {   CGFloat patterns[] = {10.0,10.0};
            CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokeEllipseInRect(context, rect);
            break;
        }
        default:
            break;
    }
    
//    CGContextAddEllipseInRect(context, rect);
//    CGContextStrokePath(context);
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (void)drawArc:(CGPoint)ipoint :(CGPoint)fpoint :(float)height
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Drawing with a white stroke color
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
	// And draw with a blue fill color
    CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, lineWidth);
    
    // Stroke an arc using AddArcToPoint
    CGContextSetFlatness (context,0.5);
    CGContextMoveToPoint(context, ipoint.x, ipoint.y);
	if (Fpoint.y<ipoint.y)
        CGContextAddArcToPoint(context, fpoint.x, ipoint.y, fpoint.x, fpoint.y, height);
    else
        CGContextAddArcToPoint(context, ipoint.x, fpoint.y, fpoint.x, fpoint.y, height);
	CGContextStrokePath(context);
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (void)drawLine:(CGPoint)ipoint :(CGPoint)fpoint
{
    
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), cap);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fpoint.x, fpoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), ipoint.x, ipoint.y);
    if ([selected isEqualToString:@"line"])
    {
        switch ([typeSelection indexOfObject:typeSelected])
        {
            case 0:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            case 1:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextFillPath(context);
                break;
            case 2:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 3:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                break;
            case 4:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextFillPath(context);
                break;
            case 5:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 6:
            {   CGFloat patterns[] = {10.0,10.0};
                CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            }
            default:
                break;
        }
    }
    else if([selected isEqualToString:@"curve"])
    {
        switch ([typeSelection indexOfObject:typeSelected])
        {
            case 0:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            case 1:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextFillPath(context);
                break;
            case 2:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 3:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                break;
            case 4:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextFillPath(context);
                break;
            case 5:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 6:
            {   CGFloat patterns[] = {10.0,10.0};
                CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            }
            default:
                break;
        }
    }
    else if([selected isEqualToString:@"polygon"])
    {
        switch ([typeSelection indexOfObject:typeSelected])
        {
            case 0:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            case 1:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextFillPath(context);
                break;
            case 2:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 3:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                break;
            case 4:
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextFillPath(context);
                break;
            case 5:
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
                CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
                CGContextStrokePath(context);
                CGContextFillPath(context);
                break;
            case 6:
            {   CGFloat patterns[] = {10.0,10.0};
                CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
                CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
                CGContextStrokePath(context);
                break;
            }
            default:
                break;
        }
    }
    
    
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (void)drawPoint:(CGPoint)ipoint :(CGPoint)fpoint :(float)linewidth
{
    
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), linewidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), cap);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fpoint.x, fpoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), ipoint.x, ipoint.y);
    
    if ([selected isEqualToString:@"erasor"])
        CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    else
        CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
    CGContextStrokePath(context);
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

- (void)drawPolygon:(CGPoint)ipoint :(CGPoint)fpoint
{
    
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), cap);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fpoint.x, fpoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), ipoint.x, ipoint.y);
    
    switch ([typeSelection indexOfObject:typeSelected])
    {
        case 0:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
//            CGContextStrokePath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathStroke);
            break;
        case 1:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
//            CGContextFillPath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathFill);
            break;
        case 2:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
//            CGContextStrokePath(context);
//            CGContextFillPath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathFillStroke);
            break;
        case 3:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
//            CGContextStrokePath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathStroke);
            break;
        case 4:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
//            CGContextFillPath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathFill);
            break;
        case 5:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
//            CGContextStrokePath(context);
//            CGContextFillPath(context);
            CGContextClosePath(context);
            CGContextDrawPath(context,kCGPathFillStroke);
            break;
        case 6:
        {   CGFloat patterns[] = {10.0,10.0};
            CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokePath(context);
            break;
        }
        default:
            break;
    }
    
    
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

-(void)drawCurve:(CGPoint)ipoint :(CGPoint)fpoint :(CGPoint)cpoint
{
    UIGraphicsBeginImageContext(self.IVtempImage.frame.size);
    [self.IVtempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width-98)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), cap);
    
//    CGContextBeginPath(context);
	CGContextMoveToPoint(context, ipoint.x, ipoint.y);
	CGContextAddQuadCurveToPoint(context, cpoint.x, cpoint.y, fpoint.x, fpoint.y);
//    CGContextSetRGBStrokeColor(context,1,0,0,1.0);
//	CGContextStrokePath(context);
    
    switch ([typeSelection indexOfObject:typeSelected])
    {
        case 0:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokePath(context);
            break;
        case 1:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextFillPath(context);
            break;
        case 2:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextStrokePath(context);
            CGContextFillPath(context);
            break;
        case 3:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokePath(context);
            break;
        case 4:
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextFillPath(context);
            break;
        case 5:
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextSetRGBFillColor(context,Fred,Fgreen,Fblue,Falpha);
            CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(10,10), 0.333);
            CGContextStrokePath(context);
            CGContextFillPath(context);
            break;
        case 6:
        {   CGFloat patterns[] = {10.0,10.0};
            CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, patterns, 1);
            CGContextSetRGBStrokeColor(context,Sred,Sgreen,Sblue,1.0);
            CGContextStrokePath(context);
            break;
        }
        default:
            break;
    }
    
    self.IVtempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.IVtempImage setAlpha:Salpha];
    UIGraphicsEndImageContext();
}

// Uncolored patterns take their color from the given context
void UncoloredPatternCallback(void *info, CGContextRef context)
{
	CGContextFillRect(context, CGRectMake(0.0, 0.0, 8.0, 8.0));
	CGContextFillRect(context, CGRectMake(8.0, 8.0, 8.0, 8.0));
}

- (CGPatternRef)uncoloredPattern
{
    CGPatternRef _uncoloredPattern = NULL;
    if (_uncoloredPattern == NULL)
    {
        CGPatternCallbacks uncoloredPatternCallbacks = {0, UncoloredPatternCallback, NULL};
        // As above, we create a CGPatternRef that specifies the qualities of our pattern
        _uncoloredPattern = CGPatternCreate(
                                            NULL, // 'info' pointer
                                            CGRectMake(0.0, 0.0, 16.0, 16.0), // coordinate space
                                            CGAffineTransformIdentity, // transform
                                            16.0, 16.0, // spacing
                                            kCGPatternTilingNoDistortion,
                                            false, // this is an uncolored pattern, thus to draw it we need to specify both color and alpha
                                            &uncoloredPatternCallbacks); // callbacks for this pattern
    }
    
    return _uncoloredPattern;
}

- (IBAction)takePhoto:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    
    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
    selected=[array objectAtIndex:0];
    typeSelected=[array objectAtIndex:1];
    
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    prevSelectedImagebtn=PressedButton;
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:PressedButton :imageName];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
        UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
        
        NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
        selected=[array objectAtIndex:0];
        typeSelected=[array objectAtIndex:1];
        
        [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
        prevSelectedImagebtn=PressedButton;
        prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
        NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
        [self updateSelectedBtnPic:PressedButton :imageName];
        
    }
    else
    {
        imagepicker = [[NonRotatingUIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing=YES;
        
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        myPopoverController = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
        myPopoverController.delegate=self;
        [myPopoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 400.0, 400.0)
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
    }
}

- (IBAction)selectPhoto:(UIButton *)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    
    NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
    selected=[array objectAtIndex:0];
    typeSelected=[array objectAtIndex:1];
    
    [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
    prevSelectedImagebtn=PressedButton;
    prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
    NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
    [self updateSelectedBtnPic:PressedButton :imageName];
    
    imagepicker = [[NonRotatingUIImagePickerController alloc] init];
    imagepicker.delegate = self;
    imagepicker.allowsEditing=YES;
    
    imagepicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    myPopoverController = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
    myPopoverController.delegate =self;
    [myPopoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 400.0, 400.0)
                                         inView:self.view
                       permittedArrowDirections:UIPopoverArrowDirectionAny
                                       animated:YES];
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
        UIButton * PressedButton = (UIButton*)[self.viewFooter viewWithTag:9];
        
        NSArray *array=[PressedButton.titleLabel.text componentsSeparatedByString:@" "];
        selected=[array objectAtIndex:0];
        typeSelected=[array objectAtIndex:1];
        
        [self updateSelectedBtnPic:prevSelectedImagebtn :prevSelectedImagename];
        prevSelectedImagebtn=PressedButton;
        prevSelectedImagename=[NSString stringWithFormat:@"main_%@%@",selected,typeSelected];
        NSString *imageName=[NSString stringWithFormat:@"hover_%@%@",selected,typeSelected];
        [self updateSelectedBtnPic:PressedButton :imageName];
}

// Image Picker Controller delegate methods
- (void)imagePickerController:(NonRotatingUIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [imagepicker dismissViewControllerAnimated:YES completion:nil];
//    [imagepicker dismissViewControllerAnimated:YES ];
    uploadPicture = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    CGRect rect = CGRectMake(0,0,1024,700);
//    UIGraphicsBeginImageContext( rect.size );
//    [image drawInRect:rect];
//    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    NSData *imageData = UIImagePNGRepresentation(picture1);
//    
//    image=[UIImage imageWithData:imageData];
    [self start:@"upload"];
//    [self undoPush:self.IVmainImage.image];
//    self.IVmainImage.image= image;
    
//    thirdImage=secondImage;
//    secondImage=firstImage;
//    firstImage=IVmainImage.image;
//    if(undo==0)
//    {
//        undo++;
//        btnUndo.enabled=YES;
//    }
//    else if (undo<3)
//    {
//        undo++;
//        btnUndo.enabled=YES;
//    }
    
    if (myPopoverController != nil) {
        [myPopoverController dismissPopoverAnimated:YES];
        myPopoverController=nil;
    }
}

-(void)imageDraw
{
    imgvw.image=nil;
    UIGraphicsBeginImageContext(imgvw.frame.size);
    [uploadPicture drawInRect:CGRectMake(0, 0, imgvw.frame.size.width, imgvw.frame.size.height)];
    imgvw.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)drawCapJoinWidthLines
{
    self.cap.image =nil;
    UIGraphicsBeginImageContext(CGSizeMake(320, 334));
    [self.cap.image drawInRect:CGRectMake(0, 0, self.cap.frame.size.width, self.cap.frame.size.height)];
    CGContextRef context = UIGraphicsGetCurrentContext();
	// Drawing lines with a white stroke color
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
	
	// Preserve the current drawing state
	CGContextSaveGState(UIGraphicsGetCurrentContext());
	
	// Setup the horizontal line to demostrate caps
	CGContextMoveToPoint(context, 40.0, 30.0);
	CGContextAddLineToPoint(context, 280.0, 30.0);
    
	// Set the line width & cap for the cap demo
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetLineCap(context, cap);
	CGContextStrokePath(context);
	
	// Restore the previous drawing state, and save it again.
	CGContextRestoreGState(context);
	CGContextSaveGState(context);
	
	// Setup the angled line to demonstrate joins
	CGContextMoveToPoint(context, 40.0, 190.0);
	CGContextAddLineToPoint(context, 160.0, 70.0);
	CGContextAddLineToPoint(context, 280.0, 190.0);
    
	// Set the line width & join for the join demo
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetLineJoin(context, join);
	CGContextStrokePath(context);
    
	// Restore the previous drawing state.
	CGContextRestoreGState(context);
    
	// If the stroke width is large enough, display the path that generated these lines
	if (lineWidth >= 4.0) // arbitrarily only show when the line is at least twice as wide as our target stroke
	{
		CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(context, 40.0, 30.0);
		CGContextAddLineToPoint(context, 280.0, 30.0);
		CGContextMoveToPoint(context, 40.0, 190.0);
		CGContextAddLineToPoint(context, 160.0, 70.0);
		CGContextAddLineToPoint(context, 280.0, 190.0);
		CGContextSetLineWidth(context, 2.0);
		CGContextStrokePath(context);
	}
    
    self.cap.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIImage *image=[UIImage imageNamed:@"red.png"];
//    [self.cap setImage:image];
//    [self.capJoinWidthImageView setAlpha:alpha];
    UIGraphicsEndImageContext();
}

-(IBAction)takeLineCapFrom:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex])
    {
        case 0:
            cap=kCGLineCapRound;
            [self drawCapJoinWidthLines];
            break;
        case 1:
            cap=kCGLineCapButt;
            [self drawCapJoinWidthLines];
            break;
        case 2:
            cap=kCGLineCapSquare;
            [self drawCapJoinWidthLines];
            break;
        default:
            break;
    }
}

-(IBAction)takeLineJoinFrom:(UISegmentedControl *)sender
{
	switch ([sender selectedSegmentIndex])
    {
        case 0:
            join=kCGLineJoinMiter;
            [self drawCapJoinWidthLines];
            break;
        case 1:
            join=kCGLineJoinRound;
            [self drawCapJoinWidthLines];
            break;
        case 2:
            join=kCGLineJoinBevel;
            [self drawCapJoinWidthLines];
            break;
        default:
            break;
    }
}

- (IBAction)segTextDrawingMode:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex])
    {
        case 0:
            textDrawMode=kCGTextFill;
            [self textDraw];
            break;
        case 1:
            textDrawMode=kCGTextStroke;
            [self textDraw];
            break;
        case 2:
            textDrawMode=kCGTextFillStroke;
            [self textDraw];
            break;
        default:
            break;
    }
}

- (IBAction)sldFontSizeCharSpace:(UISlider *)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    switch (PressedButton.tag)
    {
        case 102:
        {   fontSize=sender.value;
            NSString *str=[NSString stringWithFormat:@"%f",sender.value];
            self.lblFontSize.text=str;
            [self textDraw];
            break;
        }
        case 103:
        {   charSpace=sender.value;
            NSString *str=[NSString stringWithFormat:@"%f",sender.value];
            self.lblCharSpacing.text=str;
            [self textDraw];
            break;
        }
        default:
            break;
    }
}

-(IBAction)takeLineWidthFrom:(UISlider *)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    switch (PressedButton.tag)
    {
        case 101:
            
            lineWidth = sender.value;
            [self drawCapJoinWidthLines];
            break;            
        default:
            break;
    }
}

- (IBAction)btnSaveImage:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Dialog"
                                                    message:@"Want To Save this Image to Camera Roll Folder?"
                                                   delegate:self
                                          cancelButtonTitle:@"Yes"
                                          otherButtonTitles:@"No",nil];
    [alert show];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter The Image File Name" message:@"abc" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    imageNameToSave = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
//    [imageNameToSave setBackgroundColor:[UIColor whiteColor]];
//
//    [alert addSubview:imageNameToSave];
//    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Save Dialog"])
    {
        switch (buttonIndex)
        {
            case 0:
                UIImageWriteToSavedPhotosAlbum(IVmainImage.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
                break;
                
            default:
                break;
        }
    }
    else if ([alertView.title isEqualToString:@"Enter The Image File Name"])
    {
        
        NSString *filePath=[self documentsPathForFileName:imageNameToSave.text];
        filePath=[filePath stringByAppendingFormat:@".png"];
        NSData *pngData = UIImagePNGRepresentation(self.IVmainImage.image);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File Already Exist!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            if([fileManager createFileAtPath:filePath contents:pngData attributes:nil])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Save Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid File Name" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}
    
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
        NSString *message;
        NSString *title;
        if (!error) {
            title = NSLocalizedString(@"Image Saved", @"");
            message = NSLocalizedString(@"You can now view the image in your photo album", @"");
        }
        else {
            title = NSLocalizedString(@"Save Failed", @"");
            message = [error description];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                              otherButtonTitles:nil];
        [alert show];  
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return Fonts.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [Fonts objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    fontName=[Fonts objectAtIndex:row];
    [self textDraw];
}

-(void)viewImageLoading
{
    UIImage *image=[UIImage imageNamed:@"drawer.png"];
    UIColor *bg=[UIColor colorWithPatternImage:image];
    self.viewColourSelection.backgroundColor=bg;
    self.viewTextSelection.backgroundColor=bg;
    self.viewSettings.backgroundColor=bg;
    self.viewStationarySelection.backgroundColor=bg;
    image=[UIImage imageNamed:@"footer.png"];
    bg=[UIColor colorWithPatternImage:image];
    self.viewFooter.backgroundColor=bg;
}

-(void)updateSelectedBtnPic:(UIButton *)button: (NSString *)imageName
{
//    UIButton *button=(UIButton *)sender;
    UIImage *image=[UIImage imageNamed:imageName];
    [button setBackgroundImage:image forState:UIControlStateNormal];
}


#pragma Mark - iads Delegate

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{

    if (adBannerView.loaded)
    {
        [adBannerView presentFromViewController:self];
    }
}

- (BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    adBannerView = nil;
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"interstitialAd <%@> recieved error <%@>", interstitialAd, error);
    adBannerView = nil;
}



@end
