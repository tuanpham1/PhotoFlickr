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
    PFCommentModel *modelComment;
}

@property(nonatomic, strong) NSString *_stringUserCommentName;
@property(nonatomic, strong) NSString *_stringUserCommentIconfarm;
@property(nonatomic, strong) NSString *_stringUserCommentIconserver;
@property(nonatomic, strong) NSString *_stringUserCommentId;
@property(nonatomic, strong) NSString *_stringTextComment;
@property(nonatomic, strong) NSString *_stringUrlIConUserComment;

-(PFCommentModel *)initWithData:(NSDictionary *)aPhotoData;

@end
