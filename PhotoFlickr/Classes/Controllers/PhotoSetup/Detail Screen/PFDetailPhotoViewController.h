//
//  PFDetailPhotoViewController.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFDetailPhotoViewController : UIViewController
{
    IBOutlet UIScrollView *scrollViewAllDetail;
    UILabel *labelTitleImage;
    NSMutableArray *mutableArrayComment;
    NSMutableArray *mutableArrayDetailPhoto;
    int indexScrollPage;
    UIActivityIndicatorView *activityIndicatorviewLoadingSearch;
}
- (id)initWithNibName:(NSString *)nibNameOrNil aDictionaryItem:(NSDictionary *)dictionaryItem indexPath:(int)indexPath;
-(NSDictionary *)GetInfoCommentsPhoto:(NSString *)aPhotoId;
-(void)loadDetailPhoto:(NSDictionary *)aDictionaryPhoto indexOriginX:(float)originX;
-(void)loadDataComment:(UIScrollView *)aScrollView aActivityComment:(UIActivityIndicatorView *) activityComment;
@end
