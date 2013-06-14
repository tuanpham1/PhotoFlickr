//
//  PFDetailPhotoViewController.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/5/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFDetailPhotoViewController.h"
#import "PFImageDetailViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "MacroSandbox.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "XMLReader.h"

@interface PFDetailPhotoViewController ()

@end

@implementation PFDetailPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil aDictionaryItem:(NSDictionary *)dictionaryItem indexPath:(int)indexPath
{
    mutableArrayDetailPhoto = [[NSMutableArray alloc] init];
    mutableArrayDetailPhoto = [dictionaryItem mutableCopy];
    NSDictionary *dictionaryItem0 = [mutableArrayDetailPhoto objectAtIndex:0];
    NSDictionary *dictionaryItemPath = [mutableArrayDetailPhoto objectAtIndex:indexPath];
    
    [mutableArrayDetailPhoto replaceObjectAtIndex:0 withObject:dictionaryItemPath];
    [mutableArrayDetailPhoto replaceObjectAtIndex:indexPath withObject:dictionaryItem0];
    return self;
}
-(void)dealloc {
    RELEASE_OBJECT(labelTitleImage);
    RELEASE_OBJECT(mutableArrayDetailPhoto);
    RELEASE_OBJECT(scrollViewAllDetail);
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    widthScreen = [UIScreen mainScreen].bounds.size.width;
    heightScreen = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = CGRectMake(0, 0, widthScreen, heightScreen);
    scrollViewAllDetail.frame = CGRectMake(0, 10, widthScreen, heightScreen);
    scrollViewAllDetail.contentSize = CGSizeMake(widthScreen, heightScreen);
    indexScrollPage = 0;
    
    scrollViewAllDetail.pagingEnabled = YES;
    scrollViewAllDetail.scrollEnabled = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-searchBar.png"]];
    //get info user(username, location, url Image)
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"bg-BackButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backScreenBySearch:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 16, 51, 31);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    RELEASE_OBJECT(barButtonItem);
    
    labelTitleImage = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 250, 30)];
    labelTitleImage.font = [UIFont systemFontOfSize:14];
    labelTitleImage.backgroundColor = [UIColor clearColor];
    labelTitleImage.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:labelTitleImage];
    
    SearchModel *modelSearch0  = [mutableArrayDetailPhoto objectAtIndex:0];
    labelTitleImage.text = modelSearch0._stringTitlePhoto;
    [self loadDetailWithPhoto:modelSearch0 OriginX:0];
    indexPageLoader = 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
    float indexOriginX = (1*widthScreen);
        SearchModel *modelSearch1  = [mutableArrayDetailPhoto objectAtIndex:1];
        [self loadDetailWithPhoto:modelSearch1 OriginX:indexOriginX];
    });
    dispatch_release(queue);
}

