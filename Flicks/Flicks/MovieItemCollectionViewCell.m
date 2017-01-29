//
//  MovieItemCollectionViewCell.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/27/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "MovieItemCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h> 

@implementation MovieItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView]; // Doesn't get strong reference  until now or line below.
        self.imageView = imageView;
    }
    return self;
}

- (void) reloadData {
    [self.imageView setImageWithURL:self.model.posterURL];
    [self setNeedsLayout];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
