//
//  CollectionTableViewCell.m
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/28.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "VideoEvaluationImageCell.h"
#import "IMageOrVideoModel.h"
#import "UIButton+Block.h"
#define CollectionTableViewCellImageWidth ((SCREEN_WIDTH - 1)/4.0 -10)
@interface CollectionTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * imagessCollection;     //

@end
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self createViews];
}

-(void)createViews{
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    //    flowLayout.estimatedItemSize = CGSizeMake(10, 10);
    flowLayout2.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

    self.imagessCollection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout2];
    self.imagessCollection.backgroundColor = [UIColor clearColor];
    self.imagessCollection.delegate = self;
    self.imagessCollection.dataSource = self;
    self.imagessCollection.scrollEnabled = NO;
    [self.imagessCollection registerClass:[VideoEvaluationImageCell class] forCellWithReuseIdentifier:@"VideoEvaluationImageCell"];
    [self addSubview:self.imagessCollection];
    CGFloat height = (self.imagesArr.count+1 +3)/4*CollectionTableViewCellImageWidth;
    [self.imagessCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(height+10);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

-(void)resetCollectHeight{
    CGFloat height = (_imagesArr.count+1 +3)/4*CollectionTableViewCellImageWidth;
    [self.imagessCollection mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(height+10);
        make.bottom.mas_equalTo(0);
    }];
}
-(void)setImagesArr:(NSArray *)imagesArr{
    _imagesArr = imagesArr;
    
    [self.imagessCollection reloadData];
    [self resetCollectHeight];
}
#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesArr.count + 1;
    
}
#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRWeakSelf;
        VideoEvaluationImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoEvaluationImageCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.layer.borderColor = [HEXCOLOR(0xD9D9D9) CGColor];
    cell.layer.borderWidth = 1;
    if(self.imagesArr.count >indexPath.row){
        id im = self.imagesArr[indexPath.row];
        
        if([im isKindOfClass:[UIImage class]]){
            cell.imageView.image = im;
            cell.playImage.hidden = YES;
            if(self.didDelect){
                cell.deleteBtn.hidden = NO;
                [cell.deleteBtn setTitle:@"❌" forState:UIControlStateNormal];
                [cell.deleteBtn addAction:^(UIButton *btn) {
                    weakSelf.didDelect(indexPath.row);
                }];
            }
        }else if ([im isKindOfClass:[IMageOrVideoModel class]]) {
            IMageOrVideoModel *model = im;
            cell.imageView.image = model.image;
            cell.playImage.hidden = NO;
            if(self.didDelect){
                cell.deleteBtn.hidden = NO;
                [cell.deleteBtn setTitle:@"❌" forState:UIControlStateNormal];
                [cell.deleteBtn addAction:^(UIButton *btn) {
                    weakSelf.didDelect(indexPath.row);
                }];
            }
        }
    }
    else{
        cell.deleteBtn.hidden = YES;
        cell.imageView.image = [UIImage imageNamed:@"compose_photo_photograph"];
        cell.imageView.contentMode = UIViewContentModeCenter;
    }
        return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(CollectionTableViewCellImageWidth,CollectionTableViewCellImageWidth);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;
    
}
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---------------------");
    if(self.didSelect){
        self.didSelect(indexPath.row);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
