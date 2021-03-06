//
//  PFDetailPhotoViewController.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFDetailPhotoViewItem.h"
#import "PFCommentPhotoViewItem.h"
#import "PFSearchModel.h"

@interface PFDetailPhotoViewController : UIViewController
{
    IBOutlet UIScrollView *scrollViewAllDetail;
    
    UILabel *labelTitleImage;
    NSMutableArray *mutableArrayDetailPhoto;
    
    int indexScrollPage;
    int indexPageLoader;
    float widthScreen;
    float heightScreen;
    BOOL stopRuning;
}

- (id)initWithNibName:(NSString *)nibNameOrNil aDictionaryItem:(NSDictionary *)dictionaryItem indexPath:(int)indexPath;
-(void)loadDetailWithPhoto:(PFSearchModel *)aModelSearch OriginX:(float)indexOriginX;
-(void)loadDataWithCommentingPhoto:(UIScrollView *)aScrollView  arrayComment:(NSMutableArray *) aArrayComment;
@end
