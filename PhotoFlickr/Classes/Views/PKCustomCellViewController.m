//
//  PKCustomCellViewController.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//
#import "MacroSandbox.h"
#import "PKCustomCellViewController.h"



@implementation PKCustomCellViewController

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
