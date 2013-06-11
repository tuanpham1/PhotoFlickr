//
//  PFSearchViewController.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFSearchViewController.h"
#import "PFDetailPhotoViewController.h"
#import "XMLReader.h"
#import "MacroSandbox.h"
#import "UIImageView+WebCache.h"

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
    [self CheckConnectInternet];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    searchBarPhoto.delegate = self;
    [self searchBarSetUp];
    
    imageViewSearchLogo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 30, 30)];
    imageViewSearchLogo.image = [UIImage imageNamed:@"logo-search.jpg"];
    [self.navigationController.navigationBar addSubview:imageViewSearchLogo];
    
    imageViewSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 25, 25)];
    imageViewSearchIcon.image = [UIImage imageNamed:@"icon-search.png"];
    [self.navigationController.navigationBar addSubview:imageViewSearchIcon];
    mutableArrayResuilData = [[NSMutableArray alloc] init];
    mutableArraySaveResuilData = [[NSMutableArray alloc] init];
    mutableArraySaveDataCell = [[NSMutableArray alloc] init];
    tableViewResuil.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (changerSetUpNavigationBar:) name:@"ChangerNavigationBar" object:nil];
    
    imageViewBackGroudLoad = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [imageViewBackGroudLoad setUserInteractionEnabled:NO];
    imageViewBackGroudLoad.backgroundColor = [UIColor blackColor];
    imageViewBackGroudLoad.alpha = 0;
    [self.view addSubview:imageViewBackGroudLoad];
	
    activityIndicatorviewLoadingSearch = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorviewLoadingSearch.frame = CGRectMake(150, 150, 37, 37);
    activityIndicatorviewLoadingSearch.backgroundColor = [UIColor blackColor];
    [activityIndicatorviewLoadingSearch stopAnimating];
    [self.view addSubview:activityIndicatorviewLoadingSearch];
    
}
////========================Check connect internet
-(BOOL)CheckConnectInternet {
    
    BOOL connect = YES;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        connect = NO;
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle:@""
                     message:@"Không thể kết nối internet"
                     delegate: self
                     cancelButtonTitle: @"OK" otherButtonTitles: nil,nil];
        
        [errorView show];
        [errorView autorelease];
    }
    
    return connect;
}

