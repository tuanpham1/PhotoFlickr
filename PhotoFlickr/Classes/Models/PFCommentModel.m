//
//  PFCommentModel.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//
#import "PFCommentModel.h"

@implementation PFCommentModel

@synthesize _stringUserCommentName;
@synthesize _stringUserCommentIconfarm;
@synthesize _stringUserCommentIconserver;
@synthesize _stringUserCommentId;
@synthesize _stringTextComment;
@synthesize _stringUrlIConUserComment;

-(id)initWithData:(NSDictionary *)aPhotoData {

    self = [super init];
    if (self) {
        self._stringUserCommentName = [aPhotoData objectForKey:@"authorname"];
        self._stringUserCommentIconfarm = [aPhotoData objectForKey:@"iconfarm"];
        self._stringUserCommentIconserver = [aPhotoData objectForKey:@"iconserver"];
        self._stringUserCommentId = [aPhotoData objectForKey:@"author"];
        self._stringTextComment = [aPhotoData objectForKey:@"text"];
        self._stringUrlIConUserComment = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",self._stringUserCommentIconfarm,self._stringUserCommentIconserver,self._stringUserCommentId];
    }
    return self;
}

-(void)dealloc {
    
    [_stringUserCommentName release];
    [_stringUserCommentIconfarm release];
    [_stringUserCommentIconserver release];
    [_stringUserCommentId release];
    [_stringTextComment release];
    [_stringUrlIConUserComment release];
    
    [super dealloc];
}
@end
