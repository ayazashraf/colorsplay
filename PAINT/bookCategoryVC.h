//
//  bookCategoryVC.h
//  Colors Play
//
//  Created by user on 07/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookCategoryVC : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *CV;
@end
