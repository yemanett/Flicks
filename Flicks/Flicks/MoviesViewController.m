//
//  ViewController.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieItemTableViewCell.h"
#import "MovieItemCollectionViewCell.h"
#import "MovieDetailViewController.h"
#import "MovieModel.h"
#import "UIImageView+AFNetworking.h"
#import <MBProgressHUD.h>

@interface MoviesViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray<MovieModel *> *movies;
@property (strong, nonatomic) NSArray<MovieModel *> *searchedMovies;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshTableViewControl;
@property (strong, nonatomic) UIRefreshControl *refreshCollectionViewControl;

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MoviesViewController
@synthesize viewType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.movieTableView.dataSource = self;
    self.filterList.delegate = self;
    
    [self setupCollectionView];
    [self setupSelectedView];
    [self setupErrorView];
    [self fetchMovies];
    [self setupRefresh];
}

- (void) setupErrorView {
    // Make Hidden to start.
    self.errorView.hidden = YES;
    self.errorView.layer.zPosition = MAXFLOAT;
    
    // Align errorView frame to top right of the parent view.
    CGRect frame = self.errorView.frame;
    CGFloat xPosition = self.errorView.frame.origin.x;
    CGFloat yPosition = 64; // 64 is top nav size for all devices self.errorView.frame.size.height; // better would be to figure out height of the top nav bar.
    frame.origin = CGPointMake(xPosition, yPosition);
    self.errorView.frame = frame;
}

- (void) processError :(NSString *)errorMessage {
    NSLog(@"An error occurred: %@", errorMessage);
    self.movieTableView.hidden=YES;
    self.collectionView.hidden=YES;
    self.errorView.hidden = NO;
    self.errorLabel.text = errorMessage;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.errorView.hidden = YES;
        [self setupSelectedView];
    });
}

- (void) setupRefresh {
    UIRefreshControl *refreshTableViewControl = [[UIRefreshControl alloc] init];
    [refreshTableViewControl addTarget:self action:@selector(refreshTableViewControlAction) forControlEvents:UIControlEventValueChanged];
    self.refreshTableViewControl = refreshTableViewControl;
    [self.movieTableView addSubview:refreshTableViewControl];
    
    UIRefreshControl *refreshCollectionViewControl = [[UIRefreshControl alloc] init];
    [refreshCollectionViewControl addTarget:self action:@selector(refreshCollectionViewControlAction) forControlEvents:UIControlEventValueChanged];
    self.refreshCollectionViewControl = refreshCollectionViewControl;
    [self.collectionView addSubview:refreshCollectionViewControl];
}

- (void) refreshTableViewControlAction {
    [self refreshControlAction];
    [self.refreshTableViewControl endRefreshing];
}

- (void) refreshCollectionViewControlAction {
    [self refreshControlAction];
    [self.refreshCollectionViewControl endRefreshing];
}

- (void) refreshControlAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fetchMovies];
        [self reloadMovieData];
    });
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieModel *model = self.searchedMovies.count > 0 ? self.searchedMovies[indexPath.row] : self.movies[indexPath.row];
    MovieItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieItemCollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
    [cell reloadData];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   [self performSegueWithIdentifier:@"detailSegue" sender:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowCount;
    if (self.searchedMovies.count > 0) {
        rowCount = (int)self.searchedMovies.count;
    } else {
        rowCount = (int)self.movies.count;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieModel *model = self.searchedMovies.count > 0 ? self.searchedMovies[indexPath.row] : self.movies[indexPath.row];
    MovieItemTableViewCell *cell = [_movieTableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    cell.movieTitle.text = model.title;
    cell.movieDescription.text = model.movieDescription;
    [cell.moviePosterImage setImageWithURL: model.posterURL];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = nil;//[_movieTableView indexPathForSelectedRow];
        if (self.collectionView.hidden == NO) {
            NSArray *indexPaths = [_collectionView indexPathsForSelectedItems];
            indexPath = [indexPaths objectAtIndex:0];
        } else {
            indexPath = [_movieTableView indexPathForSelectedRow];
        }
        MovieModel *model = self.movies[(int)indexPath.row];
        MovieDetailViewController *vc = [segue destinationViewController];
        vc.movieId= model.movieId;
    }
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text {
    NSMutableArray *movieData = [NSMutableArray array];
    if(text.length != 0) {
        for (MovieModel* movie in self.movies) {
            NSRange titleRange = [movie.title rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [movie.description rangeOfString:text options:NSCaseInsensitiveSearch];
            if(titleRange.location != NSNotFound || descriptionRange.location != NSNotFound){
               [movieData addObject:movie];
            }
        }
    }
    self.searchedMovies = movieData;
    [self.movieTableView reloadData];
}

- (void) setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeigth = 150;
    CGFloat itemWidth  = screenWidth / 3;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeigth);  // Setting a static size of the layout.
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor blueColor];
    
    [collectionView registerClass:[MovieItemCollectionViewCell class] forCellWithReuseIdentifier:@"MovieItemCollectionViewCell"];
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}


- (void) fetchMovies {
    
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *urlString = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@?api_key=%@&r=12", self.viewType,apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSArray *results = responseDictionary[@"results"];
                                                    
            NSMutableArray *movieData = [NSMutableArray array];
            for (NSDictionary *result in results) {
                MovieModel *movieModel = [[MovieModel alloc]initWithDictionary:result];
                [movieData addObject:movieModel];
            }
            self.movies = movieData;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelectorOnMainThread:@selector(reloadMovieData) withObject:(nil) waitUntilDone:(NO)];
            sleep(1);
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"An error occurred: %@", error.description);
            SEL errorSelector = @selector(processError:);
            [self performSelectorOnMainThread:errorSelector withObject:(error.description) waitUntilDone:(YES)];
        }
    }];
    [task resume];
}

- (void) setupSelectedView {
    NSInteger segIndex = self.segmentedControl.selectedSegmentIndex;
    if (segIndex == 0) {
        self.movieTableView.hidden = NO;
        self.collectionView.hidden = YES;
    } else {
        self.movieTableView.hidden = YES;
        self.collectionView.hidden = NO;
    }
}

- (IBAction)segControlValueChanged:(id)sender {
    [self setupSelectedView];
}

- (void) reloadMovieData {
    [self.collectionView reloadData];
    [self.movieTableView reloadData];
}

@end
