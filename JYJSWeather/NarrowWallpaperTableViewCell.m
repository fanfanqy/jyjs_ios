//
//  NarrowWallpaperTableViewCell.m
//  JYJSWeather
//
//  Created by DEV-IOS-2 on 16/5/13.
//  Copyright © 2016年 WangQi. All rights reserved.
//

#import "NarrowWallpaperTableViewCell.h"
#import "NarrrowWallpaperCollectionViewCell.h"
#import "WallpaperVC.h"
#import "UIImageView+WebImage.h"
#import "Image_Model.h"


@implementation NarrowWallpaperTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.array = [NSMutableArray array];
        self.otherArray = [NSMutableArray array];
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
        [self.contentView addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"NarrrowWallpaperCollectionViewCell" bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"NARROWWALLPAPERCOLLECTIONCELL"];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.pagingEnabled = YES;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect fream = [UIScreen mainScreen].bounds;
    self.collectionView.frame = CGRectMake(0, 0, fream.size.width, self.contentView.frame.size.height);
    UICollectionViewFlowLayout *ff  = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    ff.itemSize = CGSizeMake(self.collectionView.frame.size.width/3, self.collectionView.frame.size.height);
    ff.minimumLineSpacing = 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NarrrowWallpaperCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NARROWWALLPAPERCOLLECTIONCELL" forIndexPath:indexPath];
    Image_Model * model = [self.array objectAtIndex:indexPath.row];
    NSString * str = [NSString stringWithFormat:@"%@?token=%@&url=%@", wallPaperImage,Token,model.url];
    NSURL * url = [NSURL URLWithString:str];
    NSLog(@"%@==%@", model.name, model.url);
      
    [cell.imageview setImageWithURL:url placeholderImage:nil];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallpaperVC *wallpaper = [[WallpaperVC alloc]init];
    wallpaper.pictureArray = self.otherArray;
    wallpaper.array = self.array;
    [self.viewControllerDelegate.navigationController pushViewController:wallpaper animated:YES];
}
@end
