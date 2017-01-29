//
//  MovieDetailViewController.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/25/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSString  *movieId;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UITextView *movieDescription;
@property (weak, nonatomic) IBOutlet UILabel *runTime;

@property (weak, nonatomic) IBOutlet UILabel *voteAverage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;

@end
