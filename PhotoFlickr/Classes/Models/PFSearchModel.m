//
//  PFSearchModel.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFSearchModel.h"

@implementation PFSearchModel
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
-(PFSearchModel *)initWithData:(NSDictionary *)aPhotoData{
    
    searchPhotoService = [[PFSearchPhotoService alloc] init];
    modelSearch = [[PFSearchModel alloc] init];
    
    NSString *stringPhotoID = [aPhotoData objectForKey:@"id"];
    NSString *stringSecret = [aPhotoData objectForKey:@"secret"];
    
    NSDictionary *dictionaryPhotoInfo = [searchPhotoService getInfomationPhotoById:stringPhotoID secretPhoto:stringSecret];
    
    NSDictionary *dictionaryPhotoInfoRsp = [dictionaryPhotoInfo objectForKey:@"rsp"];
    NSDictionary *dictionaryPhotoInfoPhoto = [dictionaryPhotoInfoRsp objectForKey:@"photo"];
    NSDictionary *dictionaryPhotoInfoOwner = [dictionaryPhotoInfoPhoto objectForKey:@"owner"];
    NSDictionary *dictionaryPhotoInfoDates = [dictionaryPhotoInfoPhoto objectForKey:@"dates"];
    NSDictionary *dictionaryPhotoInfoTitle = [dictionaryPhotoInfoPhoto objectForKey:@"title"];
    NSDictionary *dictionaryPhotoInfoDescription = [dictionaryPhotoInfoPhoto objectForKey:@"description"];
    
    //get info user(username, location, url Image)
    
    NSString *stringIconFarm = [dictionaryPhotoInfoOwner objectForKey:@"iconfarm"];
    NSString *stringIconServer = [dictionaryPhotoInfoOwner objectForKey:@"iconserver"];
    NSString *stringIdUser = [dictionaryPhotoInfoOwner objectForKey:@"nsid"];
    NSDictionary *dictionaryPhotoInfoFarm = [dictionaryPhotoInfoPhoto objectForKey:@"farm"];
    NSDictionary *dictionaryPhotoInfoServerId = [dictionaryPhotoInfoPhoto objectForKey:@"server"];
    NSDictionary *dictionaryPhotoInfoId = [dictionaryPhotoInfoPhoto objectForKey:@"id"];
    NSDictionary *dictionaryPhotoInfoSecret = [dictionaryPhotoInfoPhoto objectForKey:@"secret"];
    
    NSString *stringDatePhotoUpload = [dictionaryPhotoInfoDates objectForKey:@"taken"];
    NSString *stringUrlIConUser = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",stringIconFarm,stringIconServer,stringIdUser];
    NSString *stringUrlPhotoSize150 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_q.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
    NSString *stringUrlPhotoSize240 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
    NSString *stringUrlPhotoSize1024 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_b.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
    
    
    modelSearch._stringPhotoID = stringPhotoID;
    modelSearch._stringTitlePhoto = [dictionaryPhotoInfoTitle objectForKey:@"text"];
    modelSearch._stringNameUser = [dictionaryPhotoInfoOwner objectForKey:@"username"];
    modelSearch._stringRealNameUser = [dictionaryPhotoInfoOwner objectForKey:@"realname"];
    modelSearch._stringLocationUser = [dictionaryPhotoInfoOwner objectForKey:@"location"];
    modelSearch._stringDatePhotoUpload = stringDatePhotoUpload;
    modelSearch._stringViewCountPhoto = [NSString stringWithFormat:@"Views: %@",[dictionaryPhotoInfoPhoto objectForKey:@"views"]];
    modelSearch._stringDescriptionPhoto = [dictionaryPhotoInfoDescription objectForKey:@"text"];
    modelSearch._stringUrlIConUser = stringUrlIConUser;
    modelSearch._stringUrlPhotoSize150 = stringUrlPhotoSize150;
    modelSearch._stringUrlPhotoSize240 = stringUrlPhotoSize240;
    modelSearch._stringUrlPhotoSize1024 = stringUrlPhotoSize1024;
    
    return modelSearch;
}
-(void)dealloc
{
    [searchPhotoService release];
    [modelSearch release];
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
