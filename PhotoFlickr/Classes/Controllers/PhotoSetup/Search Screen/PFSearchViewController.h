//
//  PFSearchViewController.h
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKCustomCellViewController.h"
#import "Reachability.h"
@interface PFSearchViewController : UIViewController <UISearchBarDelegate>
{

    IBOutlet UISearchBar *searchBarPhoto;
    IBOutlet UILabel *labelNumberResuil;
    UIImageView *imageViewSearchLogo;
    UIImageView *imageViewSearchIcon;
    IBOutlet UITableView *tableViewResuil;
    IBOutlet PKCustomCellViewController *customCellTableView;
    NSMutableArray *mutableArrayResuilData;
    NSMutableArray *mutableArraySaveResuilData;
    NSMutableArray *mutableArraySaveDataCell;
    int indexCellLoader;
    UIImageView *imageViewBackGroudLoad;
    UIActivityIndicatorView *activityIndicatorviewLoadingSearch;
}
-(void)searchBarSetUp;
-(void)changerSetUpNavigationBar;
-(NSDictionary *)GetResuilSearchPhoto:(NSString *)aKeySearch;
-(NSDictionary *)GetInfoPhotoItem:(NSString *)aPhotoID andSecretPhoto:(NSString *)secretPhoto;
-(void)GetDataPhotoForCell:(int)indexRow;
-(BOOL)CheckConnectInternet;
- (NSString*)convertDateStringMySetup:(NSString*)inputDateString;
@end
