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

@implementation AutoLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    NSString *userName = [[AppManager sharedAppManager] retrieveSavedUserName];
    NSString *passWord = [[AppManager sharedAppManager] retrieveSavedPassword];
        
    NSLog(@"Retrieved userName %@ & PAssword is %@", userName, passWord);
    [self getGoogleContacts:1000 userName:userName passWord:passWord];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
