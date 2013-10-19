//
//  DetailViewController.h
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
