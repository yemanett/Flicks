//
//  MovieModel.m
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"original_title"];
        self.movieId = dictionary[@"id"];
        self.movieDescription = dictionary[@"overview"];
        NSString *imageUrlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", dictionary[@"poster_path"]];
        self.posterURL = [NSURL URLWithString:imageUrlString];
    }
    return self;
}

@end
