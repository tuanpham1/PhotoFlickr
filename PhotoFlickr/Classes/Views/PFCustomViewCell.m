//
//  PFCustomViewCell.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFCustomViewCell.h"
#import "MacroSandbox.h"

@implementation PFCustomViewCell

@synthesize imageViewAvatar,imageViewDescription,labelNameUser,labelLocationUser,labelCountView,labelDateUpload;

-(void) dealloc {
    RELEASE_OBJECT(imageViewAvatar);
    RELEASE_OBJECT(imageViewDescription);
    RELEASE_OBJECT(labelNameUser);
    RELEASE_OBJECT(labelLocationUser);
    RELEASE_OBJECT(labelDateUpload);
    RELEASE_OBJECT(labelCountView);
    [super dealloc];
}

@end
