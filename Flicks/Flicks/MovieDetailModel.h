//
//  MovieDetailModel.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/25/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailModel : NSObject

- (instancetype) initWithDictionary:(NSDictionary *) otherDictionary;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *voteAverage;
@property (nonatomic, assign) NSString *runtime;
@property (nonatomic, strong) NSURL *posterURL;

@end