-(IBAction)changerSetUpNavigationBar:(id)sender {

    searchBarPhoto.text = @"Keyword";
    searchBarPhoto.hidden = NO;
    imageViewSearchIcon.hidden = NO;
    imageViewSearchLogo.hidden = NO;
    [searchBarPhoto resignFirstResponder];
    [tableViewResuil reloadData];
}
//Fine Photo Akey search
-(NSDictionary *)GetResuilSearchPhoto:(NSString *)aKeySearch {

    NSString *require = [[NSString alloc] initWithString:[NSString stringWithFormat:@"method=flickr.photos.search&api_key=%@&text=%@",PF_API_KEY,aKeySearch]];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",PF_URL_SERVER]];
    
    NSData *postData = [require dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:urlData error:&parseError];
    RELEASE_OBJECT(require);
    RELEASE_OBJECT(request);
    return xmlDictionary;

}
//Fine A Photo Info
-(NSDictionary *)GetInfoPhotoItem:(NSString *)aPhotoID andSecretPhoto:(NSString *)secretPhoto {
    
    NSString *require = [[NSString alloc] initWithString:[NSString stringWithFormat:@"method=flickr.photos.getInfo&api_key=%@&photo_id=%@&secret=%@",PF_API_KEY,aPhotoID,secretPhoto]];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",PF_URL_SERVER]];
    
    NSData *postData = [require dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:urlData error:&parseError];
    RELEASE_OBJECT(require);
    RELEASE_OBJECT(request);
    return xmlDictionary;
    
}
#pragma mark Seach Function
-(void)searchBarSetUp {
    
    
    searchBarPhoto.autocorrectionType = UITextAutocorrectionTypeNo;
    //searchBarPhoto.backgroundColor = ;
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
            // [(UITextField *)subview setBackground:[UIImage imageNamed:@"txt_search.png"]];
        }
    }
    
}
// Khi search bar bat dau nhap key
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
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
    
    imageViewBackGroudLoad.alpha = 0.3;
    [imageViewBackGroudLoad setUserInteractionEnabled:YES];
    [activityIndicatorviewLoadingSearch startAnimating];
    
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        imageViewBackGroudLoad.alpha = 0;
        [imageViewBackGroudLoad setUserInteractionEnabled:NO];
        [activityIndicatorviewLoadingSearch stopAnimating];
        [self CheckConnectInternet];
        if (searchBar.text.length > 0) {
            indexCellLoader = 10;
            [mutableArraySaveDataCell removeAllObjects];
            [mutableArraySaveResuilData removeAllObjects];
            NSDictionary *dictionaryResuilSearch = [self GetResuilSearchPhoto:searchBar.text];
            NSDictionary *dictionaryrsp = [dictionaryResuilSearch objectForKey:@"rsp"];
            NSDictionary *dictionaryPhotos = [dictionaryrsp objectForKey:@"photos"];
            NSDictionary *dictionaryPhoto = [dictionaryPhotos objectForKey:@"photo"];
            int i = 0;
            
            for (NSDictionary *dictionaryPhotoItem in dictionaryPhoto) {
                i++;
                [mutableArraySaveResuilData addObject:dictionaryPhotoItem];
                
            }
            if (mutableArraySaveResuilData.count > 0) {
                [self GetDataPhotoForCell:indexCellLoader];
                labelNumberResuil.text = [NSString stringWithFormat:@"Results found: %i photos",i];
                tableViewResuil.hidden = NO;
                [tableViewResuil reloadData];
            } else {
                
                labelNumberResuil.text = @"Not fine resuil!";
            }
            
            
        }else {
            
                labelNumberResuil.text = @"Not fine resuil!";
        }
        
    });
    
    
    
    
    
    
    
    //[spinning stopAnimating];
    //RELEASE_OBJECT(spinning);
}
// Khi nut cancel duoc click
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
	[searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
}
-(void)GetDataPhotoForCell:(int)indexRow {

    if(mutableArraySaveDataCell.count < indexRow)
    {
        for (int i = mutableArraySaveDataCell.count; i < indexRow ; i++) {
            NSDictionary *dictionaryPhotoItem = [mutableArraySaveResuilData objectAtIndex:i];
            NSString *stringPhotoID = [dictionaryPhotoItem objectForKey:@"id"];
            NSString *stringSecret = [dictionaryPhotoItem objectForKey:@"secret"];
            NSDictionary *dictionaryPhotoInfo = [self GetInfoPhotoItem:stringPhotoID andSecretPhoto:stringSecret];
            
            NSDictionary *dictionaryPhotoInfoRsp = [dictionaryPhotoInfo objectForKey:@"rsp"];
            NSDictionary *dictionaryPhotoInfoPhoto = [dictionaryPhotoInfoRsp objectForKey:@"photo"];
            NSDictionary *dictionaryPhotoInfoOwner = [dictionaryPhotoInfoPhoto objectForKey:@"owner"];
            NSDictionary *dictionaryPhotoInfoDates = [dictionaryPhotoInfoPhoto objectForKey:@"dates"];
            NSDictionary *dictionaryPhotoInfoTitle = [dictionaryPhotoInfoPhoto objectForKey:@"title"];
            NSDictionary *dictionaryPhotoInfoDescription = [dictionaryPhotoInfoPhoto objectForKey:@"description"];
            NSDictionary *dictionaryPhotoInfoCommentAll = [dictionaryPhotoInfoPhoto objectForKey:@"tags"];
            NSString *stringViewCountPhoto =         [dictionaryPhotoInfoPhoto objectForKey:@"views"];
            
            //get info user(username, location, url Image)
            NSString *stringNameUser = [dictionaryPhotoInfoOwner objectForKey:@"username"];
            NSString *stringRealNameUser = [dictionaryPhotoInfoOwner objectForKey:@"realname"];
            NSString *stringLocationUser = [dictionaryPhotoInfoOwner objectForKey:@"location"];
            NSString *stringIconFarmUser = [dictionaryPhotoInfoOwner objectForKey:@"iconfarm"];
            NSString *stringIconServerUser = [dictionaryPhotoInfoOwner objectForKey:@"iconserver"];
            NSString *stringIdUser = [dictionaryPhotoInfoOwner objectForKey:@"nsid"];
            NSString *stringUrlIConUser = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",stringIconFarmUser,stringIconServerUser,stringIdUser];
            
            //Get date photo upload
            NSString *stringDatePhotoUpload = [dictionaryPhotoInfoDates objectForKey:@"taken"];
            stringDatePhotoUpload = [self convertDateStringMySetup:stringDatePhotoUpload];
        
            
            //get title photo
            NSString *stringTitlePhoto = [dictionaryPhotoInfoTitle objectForKey:@"text"];
            NSString *stringDescriptionPhoto = [dictionaryPhotoInfoDescription objectForKey:@"text"];
            
            //url photo loader
            NSDictionary *dictionaryPhotoInfoFarm = [dictionaryPhotoInfoPhoto objectForKey:@"farm"];
            NSDictionary *dictionaryPhotoInfoServerId = [dictionaryPhotoInfoPhoto objectForKey:@"server"];
            NSDictionary *dictionaryPhotoInfoId = [dictionaryPhotoInfoPhoto objectForKey:@"id"];
            NSDictionary *dictionaryPhotoInfoSecret = [dictionaryPhotoInfoPhoto objectForKey:@"secret"];
            NSString *stringUrlPhotoSize150 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_q.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
            NSString *stringUrlPhotoSize240 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_m.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
            NSString *stringUrlPhotoSize1024 = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_b.jpg",dictionaryPhotoInfoFarm,dictionaryPhotoInfoServerId,dictionaryPhotoInfoId,dictionaryPhotoInfoSecret];
            
            NSMutableDictionary *mutableDictionaryPhotoItem = [[NSMutableDictionary alloc] init];
            
            if (stringTitlePhoto == NULL) {
                stringTitlePhoto = @"no photo";
            }
            if (stringNameUser == NULL) {
                stringNameUser = @"no name";
            }
            if (stringRealNameUser == NULL) {
                stringRealNameUser = @"no real name";
            }
            if (stringLocationUser == NULL) {
                stringLocationUser = @"no location";
            }
            if (stringUrlIConUser == NULL) {
                stringUrlIConUser = @"no url icon";
            }
            if (stringDatePhotoUpload == NULL) {
                stringDatePhotoUpload = @"no date photo";
            }
            if (stringDescriptionPhoto == NULL) {
                stringDescriptionPhoto = @"no descreption";
            }
            if (stringUrlPhotoSize150 == NULL) {
                stringUrlPhotoSize150 = @"no photo size 150";
            }
            if (stringUrlPhotoSize240 == NULL) {
                stringUrlPhotoSize240 = @"no photo size 240";
            }
            if (stringUrlPhotoSize1024 == NULL) {
                stringUrlPhotoSize1024 = @"no photo size 1024";
            }
            if (stringViewCountPhoto == NULL) {
                stringViewCountPhoto = @"0";
            }
            if (dictionaryPhotoInfoCommentAll != NULL) {
                [mutableDictionaryPhotoItem setObject:dictionaryPhotoInfoCommentAll forKey:@"tags"];
            }
            
            [mutableDictionaryPhotoItem setObject:stringTitlePhoto forKey:@"title"];
            [mutableDictionaryPhotoItem setObject:stringNameUser forKey:@"username"];
            [mutableDictionaryPhotoItem setObject:stringRealNameUser forKey:@"realname"];
            [mutableDictionaryPhotoItem setObject:stringLocationUser forKey:@"loacation"];
            [mutableDictionaryPhotoItem setObject:stringUrlIConUser forKey:@"urlicon"];
            [mutableDictionaryPhotoItem setObject:stringDatePhotoUpload forKey:@"dateupload"];
            [mutableDictionaryPhotoItem setObject:stringDescriptionPhoto forKey:@"description"];
            [mutableDictionaryPhotoItem setObject:stringUrlPhotoSize150 forKey:@"photosize150"];
            [mutableDictionaryPhotoItem setObject:stringUrlPhotoSize240 forKey:@"photosize240"];
            [mutableDictionaryPhotoItem setObject:stringUrlPhotoSize1024 forKey:@"photosize1024"];
            [mutableDictionaryPhotoItem setObject:stringViewCountPhoto forKey:@"viewCount"];
            
            [mutableArraySaveDataCell addObject:mutableDictionaryPhotoItem];
            
            RELEASE_OBJECT(mutableDictionaryPhotoItem);
            
        }
    }
    

}
- (NSString*)convertDateStringMySetup:(NSString*)inputDateString{
    NSString *trimmedString = [inputDateString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //    NSString *string1=[inputDateString stringByAppendingString:@" 00:00:00 +0000"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [dateFormatter dateFromString:trimmedString];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:date1];
}
#pragma mark Table Function
// table view resuil data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return indexCellLoader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"PKCustomCellViewController";
	
    PKCustomCellViewController *cell = (PKCustomCellViewController*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PKCustomCellViewController" owner:self options:nil];
        cell = customCellTableView;
        customCellTableView = nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (mutableArraySaveDataCell.count > 0) {
        NSDictionary *dictionaryPhotoItemCell = [mutableArraySaveDataCell objectAtIndex:indexPath.row];
        
        //get info user(username, location, url Image)
        NSString *stringUrlIconUser = [dictionaryPhotoItemCell objectForKey:@"urlicon"];
        NSString *stringNameUser = [dictionaryPhotoItemCell objectForKey:@"username"];
        NSString *stringLocationUser = [dictionaryPhotoItemCell objectForKey:@"loacation"];
        NSString *stringDatePhotoUpload = [dictionaryPhotoItemCell objectForKey:@"dateupload"];
        NSString *stringViewCountPhoto = [NSString stringWithFormat:@"Views: %@",[dictionaryPhotoItemCell objectForKey:@"viewCount"]] ;
        NSString *stringUrlPhoto = [dictionaryPhotoItemCell objectForKey:@"photosize150"];
        
        //load date for cell
        [cell.imageViewAvatar setImageWithURL:[NSURL URLWithString:stringUrlIconUser]];
        cell.labelNameUser.text = stringNameUser;
        cell.labelLocationUser.text = stringLocationUser;
        cell.labelDateUpload.text = stringDatePhotoUpload;
        cell.labelCountView.text = stringViewCountPhoto;
        [cell.imageViewDescription setImageWithURL:[NSURL URLWithString:stringUrlPhoto]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ((indexPath.row+1) == indexCellLoader && (indexPath.row+1) != mutableArraySaveResuilData.count) {
            imageViewBackGroudLoad.alpha = 0.3;
            [imageViewBackGroudLoad setUserInteractionEnabled:YES];
            [activityIndicatorviewLoadingSearch startAnimating];
            double delayInSeconds = .1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                imageViewBackGroudLoad.alpha = 0;
                [imageViewBackGroudLoad setUserInteractionEnabled:NO];
                [activityIndicatorviewLoadingSearch stopAnimating];
                
                indexCellLoader = indexPath.row+10;
                [self GetDataPhotoForCell:indexCellLoader];
                [tableViewResuil reloadData];
                
            });
        }
    }
    
   
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mutableArraySaveDataCell count] > 0) {
        searchBarPhoto.hidden = YES;
        imageViewSearchIcon.hidden = YES;
        [searchBarPhoto resignFirstResponder];
        NSDictionary *dictionaryPhotoItemCell = [mutableArraySaveDataCell objectAtIndex:indexPath.row];
        PFDetailPhotoViewController *detailPhotoViewController = [[PFDetailPhotoViewController alloc] initWithNibName:@"PFDetailPhotoViewController" aDictionaryItem:dictionaryPhotoItemCell];
        [self.navigationController pushViewController:detailPhotoViewController animated:YES];
        RELEASE_OBJECT(detailPhotoViewController);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 250;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
