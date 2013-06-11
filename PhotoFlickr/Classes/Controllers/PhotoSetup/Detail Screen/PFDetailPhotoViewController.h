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
    IBOutlet UIImageView *imageViewAvatarUser;
    IBOutlet UIImageView *imageViewDetail;
    IBOutlet UILabel *labelNameUser;
    IBOutlet UILabel *labelNameUserTrue;
    IBOutlet UILabel *labelLocationUser;
    IBOutlet UILabel *labelDateUpload;
    IBOutlet UILabel *labelViewCount;
    IBOutlet UITextView *textViewDescription;
    IBOutlet UILabel *labelTitleComment;
    UILabel *labelTitleImage;
    IBOutlet UIScrollView *scrollViewComment;
    IBOutlet UIScrollView *scrollViewScreenComent;
    NSDictionary *dictionaryDataItem;
    NSMutableArray *mutableArrayComment;
    UIActivityIndicatorView *activityIndicatorLoadingComment;

}
- (id)initWithNibName:(NSString *)nibNameOrNil aDictionaryItem:(NSDictionary *)dictionaryItem;
-(void)loadDataComment;
-(NSDictionary *)GetInfoCommentsPhoto:(NSString *)aUserId;
@end
