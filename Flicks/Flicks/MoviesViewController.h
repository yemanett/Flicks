//
//  ViewController.h
//  Flicks
//
//  Created by Yemane Tekleab on 1/24/17.
//  Copyright © 2017 Yemane Tekleab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property  (weak, nonatomic) NSString *viewType;
@property (weak, nonatomic) IBOutlet UISearchBar *filterList;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

