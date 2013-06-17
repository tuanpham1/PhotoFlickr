//
//  PFSearchViewController.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFSearchViewController.h"
#import "PFDetailPhotoViewController.h"
#import "MacroSandbox.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "PFSearchModel.h"
#import "PFSearchPhotoService.h"
@implementation PFSearchViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc {
    RELEASE_OBJECT(checkInternet);
    RELEASE_OBJECT(mutableArraySaveDataCell);
    RELEASE_OBJECT(searchBarPhoto);
    RELEASE_OBJECT(imageViewSearchLogo);
    RELEASE_OBJECT(imageViewSearchIcon);
    RELEASE_OBJECT(tableViewResuil);
    RELEASE_OBJECT(customCellTableView);
    RELEASE_OBJECT(mutableArrayResuilData);
    RELEASE_OBJECT(mutableArraySaveResuilData);
    RELEASE_OBJECT(activityIndicatorviewLoadingSearch);
    RELEASE_OBJECT(imageViewBackGroudLoad);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    widthScreen = [UIScreen mainScreen].bounds.size.width;
    heightScreen = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = CGRectMake(0, 0, widthScreen, heightScreen);
    tableViewResuil.frame = CGRectMake(0, 60, widthScreen, heightScreen-60);
    
    checkInternet = [[CheckConnectInternet alloc] init];
    mutableArrayResuilData = [[NSMutableArray alloc] init];
    mutableArraySaveResuilData = [[NSMutableArray alloc] init];
    mutableArraySaveDataCell = [[NSMutableArray alloc] init];
    
    tableViewResuil.hidden = YES;
    
    [checkInternet isConnectInternet];
    [self setUpSearchBarWithImages];
    
    labelTitleApp = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 200, 20)];
    labelTitleApp.backgroundColor = [UIColor clearColor];
    labelTitleApp.font = [UIFont systemFontOfSize:15];
    labelTitleApp.text = @"Search For Photos In Flickr";
    labelTitleApp.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:labelTitleApp];
    
    imageViewSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
    imageViewSearchIcon.image = [UIImage imageNamed:@"icon-search.png"];
    [self.navigationController.navigationBar addSubview:imageViewSearchIcon];

    imageViewBackGroudLoad = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthScreen, heightScreen)];
    [imageViewBackGroudLoad setUserInteractionEnabled:NO];
    imageViewBackGroudLoad.backgroundColor = [UIColor blackColor];
    imageViewBackGroudLoad.alpha = 0;
    [self.view addSubview:imageViewBackGroudLoad];
	
    activityIndicatorviewLoadingSearch = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorviewLoadingSearch.frame = CGRectMake(130, 130, 50, 50);
    activityIndicatorviewLoadingSearch.center = CGPointMake(widthScreen/2, widthScreen/2);
    activityIndicatorviewLoadingSearch.backgroundColor = [UIColor clearColor];
    [activityIndicatorviewLoadingSearch stopAnimating];
    [self.view addSubview:activityIndicatorviewLoadingSearch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (changerSetUpNavigationBar:) name:@"PFNavigationBarDidChangerNotification" object:nil];
    
}
// Changer setup navigaion bar when back from detail screen
-(IBAction)changerSetUpNavigationBar:(id)sender {

    labelTitleApp.hidden = NO;
    searchBarPhoto.text = @"Keyword";
    searchBarPhoto.hidden = NO;
    imageViewSearchIcon.hidden = NO;
    imageViewSearchLogo.hidden = NO;
    [searchBarPhoto resignFirstResponder];
    [tableViewResuil reloadData];
}

