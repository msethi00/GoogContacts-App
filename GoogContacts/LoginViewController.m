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
#import "GoogContactsModel.h"


@interface LoginViewController ()


@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    self.userNameInput.delegate = self;
    self.passwordInput.delegate = self;
    
    googContactsModel = [[GoogContactsModel alloc] init];
 
    [self addSelfObservers];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"TextField Done Editing");
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
        
        [googContactsModel getGoogleContacts:1000 userName:userName passWord:passWord];
        
    }
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
