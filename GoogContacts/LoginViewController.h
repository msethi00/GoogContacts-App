//
//  ViewController.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-05-30.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDataFeedContact.h"
#import "GDataContacts.h"
#import "MSUIViewController.h"

@class GoogContactsModel;

@interface LoginViewController : MSUIViewController  <UITextFieldDelegate> {
    
    GoogContactsModel *googContactsModel;
}


@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

- (IBAction)submitButton:(id)sender;

@end