#pragma mark Seach Function
// changer interface search bar
-(void)setUpSearchBarWithImages {
    searchBarPhoto.delegate = self;
    searchBarPhoto.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBarPhoto.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-searchBar.png"]];
    labelNumberResuil.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-searchBar.png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-searchBar.png"]];
    
    searchBarPhoto.delegate = self;
    searchBarPhoto.text = @"Keyword";
    UITextField *textfield=(UITextField*)[[searchBarPhoto subviews] objectAtIndex:1];
    textfield.leftView=nil;
    for (UIView *subview in [searchBarPhoto subviews]) {
        if([subview conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)subview setReturnKeyType:UIReturnKeyDone];
            [(UITextField *)subview setEnablesReturnKeyAutomatically:NO];
        }
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
        }
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [(UITextField *)subview setBackground:[UIImage imageNamed:@"bg-InputSearchBar.png"]];
            [(UITextField *)subview setTextColor:[UIColor darkGrayColor]];
            [(UITextField *)subview setFont:[UIFont systemFontOfSize:13]];
        }
    }
    
}
// Khi search bar bat dau nhap key
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    stopRun = YES;
    searchBar.text = @"";
	[searchBar becomeFirstResponder];
    for (UIView *subview in [searchBarPhoto subviews]) {
        if([subview conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)subview setReturnKeyType:UIReturnKeySearch];
            [(UITextField *)subview setEnablesReturnKeyAutomatically:NO];
        }
    }
}
// Sau khi ket thuc nhap key
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
}
// Sau khi search button duoc click
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
    [checkInternet isConnectInternet];
    imageViewBackGroudLoad.alpha = 0.3;
    [imageViewBackGroudLoad setUserInteractionEnabled:YES];
    [activityIndicatorviewLoadingSearch startAnimating];
    
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        imageViewBackGroudLoad.alpha = 0;
        [imageViewBackGroudLoad setUserInteractionEnabled:NO];
        [activityIndicatorviewLoadingSearch stopAnimating];
        if (searchBar.text.length > 0) {
            indexCellLoader = 10;
            [mutableArraySaveDataCell removeAllObjects];
            [mutableArraySaveResuilData removeAllObjects];
            [self resuilPhotosWithSeachingKey:searchBar.text];
            
        }else {
            
                labelNumberResuil.text = @"Not fine resuil!";
        }
        
    });
}
// Khi nut cancel duoc click
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
	[searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark Resuil Search
// Resul photos with search key
-(void)resuilPhotosWithSeachingKey:(NSString *)aKeySearch {
    PFSearchPhotoService *searchPhotoService = [[PFSearchPhotoService alloc] init];
    
    NSDictionary *dictionaryDataPhotos = [searchPhotoService searchPhotosWithTextingKey:aKeySearch];
    NSDictionary *dictionaryrsp = [dictionaryDataPhotos objectForKey:@"rsp"];
    NSDictionary *dictionaryPhotos = [dictionaryrsp objectForKey:@"photos"];
    NSDictionary *dictionaryPhoto = [dictionaryPhotos objectForKey:@"photo"];
    mutableArraySaveResuilData = [dictionaryPhoto mutableCopy];
    
    if (mutableArraySaveResuilData.count > 0) {
        stopRun = NO;
        [self loadCellAtIndex:indexCellLoader];
        labelNumberResuil.text = [NSString stringWithFormat:@"    Results found: %i photos",mutableArraySaveResuilData.count];
        tableViewResuil.hidden = NO;
        [tableViewResuil reloadData];
        
    } else {
        
        labelNumberResuil.text = @"     Not fine resuil!";
    }
    RELEASE_OBJECT(searchPhotoService);
}
// load 10 row for table view
-(void)loadCellAtIndex:(int)indexRow {

    if(mutableArraySaveDataCell.count < indexRow)
    {
        for (int i = mutableArraySaveDataCell.count; i < indexRow ; i++) {
            if (i < mutableArraySaveResuilData.count) {
                if (stopRun == YES) {
                    indexCellLoader = i;
                    return;
                }
                NSDictionary *dictionaryPhotoItem = [mutableArraySaveResuilData objectAtIndex:i];
                PFSearchModel *modelSearch = [[PFSearchModel alloc] initWithData:dictionaryPhotoItem];
                [mutableArraySaveDataCell addObject:modelSearch];
                RELEASE_OBJECT(modelSearch);
            }
        }
    }
}
#pragma mark Table Function
// table view resuil data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return mutableArraySaveDataCell.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"PFCustomViewCell";
	
    PFCustomViewCell *cell = (PFCustomViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PFCustomViewCell" owner:self options:nil];
        cell = customCellTableView;
        customCellTableView = nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (mutableArraySaveDataCell.count > 0) {
        
        PFSearchModel *modelSearch = [mutableArraySaveDataCell objectAtIndex:indexPath.row];
        [cell.imageViewAvatar setImageWithURL:[NSURL URLWithString:modelSearch._stringUrlIConUser]];
        cell.labelNameUser.text = modelSearch._stringNameUser;
        cell.labelLocationUser.text = modelSearch._stringLocationUser;
        cell.labelDateUpload.text = modelSearch._stringDatePhotoUpload;
        cell.labelCountView.text = modelSearch._stringViewCountPhoto;
        [cell.imageViewDescription setImageWithURL:[NSURL URLWithString:modelSearch._stringUrlPhotoSize150]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ((indexPath.row+1) == indexCellLoader && (indexPath.row+1) < mutableArraySaveResuilData.count && mutableArraySaveDataCell.count < mutableArraySaveResuilData.count) {
            [activityIndicatorviewLoadingSearch startAnimating];
            activityIndicatorviewLoadingSearch.frame = CGRectMake(130, widthScreen+50, 50, 50);
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^ {
                
                    stopRun = NO;
                    indexCellLoader = indexPath.row+11;
                    [self loadCellAtIndex:indexCellLoader];
                    [activityIndicatorviewLoadingSearch stopAnimating];
                    [tableViewResuil reloadData];
                    
                    activityIndicatorviewLoadingSearch.center = CGPointMake(widthScreen/2, heightScreen/2);
                
            });
            dispatch_release(queue);
        }
    }
    
   
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mutableArraySaveDataCell count] > 0) {
        
        labelTitleApp.hidden = YES;
        searchBarPhoto.hidden = YES;
        imageViewSearchIcon.hidden = YES;
        [searchBarPhoto resignFirstResponder];
        NSDictionary *dictionaryPhotoCell = [mutableArraySaveDataCell mutableCopy];
        PFDetailPhotoViewController *detailPhotoViewController = [[[PFDetailPhotoViewController alloc] initWithNibName:@"PFDetailPhotoViewController" aDictionaryItem:dictionaryPhotoCell indexPath:indexPath.row] autorelease];
        [self.navigationController pushViewController:detailPhotoViewController animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 250;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
    [imageCache cleanDisk];
}

@end
