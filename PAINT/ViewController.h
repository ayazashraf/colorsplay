//
//  ViewController.h
//  PAINT
//
//  Created by user on 05/08/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloodFill.h"
#import <QuartzCore/QuartzCore.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import "toolKit.h"
#import <iAd/iAd.h>


@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,ADInterstitialAdDelegate>
{
    CGPoint Ipoint,Fpoint,LastPolyPoint;
    CGFloat Sred,Fred;
    CGFloat Sgreen,Fgreen;
    CGFloat Sblue,Fblue;
    CGFloat Salpha,Falpha;
    BOOL Scolor;
//    CGFloat brush;
    BOOL mouseSwiped;
    BOOL poly;
//    BOOL pencil,line,rectangle,circle,triangle,arc,erasor,text,picker;
    NSArray *selection;
    NSString *selected;
    NSArray *typeSelection;
    NSString *typeSelected;
//    NSArray *circSelection;
//    NSString *circSelected;
//    NSArray *triSelection;
//    NSString *triSelected;
//    NSArray *arcSelection;
//    NSString *arctSelected;
//    NSArray *lineSelection;
//    NSString *lineSelected;
//    NSArray *polySelection;
//    NSString *polySelected;
//    NSArray *curveSelection;
//    NSString *curveSelected;
    UIImagePickerController *imagepicker;
    UIPopoverController *myPopoverController;
    toolKit *toolkit;
    int viewSelection;
    int undo,redo;
    
    UIView *testVw;
    
    UIImageView *resizeVw;
    UIImageView *imgvw;
    UIImageView *rotateVw;
    UIImageView *closeVw;
    UIImageView *moveVw;
    
    float deltaAngle;
    CGPoint prevPoint;
    CGAffineTransform startTransform;
    UIImage *temp;
    float xDiff;
    float yDiff;
    CGLineCap cap;
    CGLineJoin join;
    float lineWidth;
    BOOL lineDash;
    CGPoint curve1,curve2;
    BOOL curveControl;
    NSArray *Fonts;
    NSString *fontName;
    float fontSize;
    float charSpace;
    CGTextDrawingMode textDrawMode;
    NSMutableArray *polyPoints;
    NSString *prevSelectedImagename;
    UIButton *prevSelectedImagebtn;
    NSMutableArray *undoStack;
    NSMutableArray *redoStack;
    UIImage *uploadPicture;
    UITextField *imageNameToSave;
    BOOL startBg;
   

}
//@property (strong, nonatomic) UIImage *firstImage,*secondImage,*thirdImage;
//@property (strong, nonatomic) UIImage *next1Image,*next2Image,*next3Image;
@property (strong, nonatomic) NSString *IVmainImageName;
@property (strong, nonatomic) IBOutlet UIImageView *IVmainImage;
@property (strong, nonatomic) IBOutlet UIImageView *IVtempImage;
@property (strong, nonatomic) IBOutlet UIView *viewColourSelection;
@property (strong, nonatomic) IBOutlet UIView *viewFooter;
@property (strong, nonatomic) IBOutlet UIControl *viewSettings;

@property (strong, nonatomic) IBOutlet UIView *viewStationarySelection;
@property (strong, nonatomic) IBOutlet UIButton *btnUndo;
@property (strong, nonatomic) IBOutlet UIButton *btnRedo;
//@property (strong, nonatomic) IBOutlet UIView *viewTabbar;
@property (strong, nonatomic) IBOutlet UITextField *txtBox;
@property (strong, nonatomic) IBOutlet UIControl *viewTextSelection;
@property (strong, nonatomic) IBOutlet UIView *viewsettings;


@property (strong, nonatomic) IBOutlet UIImageView *capJoinWidthImageView;

@property (nonatomic, strong) IBOutlet UISegmentedControl *capSegmentedControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *joinSegmentedControl;
@property (nonatomic, strong) IBOutlet UISlider *lineWidthSlider;
@property (strong, nonatomic) IBOutlet UIImageView *cap;
@property (strong, nonatomic) IBOutlet UIPickerView *FontPicker;
@property (strong, nonatomic) IBOutlet UIButton *btnScolor;
@property (strong, nonatomic) IBOutlet UIButton *btnFcolor;
@property (strong, nonatomic) IBOutlet UILabel *lblFontSize;
@property (strong, nonatomic) IBOutlet UILabel *lblCharSpacing;
@property (strong, nonatomic) IBOutlet UILabel *rvalue;
@property (strong, nonatomic) IBOutlet UILabel *gvalue;
@property (strong, nonatomic) IBOutlet UILabel *bvalue;
@property (strong, nonatomic) IBOutlet UILabel *avalue;
@property (strong, nonatomic) IBOutlet UISlider *rslider;
@property (strong, nonatomic) IBOutlet UISlider *gslider;
@property (strong, nonatomic) IBOutlet UISlider *bslider;
@property (strong, nonatomic) IBOutlet UISlider *aslider;


- (IBAction)colorSelected:(id)sender;
-(IBAction)shapesSelected:(id)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)viewSelection:(id)sender;
- (IBAction)btnRedo:(id)sender;
- (IBAction)btnUndo:(id)sender;
- (IBAction)btnReset:(id)sender;
- (IBAction)btnPencil:(id)sender;
- (IBAction)btnText:(id)sender;
- (IBAction)txtChanged:(id)sender;
- (IBAction)txtBegin:(id)sender;
- (IBAction)btnColorPicker:(id)sender;
- (IBAction)btnBrush:(id)sender;
- (IBAction)btnTextDone:(UIButton *)sender;

-(IBAction)takeLineCapFrom:(UISegmentedControl *)sender;
-(IBAction)takeLineJoinFrom:(UISegmentedControl *)sender;
- (IBAction)segTextDrawingMode:(UISegmentedControl *)sender;
- (IBAction)sldFontSizeCharSpace:(UISlider *)sender;


-(IBAction)takeLineWidthFrom:(UISlider *)sender;
- (IBAction)btnSaveImage:(id)sender;
- (IBAction)shapeSelection:(id)sender;
- (IBAction)ToolKitByLongPress:(UILongPressGestureRecognizer *)sender;
- (IBAction)repeat:(UIButton *)sender;
- (void) handleLongPressFrom: (UISwipeGestureRecognizer *)recognizer;
- (IBAction)btnForHelp:(UIButton *)sender;

- (IBAction)colorSlider:(UISlider *)sender;

- (void)drawRect:(CGPoint)Ipoint :(float)width :(float)height;

- (IBAction)btnforHome:(UIButton *)sender;

//iads code
@property (nonatomic,strong) ADInterstitialAd *adBannerView;

@end
