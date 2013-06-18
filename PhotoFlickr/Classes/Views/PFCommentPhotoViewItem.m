//
//  PFCommentPhotoViewItem.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFCommentPhotoViewItem.h"

@implementation PFCommentPhotoViewItem

@synthesize _labelNameUserComment;
@synthesize _labelBodyComment;
@synthesize _imageViewAvatarComment;

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewAvatarComment = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
       [self addSubview:_imageViewAvatarComment];
        
        _labelNameUserComment = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 250, 13)];
        _labelNameUserComment.font = [UIFont systemFontOfSize:11];
        _labelNameUserComment.textColor = [UIColor blueColor];
        _labelNameUserComment.backgroundColor = [UIColor clearColor];
        [self addSubview:self._labelNameUserComment];
        
        
        _labelBodyComment = [[UILabel alloc] init];
        _labelBodyComment.font = [UIFont systemFontOfSize:10];
        [_labelBodyComment setTextAlignment:NSTextAlignmentLeft];
        _labelBodyComment.lineBreakMode = NSLineBreakByWordWrapping;
        _labelBodyComment.numberOfLines = 0;
        _labelBodyComment.textColor = [UIColor darkGrayColor];
        _labelBodyComment.backgroundColor = [UIColor clearColor];
        [self addSubview:_labelBodyComment];
    }
    return self;
}
-(void)dealloc {
    
    [_imageViewAvatarComment release];
    [_labelNameUserComment release];
    [_labelBodyComment release];
    [super dealloc];
}
@end
