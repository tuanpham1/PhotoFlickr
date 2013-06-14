//
//  PFImageDetailViewController.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/6/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFImageDetailViewController.h"
#import "MacroSandbox.h"

@interface PFImageDetailViewController ()

@property (nonatomic, strong) UIImageView *imageView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end

@implementation PFImageDetailViewController
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;


- (id)initWithNibName:(NSString *)nibNameOrNil aNameImage:(NSString *)nameImage
{
    stringSaveNameImage = nameImage;
    return self;
}
-(void)dealloc {

    RELEASE_OBJECT(_imageView);
    RELEASE_OBJECT(_scrollView);
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float widthScreen = [UIScreen mainScreen].bounds.size.width;
    float heightScreen = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = CGRectMake(0, 0, widthScreen, heightScreen);
    
    [self.scrollView setUserInteractionEnabled:YES];
    [self.imageView setUserInteractionEnabled:YES];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"bg-BackButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backScreenBegin:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 16, 51, 30);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:stringSaveNameImage]]];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame =
    (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=CGSizeMake(570, 740)};
    [self.scrollView addSubview:self.imageView];

    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = image.size;
    //Zoom images When double tap img
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    //Zoom Images When Scale images
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    RELEASE_OBJECT(barButtonItem);
    RELEASE_OBJECT(doubleTapRecognizer);
    RELEASE_OBJECT(twoFingerTapRecognizer);
}
-(IBAction)backScreenBegin:(id)sender{
    UIButton *buttonBack = (UIButton *)sender;
    buttonBack.frame = CGRectMake(0, 0, 0, 0);
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Zoom Images Function
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SCrollView Zoom images
- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}
@end
