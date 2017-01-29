//
//  MovieDetailModel.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/25/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        NSInteger runTime = [dictionary[@"runtime"] integerValue];
        self.runtime = [NSString stringWithFormat:@"%ld hr %ld mins  ", runTime/60, runTime%60];
        self.voteAverage = [NSString stringWithFormat:@" %@%%", dictionary[@"vote_average"]];
        self.movieDescription = dictionary[@"overview"];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-dd"];
        NSDate *releaseDate = [df dateFromString: dictionary[@"release_date"]];
        [df setDateFormat:@"MMMM d, YYYY"];
        self.releaseDate = [df stringFromDate:releaseDate];
        NSString *imageUrlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", dictionary[@"poster_path"]];
        self.posterURL = [NSURL URLWithString:imageUrlString];
    }
    return self;
}


@end
