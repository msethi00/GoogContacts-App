//
//  MSUIViewController.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDataFeedContact.h"
#import "GDataContacts.h"
#import "Reachability.h"


@interface MSUIViewController : UIViewController {
    NSMutableArray *googleContactsArray;
    GDataServiceTicket *mContactFetchTicket;

    NSError *mContactFetchError;
    
}

/////GET GOOGLE CONTACTS
-(void)getGoogleContacts:(int)maxResultsSize userName:(NSString*)userName passWord:(NSString*)passWord;
//////GENERIC SORT FUNCTION
-(void) sortArray:(NSMutableArray*)arrayToSort sortKey:(NSString*)sortKey;
/////GENERIC TRANSITION VIEW METHOD
-(void) transitionToViewWithIdentifier:(NSString*)identifier pushScene:(BOOL)pushScene;
/////GENERIC CREATE ALERTVIEW METHOD
- (UIAlertView*)createAlertView:(id)sender alertViewTitle:(NSString*)alertViewTitle alertViewMsg:(NSString*)alertViewMsg delegate:(id)delegate alertViewCancelButtonTitle:(NSString*)alertViewCancelButtonTitle;
/////NETWORK STATUS
-(NetworkStatus) checkNetworkStatus;



@end
