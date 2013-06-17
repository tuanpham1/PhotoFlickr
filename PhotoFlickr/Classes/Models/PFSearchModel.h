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
    PFSearchModel *modelSearch;
    PFSearchPhotoService *searchPhotoService;
}
@property(nonatomic,strong) NSString *_stringPhotoID;
@property(nonatomic,strong) NSString *_stringTitlePhoto;
@property(nonatomic,strong) NSString *_stringNameUser;
@property(nonatomic,strong) NSString *_stringRealNameUser;
@property(nonatomic,strong) NSString *_stringLocationUser;
@property(nonatomic,strong) NSString *_stringUrlIConUser;
@property(nonatomic,strong) NSString *_stringDatePhotoUpload;
@property(nonatomic,strong) NSString *_stringDescriptionPhoto;
@property(nonatomic,strong) NSString *_stringUrlPhotoSize150;
@property(nonatomic,strong) NSString *_stringUrlPhotoSize240;
@property(nonatomic,strong)  NSString *_stringUrlPhotoSize1024;
@property(nonatomic,strong)  NSString *_stringViewCountPhoto;

-(PFSearchModel *)initWithData:(NSDictionary *)aPhotoData;
@end
