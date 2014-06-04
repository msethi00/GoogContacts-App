//
//  DetailViewController.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-02.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController
{
    NSMutableDictionary *contact;
}

/////CONTACT INFORMATION
@property (nonatomic, strong) NSMutableDictionary *contact;

/////DETAIL VIEW LABELS
@property (nonatomic, retain) IBOutlet UILabel *contactNameLabel, *contactEmailLabel, *contactPhoneLabel;


@end
