//
//  bookCategoryCVC.m
//  Colors Play
//
//  Created by user on 09/10/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "bookCategoryCVC.h"
#import "ViewController.h"

@interface bookCategoryCVC ()
{
    NSArray *animals;
}

@end

@implementation bookCategoryCVC

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
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu screenplain.png"]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    animals = [NSArray arrayWithObjects:@"animal1.jpg",@"animal2.jpg",@"animal3.jpg",@"animal4.jpg",@"animal5.jpg",@"animal6.jpg",@"animal7.jpg",@"animal8.jpg",@"animal9.jpg",@"animal10.jpg", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return animals.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[animals objectAtIndex:indexPath.row]];
    cell.layer.cornerRadius = 7;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"paintingView"];
    VC.IVmainImageName = [animals objectAtIndex:indexPath.row];
    [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor colorWithRed:204 green:153 blue:51 alpha:1];
    
    [self presentViewController:VC animated:YES completion:nil];
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                         UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[headerView viewWithTag:200];
    [label setText:@"Animals"];
    return headerView;
}

@end
