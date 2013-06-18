//
//  PFSearchModel.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFSearchPhotoService.h"

@interface PFSearchModel : NSObject
{
    NSString *_stringPhotoID;
    NSString *_stringTitlePhoto;
    NSString *_stringNameUser;
    NSString *_stringRealNameUser;
    NSString *_stringLocationUser;
    NSString *_stringUrlIConUser;
    NSString *_stringDatePhotoUpload;
    NSString *_stringDescriptionPhoto;
    NSString *_stringUrlPhotoSize150;
    NSString *_stringUrlPhotoSize240;
    NSString *_stringUrlPhotoSize1024;
    NSString *_stringViewCountPhoto;
    PFSearchPhotoService *searchPhotoService;
}
@property(nonatomic,retain) NSString *_stringPhotoID;
@property(nonatomic,retain) NSString *_stringTitlePhoto;
@property(nonatomic,retain) NSString *_stringNameUser;
@property(nonatomic,retain) NSString *_stringRealNameUser;
@property(nonatomic,retain) NSString *_stringLocationUser;
@property(nonatomic,retain) NSString *_stringUrlIConUser;
@property(nonatomic,retain) NSString *_stringDatePhotoUpload;
@property(nonatomic,retain) NSString *_stringDescriptionPhoto;
@property(nonatomic,retain) NSString *_stringUrlPhotoSize150;
@property(nonatomic,retain) NSString *_stringUrlPhotoSize240;
@property(nonatomic,retain)  NSString *_stringUrlPhotoSize1024;
@property(nonatomic,retain)  NSString *_stringViewCountPhoto;

-(id)initWithData:(NSDictionary *)aPhotoData;
- (NSString*)convertDateStringMySetup:(NSString*)inputDateString;

@end
