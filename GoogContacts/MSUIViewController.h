//
//  MSUIViewController.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reachability.h"


@interface MSUIViewController : UIViewController {
    
}


/////ADD A NOTIF OBSERVER
-(void) addNotifObserver:(NSString*)notif target:(id)target selector:(SEL)selector object:(id)object;
-(void) removeObservers;

/////GENERIC CREATE ALERTVIEW METHOD
- (UIAlertView*)createAlertView:(id)sender alertViewTitle:(NSString*)alertViewTitle alertViewMsg:(NSString*)alertViewMsg delegate:(id)delegate alertViewCancelButtonTitle:(NSString*)alertViewCancelButtonTitle;
/////NETWORK STATUS
-(NetworkStatus) checkNetworkStatus;



@end
