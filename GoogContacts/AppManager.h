//
//  AppManager.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject
{
    NSMutableArray* savedGoogleContacts;
    NSMutableDictionary* appSettings;
}


+(AppManager*) sharedAppManager;

@property (nonatomic,retain) NSMutableArray* savedGoogleContacts;
@property (nonatomic,retain) NSMutableDictionary* appSettings;


-(void) loadSavedData;
-(void) saveAllData;

-(void) setContactListDownloaded;
-(BOOL) contactListDownloaded;

-(void) saveUserNamePassword:(NSString*)userName passWord:(NSString*)passWord;
-(NSString*) retrieveSavedUserName;
-(NSString*) retrieveSavedPassword;



@end
