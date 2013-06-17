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
#import "PFSearchPhotoService.h"
#import "PFCommentModel.h"
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
    
    PFSearchModel *modelSearch0  = [mutableArrayDetailPhoto objectAtIndex:0];
    labelTitleImage.text = modelSearch0._stringTitlePhoto;
    [self loadDetailWithPhoto:modelSearch0 OriginX:0];
    indexPageLoader = 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
    float indexOriginX = (1*widthScreen);
        PFSearchModel *modelSearch1  = [mutableArrayDetailPhoto objectAtIndex:1];
        [self loadDetailWithPhoto:modelSearch1 OriginX:indexOriginX];
    });
    dispatch_release(queue);
}

-(IBAction)backScreenBySearch:(id)sender{
    labelTitleImage.hidden = YES;
    UIButton *buttonBack = (UIButton *)sender;
    buttonBack.frame = CGRectMake(0, 0, 0, 0);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PFNavigationBarDidChangerNotification" object:nil];
}
-(IBAction)moveScreenWithDetailingPhoto:(id)sender {

    //labelTitleImage.text = @"Detail Images";
    PFSearchModel *modelSearch = [mutableArrayDetailPhoto objectAtIndex:indexScrollPage];
    NSString *stringUrlPhoto1024 = modelSearch._stringUrlPhotoSize1024;
    
    PFImageDetailViewController *imageDetailViewController = [[PFImageDetailViewController alloc] initWithNibName:@"PFImageDetailViewController" aNameImage:stringUrlPhoto1024];
    [self.navigationController pushViewController:imageDetailViewController animated:YES];
    RELEASE_OBJECT(imageDetailViewController);
}
-(void)loadDetailWithPhoto:(PFSearchModel *)aModelSearch OriginX:(float)indexOriginX {
    
    PFDetailPhotoViewItem *detailPhotoItem = [[PFDetailPhotoViewItem alloc] init];
    detailPhotoItem._scrollViewItem.frame = CGRectMake(indexOriginX, 0, widthScreen, heightScreen-50);
    detailPhotoItem._scrollViewItem.contentSize = CGSizeMake(widthScreen, 650);
    [scrollViewAllDetail addSubview:detailPhotoItem._scrollViewItem];
    
    //Text View Description
    int indexLine = ceilf(aModelSearch._stringDescriptionPhoto.length/46.0);
    detailPhotoItem._scrollViewDescription.contentSize = CGSizeMake(263, indexLine*13);
    detailPhotoItem._labelTitleDescription.frame = CGRectMake(0, 0, 283,indexLine*13);
    
    //Data Detail Photo
    [detailPhotoItem._imageViewAvatarUser setImageWithURL:[NSURL URLWithString:aModelSearch._stringUrlIConUser]];
    [detailPhotoItem._imageViewDetail setImageWithURL:[NSURL URLWithString:aModelSearch._stringUrlPhotoSize240]];
    detailPhotoItem._labelNameUser.text = aModelSearch._stringNameUser;
    detailPhotoItem._labelNameUserTrue.text = aModelSearch._stringRealNameUser;
    detailPhotoItem._labelLocationUser.text = aModelSearch._stringLocationUser;
    detailPhotoItem._labelDateUpload.text = aModelSearch._stringDatePhotoUpload;
    detailPhotoItem._labelViewCount.text = aModelSearch._stringViewCountPhoto;
    detailPhotoItem._labelTitleDescription.text = aModelSearch._stringDescriptionPhoto;
    detailPhotoItem._labelTitleComment.frame = CGRectMake(5, 395, 290, 20);
    
    //Get data Comment
    PFSearchPhotoService *searchPhotoService = [[PFSearchPhotoService alloc] init];
    NSDictionary *dictionaryCommentPhoto = [searchPhotoService getCommentsPhotoById:aModelSearch._stringPhotoID];
    
    detailPhotoItem._labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",0];
    if (dictionaryCommentPhoto.count == 3) {
        
        NSDictionary *dictionaryCommentPhotoComment = [dictionaryCommentPhoto objectForKey:@"comment"];
        if (dictionaryCommentPhotoComment.count != 8 && dictionaryCommentPhotoComment.count > 0) {
            NSMutableArray *mutableArrayCommentPhoto = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionaryItem in dictionaryCommentPhotoComment) {
                PFCommentModel *modelComment = [[PFCommentModel alloc] initWithData:dictionaryItem];
                [mutableArrayCommentPhoto addObject:modelComment];
                RELEASE_OBJECT(modelComment);
            }
            detailPhotoItem._labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",mutableArrayCommentPhoto.count];
            [self loadDataWithCommentingPhoto:detailPhotoItem._scrollViewComment arrayComment:mutableArrayCommentPhoto];
            RELEASE_OBJECT(mutableArrayCommentPhoto);
        }
    }
    UITapGestureRecognizer *sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveScreenWithDetailingPhoto:)];
    [detailPhotoItem._imageViewDetail addGestureRecognizer:sigleTap];

    scrollViewAllDetail.contentSize = CGSizeMake(indexOriginX+widthScreen, heightScreen-50);
    
    RELEASE_OBJECT(detailPhotoItem);
}
-(void)loadDataWithCommentingPhoto:(UIScrollView *)aScrollView  arrayComment:(NSMutableArray *) aArrayComment {
    float indexFrameYView = 10;
    for (PFCommentModel *modelComment in aArrayComment) {
        
        NSInteger length = [[modelComment._stringTextComment componentsSeparatedByCharactersInSet:
                             [NSCharacterSet newlineCharacterSet]] count];
        int indexLine = length;
        float indexFrameYComment = indexLine*13;
        
        PFCommentPhotoViewItem *commentPhotoItem = [[PFCommentPhotoViewItem alloc] init];
        commentPhotoItem._viewItemComment.frame = CGRectMake(0, indexFrameYView, widthScreen, 40*indexFrameYComment);
        [aScrollView addSubview:commentPhotoItem._viewItemComment];
        commentPhotoItem._labelBodyComment.frame = CGRectMake(35, 20, 270, indexFrameYComment);
        
        //load data comment
        commentPhotoItem._labelNameUserComment.text = modelComment._stringUserCommentName;
        commentPhotoItem._labelBodyComment.text = modelComment._stringTextComment;
        [commentPhotoItem._imageViewAvatarComment setImageWithURL:[NSURL URLWithString:modelComment._stringUrlIConUserComment]];
        RELEASE_OBJECT(commentPhotoItem);
        indexFrameYView = indexFrameYView + (40+indexFrameYComment);
    }
    aScrollView.contentSize = CGSizeMake(307, indexFrameYView+100);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (sender == scrollViewAllDetail) {
        int pageNum = (int)(scrollViewAllDetail.contentOffset.x / scrollViewAllDetail.frame.size.width);
        indexScrollPage = pageNum;
        
        PFSearchModel *modelSearch  = [mutableArrayDetailPhoto objectAtIndex:pageNum];
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
            PFSearchModel *modelSearch  = [mutableArrayDetailPhoto objectAtIndex:pageNum];
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
