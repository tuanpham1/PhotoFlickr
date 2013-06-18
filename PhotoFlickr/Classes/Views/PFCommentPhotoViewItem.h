//
//  PFCommentPhotoViewItem.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFCommentPhotoViewItem : UIView
{
    UIImageView *_imageViewAvatarComment;
    UILabel *_labelNameUserComment;
    UILabel *_labelBodyComment;
    
    
}

@property(nonatomic,strong) UIImageView *_imageViewAvatarComment;
@property(nonatomic,strong) UILabel *_labelNameUserComment;
@property(nonatomic,strong) UILabel *_labelBodyComment;

@end