-(IBAction)backScreenBySearch:(id)sender{
    labelTitleImage.hidden = YES;
    UIButton *buttonBack = (UIButton *)sender;
    buttonBack.frame = CGRectMake(0, 0, 0, 0);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangerNavigationBar" object:nil];
}
-(IBAction)moveScreenWithDetailingPhoto:(id)sender {

    //labelTitleImage.text = @"Detail Images";
    SearchModel *modelSearch = [mutableArrayDetailPhoto objectAtIndex:indexScrollPage];
    NSString *stringUrlPhoto1024 = modelSearch._stringUrlPhotoSize1024;
    
    PFImageDetailViewController *imageDetailViewController = [[PFImageDetailViewController alloc] initWithNibName:@"PFImageDetailViewController" aNameImage:stringUrlPhoto1024];
    [self.navigationController pushViewController:imageDetailViewController animated:YES];
    RELEASE_OBJECT(imageDetailViewController);
}
-(void)loadDetailWithPhoto:(SearchModel *)aModelSearch OriginX:(float)indexOriginX {
    
    DetailPhotoModel *detailPhotoModel = [[DetailPhotoModel alloc] init];
    detailPhotoModel._scrollViewItem.frame = CGRectMake(indexOriginX, 0, widthScreen, heightScreen-50);
    detailPhotoModel._scrollViewItem.contentSize = CGSizeMake(widthScreen, 650);
    [scrollViewAllDetail addSubview:detailPhotoModel._scrollViewItem];
    
    //Text View Description
    int indexLine = ceilf(aModelSearch._stringDescriptionPhoto.length/46.0);
    detailPhotoModel._scrollViewDescription.contentSize = CGSizeMake(263, indexLine*13);
    detailPhotoModel._labelTitleDescription.frame = CGRectMake(0, 0, 283,indexLine*13);
    
    //Data Detail Photo
    [detailPhotoModel._imageViewAvatarUser setImageWithURL:[NSURL URLWithString:aModelSearch._stringUrlIConUser]];
    [detailPhotoModel._imageViewDetail setImageWithURL:[NSURL URLWithString:aModelSearch._stringUrlPhotoSize240]];
    detailPhotoModel._labelNameUser.text = aModelSearch._stringNameUser;
    detailPhotoModel._labelNameUserTrue.text = aModelSearch._stringRealNameUser;
    detailPhotoModel._labelLocationUser.text = aModelSearch._stringLocationUser;
    detailPhotoModel._labelDateUpload.text = aModelSearch._stringDatePhotoUpload;
    detailPhotoModel._labelViewCount.text = aModelSearch._stringViewCountPhoto;
    detailPhotoModel._labelTitleDescription.text = aModelSearch._stringDescriptionPhoto;
    detailPhotoModel._labelTitleComment.frame = CGRectMake(5, 395, 290, 20);
    
    //Get data Comment
    NSDictionary *dictionaryCommentPhoto = [self getCommentsPhotoById:aModelSearch._stringPhotoID];
    NSDictionary *dictionaryCommentPhotoRsp = [dictionaryCommentPhoto objectForKey:@"rsp"];
    NSDictionary *dictionaryCommentPhotoComments = [dictionaryCommentPhotoRsp objectForKey:@"comments"];
    detailPhotoModel._labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",0];
    if (dictionaryCommentPhotoComments.count == 3) {
        
        NSDictionary *dictionaryCommentPhotoComment = [dictionaryCommentPhotoComments objectForKey:@"comment"];
        if (dictionaryCommentPhotoComment.count != 8 && dictionaryCommentPhotoComment.count > 0) {
            detailPhotoModel._labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",dictionaryCommentPhotoComment.count];
                [self loadDataWithCommentingPhoto:detailPhotoModel._scrollViewComment dictionaryComment:dictionaryCommentPhotoComment];
        }
    }
    UITapGestureRecognizer *sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveScreenWithDetailingPhoto:)];
    [detailPhotoModel._imageViewDetail addGestureRecognizer:sigleTap];

    scrollViewAllDetail.contentSize = CGSizeMake(indexOriginX+widthScreen, heightScreen-50);
    
    RELEASE_OBJECT(detailPhotoModel);
}
-(void)loadDataWithCommentingPhoto:(UIScrollView *)aScrollView  dictionaryComment:(NSDictionary *) aDictionaryComment {
    float indexFrameYView = 10;
    NSMutableArray *mutableArrayComment = [aDictionaryComment mutableCopy];
    for (NSDictionary *dictionaryItem in mutableArrayComment) {
        NSString *stringUserCommentName = [dictionaryItem objectForKey:@"authorname"];
        NSString *stringUserCommentIconfarm = [dictionaryItem objectForKey:@"iconfarm"];
        NSString *stringUserCommentIconserver = [dictionaryItem objectForKey:@"iconserver"];
        NSString *stringUserCommentId = [dictionaryItem objectForKey:@"author"];
        NSString *stringTextComment = [dictionaryItem objectForKey:@"text"];
        NSString *stringUrlIConUserComment = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",stringUserCommentIconfarm,stringUserCommentIconserver,stringUserCommentId];
        NSInteger length = [[stringTextComment componentsSeparatedByCharactersInSet:
                             [NSCharacterSet newlineCharacterSet]] count];
        int indexLine = length;
        float indexFrameYComment = indexLine*13;
        
        CommentPhotoModel *modelComment = [[CommentPhotoModel alloc] init];
        modelComment._viewItemComment.frame = CGRectMake(0, indexFrameYView, widthScreen, 40*indexFrameYComment);
        [aScrollView addSubview:modelComment._viewItemComment];
        modelComment._labelBodyComment.frame = CGRectMake(35, 20, 270, indexFrameYComment);
        
        //load data comment
        modelComment._labelNameUserComment.text = stringUserCommentName;
        modelComment._labelBodyComment.text = stringTextComment;
        [modelComment._imageViewAvatarComment setImageWithURL:[NSURL URLWithString:stringUrlIConUserComment]];
        RELEASE_OBJECT(modelComment);
        indexFrameYView = indexFrameYView + (40+indexFrameYComment);
    }
    aScrollView.contentSize = CGSizeMake(307, indexFrameYView+100);
    
}
-(NSDictionary *)getCommentsPhotoById:(NSString *)aPhotoId {
    
    NSString *require = [[NSString alloc] initWithString:[NSString stringWithFormat:@"method=flickr.photos.comments.getList&api_key=%@&photo_id=%@",PF_API_KEY,aPhotoId]];
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
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (sender == scrollViewAllDetail) {
        int pageNum = (int)(scrollViewAllDetail.contentOffset.x / scrollViewAllDetail.frame.size.width);
        indexScrollPage = pageNum;
        
        SearchModel *modelSearch  = [mutableArrayDetailPhoto objectAtIndex:pageNum];
        labelTitleImage.text = modelSearch._stringTitlePhoto;
        
        if (indexPageLoader == pageNum) {
            indexPageLoader = pageNum+1;
            NSString *stringIndexPage = [NSString stringWithFormat:@"%i",indexPageLoader];
            [self performSelectorInBackground:@selector(loadScrollWithNextingPage:) withObject:stringIndexPage];
           
        }
    }
}
-(void)loadScrollWithNextingPage:(NSString *)indexPage {
    int pageNum = [indexPage intValue];
        if (pageNum < mutableArrayDetailPhoto.count) {
            float indexOriginX = (pageNum*widthScreen);
            SearchModel *modelSearch  = [mutableArrayDetailPhoto objectAtIndex:pageNum];
            [self loadDetailWithPhoto:modelSearch OriginX:indexOriginX];
    }
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
