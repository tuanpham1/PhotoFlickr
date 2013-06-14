//
//  DetailPhotoModel.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/14/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "DetailPhotoModel.h"
#import "QuartzCore/QuartzCore.h"

@implementation DetailPhotoModel

@synthesize _scrollViewItem;
@synthesize _scrollViewComment;
@synthesize _imageViewAvatarUser;
@synthesize _imageViewDetail;
@synthesize _labelNameUser;
@synthesize _labelNameUserTrue;
@synthesize _labelLocationUser;
@synthesize _labelDateUpload;
@synthesize _labelViewCount;
@synthesize _scrollViewDescription;
@synthesize _labelTitleDescription;
@synthesize _labelTitleComment;
@synthesize _mutableArrayComment;

-(id) init {

    self = [super init];
    if (self) {
        
        [self creatScreenWithUIkit];
    }
    return self;
}
-(void)creatScreenWithUIkit {

    _mutableArrayComment = [[NSMutableArray alloc] init];
    _scrollViewItem = [[UIScrollView alloc] init];
    [_scrollViewItem setUserInteractionEnabled:YES];
    
     //Scroll View Coment
    _scrollViewComment = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 420, 307, 199)];
    _scrollViewComment.layer.borderWidth = 1.0;
    _scrollViewComment.layer.borderColor = [[UIColor grayColor] CGColor];
    [_scrollViewItem addSubview:_scrollViewComment];
    
    //Images Avatar User
    _imageViewAvatarUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 50, 50)];
    [_scrollViewItem addSubview:_imageViewAvatarUser];
    
    //Images Detail
    _imageViewDetail = [[UIImageView alloc] initWithFrame:CGRectMake(40, 87, 240, 240)];
    [_imageViewDetail setUserInteractionEnabled:YES];
    [_scrollViewItem addSubview:_imageViewDetail];
    
    //Label User Name
    _labelNameUser = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 149, 15)];
    _labelNameUser.font = [UIFont systemFontOfSize:12];
    _labelNameUser.backgroundColor = [UIColor clearColor];
    _labelNameUser.textColor = [UIColor blackColor];
    [_scrollViewItem addSubview:_labelNameUser];
    
    //Label user Name True
    _labelNameUserTrue = [[UILabel alloc] initWithFrame:CGRectMake(63, 25, 149, 15)];
    _labelNameUserTrue.font = [UIFont systemFontOfSize:10];
    _labelNameUserTrue.backgroundColor = [UIColor clearColor];
    _labelNameUserTrue.textColor = [UIColor darkGrayColor];
    [_scrollViewItem addSubview:_labelNameUserTrue];
    
    //Label Location User
    _labelLocationUser = [[UILabel alloc] initWithFrame:CGRectMake(63, 43, 149, 15)];
    _labelLocationUser.font = [UIFont systemFontOfSize:10];
    _labelLocationUser.backgroundColor = [UIColor clearColor];
    _labelLocationUser.textColor = [UIColor darkGrayColor];
    [_scrollViewItem addSubview:_labelLocationUser];
    
    //label Date Upload
    _labelDateUpload = [[UILabel alloc] initWithFrame:CGRectMake(218, 8, 98, 15)];
    _labelDateUpload.font = [UIFont systemFontOfSize:10];
    _labelDateUpload.backgroundColor = [UIColor clearColor];
    _labelDateUpload.textColor = [UIColor darkGrayColor];
    [_scrollViewItem addSubview:_labelDateUpload];
    
    //label View Count
    _labelViewCount = [[UILabel alloc] initWithFrame:CGRectMake(238, 25, 98, 15)];
    _labelViewCount.font = [UIFont systemFontOfSize:10];
    _labelViewCount.backgroundColor = [UIColor clearColor];
    _labelViewCount.textColor = [UIColor darkGrayColor];
    [_scrollViewItem addSubview:_labelViewCount];
    
    _scrollViewDescription = [[UIScrollView alloc] initWithFrame:CGRectMake(17, 333, 283, 60)];
    [_scrollViewItem addSubview:_scrollViewDescription];
    
    
    //Label title comment
    _labelTitleDescription = [[UILabel alloc] init];
    _labelTitleDescription.font = [UIFont systemFontOfSize:12];
    _labelTitleDescription.backgroundColor = [UIColor clearColor];
    _labelTitleDescription.textColor = [UIColor darkGrayColor];
    [_labelTitleDescription setTextAlignment:NSTextAlignmentLeft];
    _labelTitleDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [_scrollViewDescription addSubview:_labelTitleDescription];
    
    //Label title comment
    _labelTitleComment = [[UILabel alloc] initWithFrame:CGRectMake(14, 359, 292, 21)];
    _labelTitleComment.font = [UIFont systemFontOfSize:12];
    _labelTitleComment.backgroundColor = [UIColor clearColor];
    _labelTitleComment.textColor = [UIColor darkGrayColor];
    [_scrollViewItem addSubview:_labelTitleComment];
}
-(void)dealloc {
    
    
    [_scrollViewItem release];
    [_scrollViewComment release];
    [_imageViewAvatarUser release];
    [_imageViewDetail release];
    [_labelNameUser release];
    [_labelNameUserTrue release];
    [_labelLocationUser release];
    [_labelDateUpload release];
    [_labelViewCount release];
    [_scrollViewDescription release];
    [_labelTitleDescription release];
    [_labelTitleComment release];
    [_mutableArrayComment release];
    
    [super dealloc];
}

@end
