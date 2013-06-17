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

-(id)init {

    self = [super init];
    if (self) {
        
    }
    return self;
}
-(PFCommentModel *)initWithData:(NSDictionary *)aPhotoData {
    modelComment = [[PFCommentModel alloc] init];
    modelComment._stringUserCommentName = [aPhotoData objectForKey:@"authorname"];
    modelComment._stringUserCommentIconfarm = [aPhotoData objectForKey:@"iconfarm"];
    modelComment._stringUserCommentIconserver = [aPhotoData objectForKey:@"iconserver"];
    modelComment._stringUserCommentId = [aPhotoData objectForKey:@"author"];
    modelComment._stringTextComment = [aPhotoData objectForKey:@"text"];
    modelComment._stringUrlIConUserComment = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",modelComment._stringUserCommentIconfarm,modelComment._stringUserCommentIconserver,modelComment._stringUserCommentId];
    
    return modelComment;
}

-(void)dealloc {

    [modelComment release];
    [_stringUserCommentName release];
    [_stringUserCommentIconfarm release];
    [_stringUserCommentIconserver release];
    [_stringUserCommentId release];
    [_stringTextComment release];
    [_stringUrlIConUserComment release];
    
    [super dealloc];
}
@end
