//
//  PFSearchPhotoService.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "PFSearchPhotoService.h"
#import "MacroSandbox.h"
#import "XMLReader.h"
#import "PFSearchModel.h"

@implementation PFSearchPhotoService

-(id)init {

    self = [super init];
    if (self) {
        
    }
    return self;
}
// search photo with key search
-(NSDictionary *)searchPhotosWithTextingKey:(NSString *)aKeySearch {
    
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
// Get info photo with photoID
-(NSDictionary *)getInfomationPhotoById:(NSString *)aPhotoID secretPhoto:(NSString *)aSecretPhoto {
    
    NSString *require = [[NSString alloc] initWithString:[NSString stringWithFormat:@"method=flickr.photos.getInfo&api_key=%@&photo_id=%@&secret=%@",PF_API_KEY,aPhotoID,aSecretPhoto]];
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

// get comment photo
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
    NSDictionary *dictionaryCommentPhotoRsp = [xmlDictionary objectForKey:@"rsp"];
    NSDictionary *dictionaryCommentPhotoComments = [dictionaryCommentPhotoRsp objectForKey:@"comments"];
    RELEASE_OBJECT(require);
    RELEASE_OBJECT(request);
    return dictionaryCommentPhotoComments;
    
}

@end
