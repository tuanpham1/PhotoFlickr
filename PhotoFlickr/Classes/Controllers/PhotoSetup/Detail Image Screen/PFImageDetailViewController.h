//
//  PFImageDetailViewController.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/6/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFImageDetailViewController : UIViewController<UIScrollViewDelegate>
{
    NSString *stringSaveNameImage;
    CGFloat lastRotation;
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil aNameImage:(NSString *)nameImage;
@end
