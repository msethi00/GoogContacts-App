//
//  ViewController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-05-30.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginSuccessController.h"
#import "AppConfig.h"
#import "Reachability.h"
#import "AppManager.h"

@interface LoginViewController ()


@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


/////SUBMIT BUTTON
- (IBAction)submitButton:(id)sender {
    if ([[self.userNameInput text] isEqual:@""] || [[self.passwordInput text] isEqual:@""]) {
        NSLog(@"Username and Password is Required.");
     
        [self createAlertView:self alertViewTitle:@"Error!" alertViewMsg:@"Username and Password" delegate:self alertViewCancelButtonTitle:@"OK"];
    } else if ([self checkNetworkStatus] == NotReachable)
    {
        [self createAlertView:self alertViewTitle:@"Error!" alertViewMsg:@"No Internet Connection" delegate:self alertViewCancelButtonTitle:@"OK"];
    } else {
        NSLog(@"Get Google Contacts");
        NSString *userName = [self.userNameInput text];
        NSString *passWord = [self.passwordInput text];
        
        NSLog(@"UserNAme was %@ PAssWas %@", userName, passWord);
        
        [self getGoogleContacts:1000 userName:userName passWord:passWord];
    }
}










@end
