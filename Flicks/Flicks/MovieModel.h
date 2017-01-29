//
//  MovieModel.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype) initWithDictionary:(NSDictionary *) otherDictionary;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSURL *posterURL;
@property (nonatomic, strong) NSString *movieId;

@end
