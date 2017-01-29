//
//  MovieItemCollectionViewCell.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/27/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MovieModel *model;

- (void) reloadData;

@end
