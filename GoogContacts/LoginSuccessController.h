//
//  LoginSuccessController.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-02.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginSuccessController : UITableViewController
{
    NSMutableArray *googleContactsArray;
}

@property (nonatomic,strong) NSMutableArray *googleContactsArray;

@end
