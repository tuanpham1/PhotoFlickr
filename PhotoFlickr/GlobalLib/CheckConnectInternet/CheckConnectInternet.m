//
//  CheckConnectInternet.m
//  PhotoFlickr
//
//  Created by cncsoft on 6/17/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "CheckConnectInternet.h"
#import "Reachability.h"

@implementation CheckConnectInternet
-(id)init {

    self = [super init];
    if (self) {
        
    }
    return self;
}
-(BOOL)isConnectInternet {
    
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

@end
