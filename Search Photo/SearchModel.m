//
//  SearchModel.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/14/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//
#import "SearchModel.h"

@implementation SearchModel

@synthesize _stringPhotoID;
@synthesize _stringTitlePhoto;
@synthesize _stringNameUser;
@synthesize _stringRealNameUser;
@synthesize _stringLocationUser;
@synthesize _stringUrlIConUser;
@synthesize _stringDatePhotoUpload;
@synthesize _stringDescriptionPhoto;
@synthesize _stringUrlPhotoSize150;
@synthesize _stringUrlPhotoSize240;
@synthesize _stringUrlPhotoSize1024;
@synthesize _stringViewCountPhoto;

-(id)init{

    self = [super init];
    if (self) {
    }
    return self;
}
-(void)dealloc
{

    [_stringPhotoID release];
    [_stringTitlePhoto release];
    [_stringNameUser release];
    [_stringRealNameUser release];
    [_stringLocationUser release];
    [_stringUrlIConUser release];
    [_stringDatePhotoUpload release];
    [_stringDescriptionPhoto release];
    [_stringUrlPhotoSize150 release];
    [_stringUrlPhotoSize240 release];
    [_stringUrlPhotoSize1024 release];
    [_stringViewCountPhoto release];
    [super dealloc];
}
@end
