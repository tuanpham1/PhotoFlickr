//
//  PFCustomViewCell.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFCustomViewCell : UITableViewCell
{
    
    IBOutlet UIImageView *imageViewAvatar;
    IBOutlet UIImageView *imageViewDescription;
    IBOutlet UILabel *labelNameUser;
    IBOutlet UILabel *labelLocationUser;
    IBOutlet UILabel *labelDateUpload;
    IBOutlet UILabel *labelCountView;
    
}
@property(nonatomic,retain) IBOutlet UIImageView *imageViewAvatar;
@property(nonatomic,retain) IBOutlet UIImageView *imageViewDescription;
@property(nonatomic,retain) IBOutlet UILabel *labelNameUser;
@property(nonatomic,retain) IBOutlet UILabel *labelLocationUser;
@property(nonatomic,retain) IBOutlet UILabel *labelDateUpload;
@property(nonatomic,retain) IBOutlet UILabel *labelCountView;

@end
