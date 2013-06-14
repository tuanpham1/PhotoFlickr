//
//  DetailPhotoModel.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/14/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailPhotoModel : NSObject
{

    UIScrollView *_scrollViewItem;
    UIScrollView *_scrollViewComment;
    UIImageView *_imageViewAvatarUser;
    UIImageView *_imageViewDetail;
    UILabel *_labelNameUser;
    UILabel *_labelNameUserTrue;
    UILabel *_labelLocationUser;
    UILabel *_labelDateUpload;
    UILabel *_labelViewCount;
    UIScrollView *_scrollViewDescription;
    UILabel *_labelTitleDescription;
    UILabel *_labelTitleComment;
    NSMutableArray *_mutableArrayComment;
}
@property(nonatomic, strong) UIScrollView *_scrollViewItem;
@property(nonatomic, strong) UIScrollView *_scrollViewComment;
@property(nonatomic, strong) UIImageView *_imageViewAvatarUser;
@property(nonatomic, strong) UIImageView *_imageViewDetail;
@property(nonatomic, strong) UILabel *_labelNameUser;
@property(nonatomic, strong) UILabel *_labelNameUserTrue;
@property(nonatomic, strong) UILabel *_labelLocationUser;
@property(nonatomic, strong) UILabel *_labelDateUpload;
@property(nonatomic, strong) UILabel *_labelViewCount;
@property(nonatomic, strong) UIScrollView *_scrollViewDescription;
@property(nonatomic, strong) UILabel *_labelTitleDescription;
@property(nonatomic, strong) UILabel *_labelTitleComment;
@property(nonatomic, strong) NSMutableArray *_mutableArrayComment;

-(void)creatScreenWithUIkit;

@end
