//
//  MacroSandbox.h
//
//  Created by HungVH Vinicorp on 11/04/28.
//  Copyright 2011 . All rights reserved.
//
/*------------------------------------*
 *     SANDBOX & BUNDLE INTERACTIVE   |
 *------------------------------------*/

//#define URLServer @"http://gift2u.net/"

#define PF_URL_SERVER @"http://api.flickr.com/services/rest/?"
#define PF_API_KEY @"ffc99c6a7e321129c0a0864a40a31dd8"

/*----------------------------------------------------------------------*
 *              Load file from bundle                                   |
 *----------------------------------------------------------------------*/
#define LOAD_FILE_BUNDLE(file) \
[[NSBundle mainBundle] pathForResource:file ofType:nil]

/*----------------------------------------------------------------------*
 *             Load image from bundle                                   |
 *----------------------------------------------------------------------*/
#define IMAGE_BUNDLE(file) \
[UIImage imageNamed:file]
/*----------------------------------------------------------------------*
 *             Load NSURL from bundle                                   |
 *----------------------------------------------------------------------*/
#define URL_BUNDLE(file) \
[NSURL fileURLWithPath:LOAD_FILE_BUNDLE(file)]



/*----------------------------------------------------------------------*
 *              Load file from caches directory                         |
 *----------------------------------------------------------------------*/
#define LOAD_FILE_CACHES(folder,file) \
[NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],folder,file]
/*----------------------------------------------------------------------*
 *              Load image from caches directory                        |
 *----------------------------------------------------------------------*/
#define IMAGE_CACHES(folder,file) \
[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],folder,file]]
/*----------------------------------------------------------------------*
 *             Load NSURL from caches                                   |
 *----------------------------------------------------------------------*/
#define URL_CACHES(folder,file) \
[NSURL fileURLWithPath:LOAD_FILE_CACHES(folder,file)]


/*----------------------------------------------------------------------*
 *             Load Resource from documents directory                   |
 *----------------------------------------------------------------------*/
#define IMAGE_DOCUMENTS(folder,file) \
[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],folder,file]]

#define LOAD_FILE_DOCUMENTS(folder,file) \
[NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],folder,file]

#define URL_DOCUMENTS(folder,file) \
[NSURL fileURLWithPath:LOAD_FILE_DOCUMENTS(folder,file)]



/*------------------------------------------------------------------------------------------------------------------------------------*
 |   eg:                                                                                                                              |
 |  [imageview setImage:IMAGE_BUNDLE(@"image.png")];                                                                                  |
 |  [imageview setImage:IMAGE_SANDBOX(@"Ame",@"image.png")];                                                                          |
 |  [button setImage:IMAGE_SANDBOX(@"Ame",@"image.png") forState:UIControlStateNormal];                                               |
 |                                                                                                                                    |
 |  bgMusic = [[GBMusicTrack alloc] initWithPath:LOAD_FILE_BUNDLE(@"bg.mp3")];                                                        |
 |  bgMusic = [[GBMusicTrack alloc] initWithPath:LOAD_FILE_SANDBOX(@"Ame", @"bg.mp3")];                                               |
 |                                                                                                                                    |
 |  moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:URL_SANDBOX(@"Ame", @"1.m4v")];                                |
 |  moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:URL_BUNDLE(@"1.m4v")];                                         |
 |                                                                                                                                    |
 |                                                                                                                                    |
 |  effectsound = [[CMOpenALSoundManager alloc]init];                                                                                 |
 |  effectsound.soundFileNames = [NSArray arrayWithObjects:LOAD_FILE_SANDBOX(@"Ame",@"ef.mp3"), nil];                                 |
 |  [effectsound playSoundWithID:0];                                                                                                  |
 |                                                                                                                                    |
 |                                                                                                                                    |
 *------------------------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------*
 *             Memory management by DatNM 10/1/2012                     |
 *             tested OK on all objects such as: UIImageView, UIButton, |
 *             NSArray, NSMutableArray, NSDictionary.                   |
 *----------------------------------------------------------------------*/
/*----------------------------------------------------------------------*
 *                        RELEASE OBJECTS                               |
 *----------------------------------------------------------------------*/
#define RELEASE_SAFELY(_pointer) \
if(_pointer)[_pointer release]; _pointer = nil;

#define RELEASE_OBJECT(_object) \
[_object release];  _object = nil;
/*----------------------------------------------------------------------*
 *                        CLEAN IMAGE IN OBJECTS                        |
 *----------------------------------------------------------------------*/
#define CLEAN_UIIMAGEVIEW(_imgView) \
_imgView.image = nil;
/*----------------------------------------------------------------------*
 *                        CLEAN OBJECTS                                 |
 *----------------------------------------------------------------------*/
#define CLEAN_OBJECT(_object) \
_object = nil;


