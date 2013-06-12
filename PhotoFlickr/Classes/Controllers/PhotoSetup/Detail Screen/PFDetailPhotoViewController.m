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
    
    indexScrollPage = 0;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-searchBar.png"]];
    //get info user(username, location, url Image)
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundImage:[UIImage imageNamed:@"bg-BackButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backScreenSearch:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 16, 51, 31);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    RELEASE_OBJECT(barButtonItem);
    labelTitleImage = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 250, 30)];
    labelTitleImage.font = [UIFont systemFontOfSize:14];
    labelTitleImage.backgroundColor = [UIColor clearColor];
    labelTitleImage.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:labelTitleImage];
    scrollViewAllDetail.contentSize = CGSizeMake(320*mutableArrayDetailPhoto.count, 448);
    scrollViewAllDetail.pagingEnabled = YES;
    scrollViewAllDetail.scrollEnabled = YES;
    NSDictionary *dictionaryDetailItemTitle  = [mutableArrayDetailPhoto objectAtIndex:0];
    NSString *stringTitlePhoto = [dictionaryDetailItemTitle objectForKey:@"title"];
    labelTitleImage.text = stringTitlePhoto;
    NSDictionary *dictionaryDetailItem  = [mutableArrayDetailPhoto objectAtIndex:0];
    [self loadDetailPhoto:dictionaryDetailItem indexOriginX:0];
    double delayInSeconds = .5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
        for (int i = 1; i < mutableArrayDetailPhoto.count; i++) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^ {
            float indexOriginX = (i*320);
                NSLog(@"I:%i -- Array:%i",i,mutableArrayDetailPhoto.count);
            NSDictionary *dictionaryDetailItem  = [mutableArrayDetailPhoto objectAtIndex:i];
            [self loadDetailPhoto:dictionaryDetailItem indexOriginX:indexOriginX];
            });
            dispatch_release(queue);
        }
    });
    
}
-(IBAction)backScreenSearch:(id)sender{
    labelTitleImage.hidden = YES;
    UIButton *buttonBack = (UIButton *)sender;
    buttonBack.frame = CGRectMake(0, 0, 0, 0);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangerNavigationBar" object:nil];
}
-(IBAction)ClickImageDetail:(id)sender {

    //labelTitleImage.text = @"Detail Images";
    NSDictionary *dictionaryPhotoItem = [mutableArrayDetailPhoto objectAtIndex:indexScrollPage];
    NSString *stringUrlPhoto1024 = [dictionaryPhotoItem objectForKey:@"photosize1024"];
    PFImageDetailViewController *imageDetailViewController = [[PFImageDetailViewController alloc] initWithNibName:@"PFImageDetailViewController" aNameImage:stringUrlPhoto1024];
    [self.navigationController pushViewController:imageDetailViewController animated:YES];
    
    RELEASE_OBJECT(imageDetailViewController);

}
-(void)loadDetailPhoto:(NSDictionary *)aDictionaryPhoto indexOriginX:(float)originX {
    //Scroll Screen Item
    UIScrollView *scrollViewScreenDetailItem = [[UIScrollView alloc] initWithFrame:CGRectMake(originX, 30, 320, 548)];
    scrollViewScreenDetailItem.contentSize = CGSizeMake(320, 700);
    [scrollViewScreenDetailItem setUserInteractionEnabled:YES];
    [scrollViewAllDetail addSubview:scrollViewScreenDetailItem];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    scrollViewScreenDetailItem.contentInset = contentInsets;
    //Scroll Comment
    UIScrollView *scrollViewComment = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 390, 307, 149)];
    [scrollViewScreenDetailItem addSubview:scrollViewComment];
    
    //Images Avatar User
    UIImageView *imageViewAvatarUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 50, 50)];
    [scrollViewScreenDetailItem addSubview:imageViewAvatarUser];
    
    //Images Detail
    UIImageView *imageViewDetail = [[UIImageView alloc] initWithFrame:CGRectMake(40, 87, 240, 240)];
    [imageViewDetail setUserInteractionEnabled:YES];
    [scrollViewScreenDetailItem addSubview:imageViewDetail];
    
    //Label User Name
    UILabel *labelNameUser = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 149, 15)];
    labelNameUser.font = [UIFont systemFontOfSize:12];
    labelNameUser.backgroundColor = [UIColor clearColor];
    labelNameUser.textColor = [UIColor blackColor];
    [scrollViewScreenDetailItem addSubview:labelNameUser];
    
    //Label user Name True
    UILabel *labelNameUserTrue = [[UILabel alloc] initWithFrame:CGRectMake(63, 25, 149, 15)];
    labelNameUserTrue.font = [UIFont systemFontOfSize:10];
    labelNameUserTrue.backgroundColor = [UIColor clearColor];
    labelNameUserTrue.textColor = [UIColor darkGrayColor];
    [scrollViewScreenDetailItem addSubview:labelNameUserTrue];
    
    //Label Location User
    UILabel *labelLocationUser = [[UILabel alloc] initWithFrame:CGRectMake(63, 43, 149, 15)];
    labelLocationUser.font = [UIFont systemFontOfSize:10];
    labelLocationUser.backgroundColor = [UIColor clearColor];
    labelLocationUser.textColor = [UIColor darkGrayColor];
    [scrollViewScreenDetailItem addSubview:labelLocationUser];
    
    //label Date Upload
    UILabel *labelDateUpload = [[UILabel alloc] initWithFrame:CGRectMake(218, 8, 98, 15)];
    labelDateUpload.font = [UIFont systemFontOfSize:10];
    labelDateUpload.backgroundColor = [UIColor clearColor];
    labelDateUpload.textColor = [UIColor darkGrayColor];
    [scrollViewScreenDetailItem addSubview:labelDateUpload];
    
    //label View Count
    UILabel *labelViewCount = [[UILabel alloc] initWithFrame:CGRectMake(238, 25, 98, 15)];
    labelViewCount.font = [UIFont systemFontOfSize:10];
    labelViewCount.backgroundColor = [UIColor clearColor];
    labelViewCount.textColor = [UIColor darkGrayColor];
    [scrollViewScreenDetailItem addSubview:labelViewCount];
    
    //Text View Description
    NSString *stringDescriptionPhoto = [aDictionaryPhoto objectForKey:@"description"];
    //NSInteger length = [[stringDescriptionPhoto componentsSeparatedByCharactersInSet:
                         //[NSCharacterSet newlineCharacterSet]] count];
    
    int indexLine = ceilf(stringDescriptionPhoto.length/46.0);
    UIScrollView *scrollViewDescription = [[UIScrollView alloc] initWithFrame:CGRectMake(17, 333, 283, 60)];
    [scrollViewScreenDetailItem addSubview:scrollViewDescription];
    scrollViewDescription.contentSize = CGSizeMake(263, indexLine*13);
    //Label title comment
    UILabel *labelTitleDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 283,indexLine*13)];
    labelTitleDescription.font = [UIFont systemFontOfSize:12];
    labelTitleDescription.backgroundColor = [UIColor clearColor];
    labelTitleDescription.textColor = [UIColor darkGrayColor];
    [labelTitleDescription setTextAlignment:NSTextAlignmentLeft];
    labelTitleDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollViewDescription addSubview:labelTitleDescription];
    
    //Label title comment
    UILabel *labelTitleComment = [[UILabel alloc] initWithFrame:CGRectMake(14, 359, 292, 21)];
    labelTitleComment.font = [UIFont systemFontOfSize:12];
    labelTitleComment.backgroundColor = [UIColor clearColor];
    labelTitleComment.textColor = [UIColor darkGrayColor];
    [scrollViewScreenDetailItem addSubview:labelTitleComment];
    
    
    NSString *stringPhotoId = [aDictionaryPhoto objectForKey:@"photoId"];
    NSString *stringUrlIconUser = [aDictionaryPhoto objectForKey:@"urlicon"];
    NSString *stringNameUser = [aDictionaryPhoto objectForKey:@"username"];
    NSString *stringRealNameUser = [aDictionaryPhoto objectForKey:@"realname"];
    NSString *stringLocationUser = [aDictionaryPhoto objectForKey:@"loacation"];
    NSString *stringDatePhotoUpload = [aDictionaryPhoto objectForKey:@"dateupload"];
    NSString *stringViewCountPhoto = [NSString stringWithFormat:@"Views: %@",[aDictionaryPhoto objectForKey:@"viewCount"]] ;
    NSString *stringUrlPhoto = [aDictionaryPhoto objectForKey:@"photosize240"];
    
    //Data Detail Photo
    [imageViewAvatarUser setImageWithURL:[NSURL URLWithString:stringUrlIconUser]];
    [imageViewDetail setImageWithURL:[NSURL URLWithString:stringUrlPhoto]];
    labelNameUser.text = stringNameUser;
    labelNameUserTrue.text = stringRealNameUser;
    labelLocationUser.text = stringLocationUser;
    labelDateUpload.text = stringDatePhotoUpload;
    labelViewCount.text = stringViewCountPhoto;
    labelTitleDescription.text = stringDescriptionPhoto;
    //textViewDescription.frame = CGRectMake(15, 335, 290, 50);
    labelTitleComment.frame = CGRectMake(5, 395, 290, 20);
    NSMutableArray *mutableArrayComment = [[NSMutableArray alloc] init];
    
    //Get data Comment
    NSDictionary *dictionaryCommentPhoto = [self GetInfoCommentsPhoto:stringPhotoId];
    NSDictionary *dictionaryCommentPhotoRsp = [dictionaryCommentPhoto objectForKey:@"rsp"];
    NSDictionary *dictionaryCommentPhotoComments = [dictionaryCommentPhotoRsp objectForKey:@"comments"];
    if (dictionaryCommentPhotoComments.count == 3) {
        NSDictionary *dictionaryCommentPhotoComment = [dictionaryCommentPhotoComments objectForKey:@"comment"];
        for (NSDictionary *dictionaryCommentItem in dictionaryCommentPhotoComment) {
            [mutableArrayComment addObject:dictionaryCommentItem];
        }
    }
    labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",[mutableArrayComment count]];
    if (mutableArrayComment.count > 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^ {
            [self loadDataComment:scrollViewComment aMutableArray:mutableArrayComment];
        });
        dispatch_release(queue);
    }
    UITapGestureRecognizer *sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickImageDetail:)];
    [imageViewDetail addGestureRecognizer:sigleTap];
    
    RELEASE_OBJECT(scrollViewScreenDetailItem);
    RELEASE_OBJECT(scrollViewComment);
    RELEASE_OBJECT(imageViewAvatarUser);
    RELEASE_OBJECT(imageViewDetail);
    RELEASE_OBJECT(labelNameUser);
    RELEASE_OBJECT(labelNameUserTrue);
    RELEASE_OBJECT(labelLocationUser);
    RELEASE_OBJECT(labelDateUpload);
    RELEASE_OBJECT(labelViewCount);
    RELEASE_OBJECT(labelTitleDescription);
    RELEASE_OBJECT(labelTitleComment);
    RELEASE_OBJECT(mutableArrayComment);
}
-(void)loadDataComment:(UIScrollView *)aScrollView  aMutableArray:(NSMutableArray *) mutableArrayComment{
    float indexFrameYView = 10;
    aScrollView.frame = CGRectMake(5, 420, 307, 199);
    for (int i = 0; i < mutableArrayComment.count; i++) {
        NSDictionary *dictionaryItemComment = [mutableArrayComment objectAtIndex:i];
        
        NSString *stringUserCommentName = [dictionaryItemComment objectForKey:@"authorname"];
        NSString *stringUserCommentIconfarm = [dictionaryItemComment objectForKey:@"iconfarm"];
        NSString *stringUserCommentIconserver = [dictionaryItemComment objectForKey:@"iconserver"];
        NSString *stringUserCommentId = [dictionaryItemComment objectForKey:@"author"];
        NSString *stringTextComment = [dictionaryItemComment objectForKey:@"text"];
        
        NSString *stringUrlIConUserComment = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",stringUserCommentIconfarm,stringUserCommentIconserver,stringUserCommentId];
        
        NSInteger length = [[stringTextComment componentsSeparatedByCharactersInSet:
                             [NSCharacterSet newlineCharacterSet]] count];
        
        int indexLine = length;
        //ceilf(stringTextComment.length/46.0);
        float indexFrameYComment = indexLine*13;
        UIView *viewItemComment = [[UIView alloc] initWithFrame:CGRectMake(0, indexFrameYView, 320, 40*indexFrameYComment)];
        [aScrollView addSubview:viewItemComment];
        UIImageView *imageViewAvatarComment = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imageViewAvatarComment setImageWithURL:[NSURL URLWithString:stringUrlIConUserComment]];
        [viewItemComment addSubview:imageViewAvatarComment];
        UILabel *labelNameUserComment = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 250, 13)];
        labelNameUserComment.font = [UIFont systemFontOfSize:13];
        labelNameUserComment.textColor = [UIColor blueColor];
        labelNameUserComment.backgroundColor = [UIColor clearColor];
        labelNameUserComment.text = stringUserCommentName;
        [viewItemComment addSubview:labelNameUserComment];
        
        
        UILabel *labelBodyComment = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 270, indexFrameYComment)];
        labelBodyComment.font = [UIFont systemFontOfSize:11];
        [labelBodyComment setTextAlignment:NSTextAlignmentLeft];
        labelBodyComment.lineBreakMode = NSLineBreakByWordWrapping;
        labelBodyComment.numberOfLines = 0;
        labelBodyComment.textColor = [UIColor darkGrayColor];
        labelBodyComment.backgroundColor = [UIColor clearColor];
        labelBodyComment.text = stringTextComment;
        [viewItemComment addSubview:labelBodyComment];
        
        indexFrameYView = indexFrameYView + (40+indexFrameYComment);
        
        
        RELEASE_OBJECT(viewItemComment);
        RELEASE_OBJECT(imageViewAvatarComment);
        RELEASE_OBJECT(labelNameUserComment);
        RELEASE_OBJECT(labelBodyComment);
    }
    aScrollView.layer.borderWidth = 1.0;
    aScrollView.layer.borderColor = [[UIColor grayColor] CGColor];
    aScrollView.contentSize = CGSizeMake(307, indexFrameYView+100);
    
}
-(NSDictionary *)GetInfoCommentsPhoto:(NSString *)aPhotoId {
    
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
        NSDictionary *dictionaryDetailItemTitle  = [mutableArrayDetailPhoto objectAtIndex:pageNum];
        NSString *stringTitlePhoto = [dictionaryDetailItemTitle objectForKey:@"title"];
        labelTitleImage.text = stringTitlePhoto;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
