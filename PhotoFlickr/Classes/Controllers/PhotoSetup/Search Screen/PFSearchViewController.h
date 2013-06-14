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
@interface PFSearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{

    IBOutlet UISearchBar *searchBarPhoto;
    IBOutlet UILabel *labelNumberResuil;
    UILabel *labelTitleApp;
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
    float widthScreen;
    float heightScreen;
    BOOL stopRun;
}
-(void)searchPhotosBySetUp;
-(NSDictionary *)getResuilWithSearchingPhotos:(NSString *)aKeySearch;
-(NSDictionary *)getInfomationPhotoById:(NSString *)aPhotoID secretPhoto:(NSString *)aSecretPhoto;
-(void)loadCellAtIndex:(int)indexRow;
-(BOOL)checkConnectWithInternet;
- (NSString*)convertDateByString:(NSString*)aDateString;
@end
