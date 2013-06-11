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

- (id)initWithNibName:(NSString *)nibNameOrNil aDictionaryItem:(NSDictionary *)dictionaryItem
{
    dictionaryDataItem = dictionaryItem;
    return self;
}
-(void)dealloc {

    RELEASE_OBJECT(activityIndicatorLoadingComment);
    RELEASE_OBJECT(imageViewAvatarUser);
    RELEASE_OBJECT(imageViewDetail);
    RELEASE_OBJECT(labelNameUser);
    RELEASE_OBJECT(labelNameUserTrue);
    RELEASE_OBJECT(labelLocationUser);
    RELEASE_OBJECT(labelDateUpload);
    RELEASE_OBJECT(labelViewCount);
    RELEASE_OBJECT(textViewDescription);
    RELEASE_OBJECT(labelTitleComment);
    RELEASE_OBJECT(scrollViewComment);
    RELEASE_OBJECT(scrollViewScreenComent);
    RELEASE_OBJECT(mutableArrayComment);
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollViewScreenComent.frame = CGRectMake(0, 50, 320, 490);
    scrollViewScreenComent.contentSize = CGSizeMake(320, 700);
    [scrollViewScreenComent setUserInteractionEnabled:YES];
    [imageViewDetail setUserInteractionEnabled:YES];
    
    labelNameUser.font = [UIFont systemFontOfSize:12];
    labelNameUserTrue.font = [UIFont systemFontOfSize:12];
    labelLocationUser.font = [UIFont systemFontOfSize:12];
    labelDateUpload.font = [UIFont systemFontOfSize:10];
    labelViewCount.font = [UIFont systemFontOfSize:10];
    textViewDescription.font = [UIFont systemFontOfSize:13];
    labelTitleComment.font = [UIFont systemFontOfSize:12];
    
    //get info user(username, location, url Image)
    NSString *stringUrlIconUser = [dictionaryDataItem objectForKey:@"urlicon"];
    NSString *stringNameUser = [dictionaryDataItem objectForKey:@"username"];
    NSString *stringRealNameUser = [dictionaryDataItem objectForKey:@"realname"];
    NSString *stringLocationUser = [dictionaryDataItem objectForKey:@"loacation"];
    NSString *stringDatePhotoUpload = [dictionaryDataItem objectForKey:@"dateupload"];
    NSString *stringViewCountPhoto = [NSString stringWithFormat:@"Views: %@",[dictionaryDataItem objectForKey:@"viewCount"]] ;
    NSString *stringUrlPhoto = [dictionaryDataItem objectForKey:@"photosize240"];
    NSString *stringTitlePhoto = [dictionaryDataItem objectForKey:@"title"];
    NSString *stringDescriptionPhoto = [dictionaryDataItem objectForKey:@"description"];
   // NSDictionary *dictionaryComment = [dictionaryDataItem objectForKey:@"tags"];
    
    mutableArrayComment = [[NSMutableArray alloc] init];
    for (id keyDictionary in dictionaryDataItem) {
        NSString *stringKey = keyDictionary;
        if ([stringKey isEqualToString:@"tags"]) {
            NSDictionary *dictionaryComment = [dictionaryDataItem objectForKey:@"tags"];
            for (id keyDictionary1 in dictionaryComment) {
                NSString *stringKey1 = keyDictionary1;
                if ([stringKey1 isEqualToString:@"tag"]) {
                    NSDictionary *dictionaryAllComment = [dictionaryComment objectForKey:@"tag"];
                    if (dictionaryAllComment.count != 5) {
                        for (NSDictionary *dictionaryCommentItem in dictionaryAllComment) {
                            [mutableArrayComment addObject:dictionaryCommentItem];
                            
                        }
                    }
                    
                }
            }
        }
    }
    //Data Comment
    [imageViewAvatarUser setImageWithURL:[NSURL URLWithString:stringUrlIconUser]];
    [imageViewDetail setImageWithURL:[NSURL URLWithString:stringUrlPhoto]];
    labelNameUser.text = stringNameUser;
    labelNameUserTrue.text = stringRealNameUser;
    labelLocationUser.text = stringLocationUser;
    labelDateUpload.text = stringDatePhotoUpload;
    labelViewCount.text = stringViewCountPhoto;
    labelTitleComment.text = [NSString stringWithFormat:@"Comment for this photo: %i comments",[mutableArrayComment count]];
    textViewDescription.text = [NSString stringWithUTF8String:[stringDescriptionPhoto UTF8String]];
    textViewDescription.frame = CGRectMake(15, 335, 290, 50);
    labelTitleComment.frame = CGRectMake(5, 395, 290, 20);
    
    activityIndicatorLoadingComment = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorLoadingComment.frame = CGRectMake(250, 350, 37, 37);
    activityIndicatorLoadingComment.backgroundColor = [UIColor blackColor];
    [activityIndicatorLoadingComment stopAnimating];
    [scrollViewScreenComent addSubview:activityIndicatorLoadingComment];
    
    [self loadDataComment];
    labelTitleImage = [[UILabel alloc] initWithFrame:CGRectMake(48, 7, 250, 30)];
    labelTitleImage.font = [UIFont systemFontOfSize:14];
    labelTitleImage.text = stringTitlePhoto;
    labelTitleImage.backgroundColor = [UIColor clearColor];
    labelTitleImage.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:labelTitleImage];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundImage:[UIImage imageNamed:@"icon-back.jpeg"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backScreenSearch:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 16, 10, 28);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    UITapGestureRecognizer *sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickImageDetail:)];
    [imageViewDetail addGestureRecognizer:sigleTap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (ChangerNavigationDetailScreen:) name:@"ChangerNavigationBarDetailScreen" object:nil];
    [self performSelector:@selector(loadDataComment) withObject:nil afterDelay:0.1];
    
    
    RELEASE_OBJECT(barButtonItem);
}
-(IBAction)backScreenSearch:(id)sender{
    labelTitleImage.hidden = YES;
    UIButton *buttonBack = (UIButton *)sender;
    buttonBack.frame = CGRectMake(0, 0, 0, 0);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangerNavigationBar" object:nil];
}
-(IBAction)ClickImageDetail:(id)sender {

    labelTitleImage.text = @"Detail Images";
    NSString *stringUrlPhoto1024 = [dictionaryDataItem objectForKey:@"photosize1024"];
    PFImageDetailViewController *imageDetailViewController = [[PFImageDetailViewController alloc] initWithNibName:@"PFImageDetailViewController" aNameImage:stringUrlPhoto1024];
    [self.navigationController pushViewController:imageDetailViewController animated:YES];
    
    RELEASE_OBJECT(imageDetailViewController);

}
-(IBAction)ChangerNavigationDetailScreen:(id)sender {

    labelTitleImage.text = @"Images Name";
    
}
-(void)loadDataComment {
    
    [activityIndicatorLoadingComment startAnimating];
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
        [activityIndicatorLoadingComment stopAnimating];
        float indexFrameYView = 10;
        scrollViewComment.frame = CGRectMake(5, 420, 307, 199);
        if (mutableArrayComment.count > 0) {
            for (int i = 0; i < mutableArrayComment.count; i++) {
                NSDictionary *dictionaryItemComment = [mutableArrayComment objectAtIndex:i];
                NSDictionary *dictionaryInfoUserComment = [self GetInfoCommentsPhoto:[dictionaryItemComment objectForKey:@"author"]];
                
                NSDictionary *dictionaryInfoUserCommentRsp = [dictionaryInfoUserComment objectForKey:@"rsp"];
                NSDictionary *dictionaryInfoUserCommentPerson = [dictionaryInfoUserCommentRsp objectForKey:@"person"];
                NSDictionary *dictionaryInfoUserCommentUsername = [dictionaryInfoUserCommentPerson objectForKey:@"username"];
                
                NSString *stringUserCommentIconfarm = [dictionaryInfoUserCommentPerson objectForKey:@"iconfarm"];
                NSString *stringUserCommentIconserver = [dictionaryInfoUserCommentPerson objectForKey:@"iconserver"];
                NSString *stringUserCommentId = [dictionaryInfoUserCommentPerson objectForKey:@"id"];
                
                NSString *stringUserCommentName = [dictionaryInfoUserCommentUsername objectForKey:@"text"];
                NSString *stringTextComment = [dictionaryItemComment objectForKey:@"text"];
                
                NSString *stringUrlIConUserComment = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg",stringUserCommentIconfarm,stringUserCommentIconserver,stringUserCommentId];
                
                NSInteger length = [[stringTextComment componentsSeparatedByCharactersInSet:
                                     [NSCharacterSet newlineCharacterSet]] count];
                
                int indexLine = length;
                //ceilf(stringTextComment.length/46.0);
                float indexFrameYComment = indexLine*13;
                UIView *viewItemComment = [[UIView alloc] initWithFrame:CGRectMake(0, indexFrameYView, 320, 40*indexFrameYComment)];
                [scrollViewComment addSubview:viewItemComment];
                UIImageView *imageViewAvatarComment = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                [imageViewAvatarComment setImageWithURL:[NSURL URLWithString:stringUrlIConUserComment]];
                [viewItemComment addSubview:imageViewAvatarComment];
                UILabel *labelNameUserComment = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 250, 13)];
                labelNameUserComment.font = [UIFont systemFontOfSize:13];
                labelNameUserComment.textColor = [UIColor cyanColor];
                labelNameUserComment.backgroundColor = [UIColor blackColor];
                labelNameUserComment.text = stringUserCommentName;
                [viewItemComment addSubview:labelNameUserComment];
                
                
                UILabel *labelBodyComment = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 270, indexFrameYComment)];
                labelBodyComment.font = [UIFont systemFontOfSize:11];
                [labelBodyComment setTextAlignment:NSTextAlignmentLeft];
                labelBodyComment.lineBreakMode = NSLineBreakByWordWrapping;
                labelBodyComment.numberOfLines = 0;
                labelBodyComment.textColor = [UIColor whiteColor];
                labelBodyComment.backgroundColor = [UIColor blackColor];
                labelBodyComment.text = stringTextComment;
                [viewItemComment addSubview:labelBodyComment];
                
                indexFrameYView = indexFrameYView + (40+indexFrameYComment);
                
                
                RELEASE_OBJECT(viewItemComment);
                RELEASE_OBJECT(imageViewAvatarComment);
                RELEASE_OBJECT(labelNameUserComment);
                RELEASE_OBJECT(labelBodyComment);
            }
        }
        
        scrollViewComment.layer.borderWidth = 1.0;
        scrollViewComment.layer.borderColor = [[UIColor grayColor] CGColor];
        scrollViewComment.contentSize = CGSizeMake(307, indexFrameYView+100);
   });
    
}
-(NSDictionary *)GetInfoCommentsPhoto:(NSString *)aUserId {
    
    NSString *require = [[NSString alloc] initWithString:[NSString stringWithFormat:@"method=flickr.people.getInfo&api_key=%@&user_id=%@",PF_API_KEY,aUserId]];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
