//
//  PFCommentModel.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFCommentModel : NSObject
{

    NSString *_stringUserCommentName;
    NSString *_stringUserCommentIconfarm;
    NSString *_stringUserCommentIconserver;
    NSString *_stringUserCommentId;
    NSString *_stringTextComment;
    NSString *_stringUrlIConUserComment;
}

@property(nonatomic, retain) NSString *_stringUserCommentName;
@property(nonatomic, retain) NSString *_stringUserCommentIconfarm;
@property(nonatomic, retain) NSString *_stringUserCommentIconserver;
@property(nonatomic, retain) NSString *_stringUserCommentId;
@property(nonatomic, retain) NSString *_stringTextComment;
@property(nonatomic, retain) NSString *_stringUrlIConUserComment;

-(id)initWithData:(NSDictionary *)aPhotoData;

@end
