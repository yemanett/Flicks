//
//  MovieDetailViewController.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/25/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailModel.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (strong, nonatomic) MovieDetailModel  *movieDetail;
@end

@implementation MovieDetailViewController
@synthesize movieId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    CGFloat contentWidth  = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height * 1.1;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    [self fetchMoviesDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateView {
    
    MovieDetailModel *model = self.movieDetail;
    [self.posterImage setImageWithURL: model.posterURL];
    
    self.movieTitle.text = model.title;
    self.releaseDate.text = model.releaseDate;
    self.runTime.text = model.runtime;
    self.voteAverage.text = model.voteAverage;
    self.ratingImage.image = [UIImage imageNamed:@"iconmonstr-crown-2.png"];
    
    self.movieDescription.text = model.movieDescription;
}

- (void) fetchMoviesDetail {
    
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *urlString = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@?api_key=%@", self.movieId,apiKey];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            MovieDetailModel *movieDetailModel = [[MovieDetailModel alloc]initWithDictionary:responseDictionary];
            
            self.movieDetail = movieDetailModel;
            [self updateView];
        } else {
            NSLog(@"An error occurred: %@", error.description);
        }
    }];
    [task resume];
}

@end
