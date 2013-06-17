//
//  PFSearchPhotoService.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFSearchPhotoService : NSObject

-(NSDictionary *)searchPhotosWithTextingKey:(NSString *)aKeySearch;
-(NSDictionary *)getInfomationPhotoById:(NSString *)aPhotoID secretPhoto:(NSString *)aSecretPhoto;
-(NSDictionary *)getCommentsPhotoById:(NSString *)aPhotoId;

@end
