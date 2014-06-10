//
//  MSUIViewController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "MSUIViewController.h"
#import "AppManager.h"
#import "AppConfig.h"
#import "Reachability.h"
#import "LoginSuccessController.h"

@implementation MSUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //googleContactsArray = [[NSMutableArray alloc] init];
}

-(void) addNotifObserver:(NSString*)notif target:(id)target selector:(SEL)selector object:(id)object
{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:notif object:object];
}
-(void) removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/////GENERIC CREATE ALERTVIEW METHOD
- (UIAlertView*)createAlertView:(id)sender alertViewTitle:(NSString*)alertViewTitle alertViewMsg:(NSString*)alertViewMsg delegate:(id)delegate alertViewCancelButtonTitle:(NSString*)alertViewCancelButtonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle
                                                        message:alertViewMsg
                                                       delegate:delegate
                                              cancelButtonTitle:alertViewCancelButtonTitle
                                              otherButtonTitles:nil, nil];
    [alertView show];
    return alertView;
}

/////NETWORK STATUS
-(NetworkStatus) checkNetworkStatus
{
    /*
     Reachability *reach = [Reachability reachabilityForInternetConnection];
     NetworkStatus netStatus = [reach currentReachabilityStatus];
     */
    Reachability* wifiReach = [Reachability reachabilityWithHostName: @"www.apple.com"];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    return netStatus;
}

-(void) dealloc
{
    NSLog(@"MSUIViewController Dealloc Called");
    [self removeObservers];
}


@end
