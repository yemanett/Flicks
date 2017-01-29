//
//  MovieItemTableViewCell.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImage;

@end
