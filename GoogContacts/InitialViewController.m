//
//  InitialViewController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "InitialViewController.h"
#import "AppManager.h"
#import "AppConfig.h"
#import "LoginViewController.h"
#import "AutoLoginViewController.h"

@implementation InitialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   if ([[AppManager sharedAppManager] contactListDownloaded] == YES)
   {
       NSLog(@"Contact List Previously Downloaded");
       UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
       AutoLoginViewController *loginController = [storyboard instantiateViewControllerWithIdentifier:@"AutoLogin"];
       [self.navigationController pushViewController:loginController animated:YES];

   } else {
       
       NSLog(@"Contact List Not Previously Downloaded");
       UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
       LoginViewController *loginController = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
       [self.navigationController pushViewController:loginController animated:YES];

   }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
