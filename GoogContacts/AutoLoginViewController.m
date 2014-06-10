//
//  AutoLoginViewController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "AutoLoginViewController.h"
#import "AppConfig.h"
#import "AppManager.h"
#import "GoogContactsModel.h"
#import "LoginSuccessController.h"

@implementation AutoLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    NSString *userName = [[AppManager sharedAppManager] retrieveSavedUserName];
    NSString *passWord = [[AppManager sharedAppManager] retrieveSavedPassword];
        
    NSLog(@"Retrieved userName %@ & PAssword is %@", userName, passWord);
    googContactsModel = [[GoogContactsModel alloc] init];
    
    
    [googContactsModel getGoogleContacts:1000 userName:userName passWord:passWord];
   // [self getGoogleContacts:1000 userName:userName passWord:passWord];
    
    [self addSelfObservers];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addSelfObservers
{
    [self removeObservers];
    [self addNotifObserver:kNotifGoogleContactsFetchError target:self selector:@selector(contactsFetchError:) object:nil];
    [self addNotifObserver:KNotifGoogleLoginSuccess target:self selector:@selector(loginSuccess:) object:nil];
}

- (void) contactsFetchError:(NSNotification *) notification
{
    NSString* errorMsg = notification.object;
    [self createAlertView:self alertViewTitle:@"Error!" alertViewMsg:errorMsg delegate:self alertViewCancelButtonTitle:@"OK"];
}


-(void) loginSuccess:(NSNotification *) notification
{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    LoginSuccessController *loginController = [storyboard instantiateViewControllerWithIdentifier:@"LoginSuccess"];
    loginController.googleContactsArray = googContactsModel.googleContactsArray;
    [self.navigationController pushViewController:loginController animated:YES];
    
}


@end
