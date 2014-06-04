//
//  AppManager.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-03.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "AppManager.h"
#import "AppConfig.h"

@implementation AppManager

@synthesize appSettings, savedGoogleContacts;

static AppManager* sharedAppManager = nil;

+(AppManager*) sharedAppManager
{
	if (sharedAppManager == nil) {
        sharedAppManager = [[super alloc] initAppManager];
    }
    
    return sharedAppManager;
}

-(id) initAppManager
{
    if( (self=[super init]))
    {
        
    NSLog(@"INIT APPMANAGER");
    }
    
    return self;
}

-(void) defaultGoogleContacts
{
    savedGoogleContacts = [[NSMutableArray alloc] init];
}

-(void) defaultAppSettings
{
    NSLog(@"SETTING DEFAULT SETTINGS");
    appSettings = [[NSMutableDictionary alloc] initWithCapacity:4];
    [appSettings setObject:@"NO" forKey:kContactListDownloaded];
    
}

-(void) setContactListDownloaded
{
    [appSettings setObject:@"YES" forKey:kContactListDownloaded];
}

-(BOOL) contactListDownloaded
{
    BOOL listDownloaded = NO;
    if ([[appSettings objectForKey:kContactListDownloaded] isEqualToString:@"YES"])
    {
        listDownloaded = YES;
    }
    
    return listDownloaded;
}

-(void) saveUserNamePassword:(NSString*)userName passWord:(NSString*)passWord
{
    [appSettings setObject:userName forKey:kSavedUserName];
    [appSettings setObject:passWord forKey:kSavedPassWord];
}

-(NSString*) retrieveSavedUserName
{
    return [appSettings objectForKey:kSavedUserName];
}

-(NSString*) retrieveSavedPassword
{
    return [appSettings objectForKey:kSavedPassWord];
}

-(void) loadSavedData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path;
    
    path = [documentsDirectory stringByAppendingPathComponent:@"savedGoogleContacts.plist"];
    if ([fileManager fileExistsAtPath:path]) {
        savedGoogleContacts = [[NSMutableArray alloc] initWithContentsOfFile:path];
    } else {
        [self defaultGoogleContacts];
    }
    
    path = [documentsDirectory stringByAppendingPathComponent:@"appSettings.plist"];
    if ([fileManager fileExistsAtPath:path]) {
        appSettings = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    } else {
        [self defaultAppSettings];
    }
}



-(void) saveAllData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableDictionary *savedObjList = [[NSMutableDictionary alloc] init];
    
    [savedObjList setValue:savedGoogleContacts forKey:@"savedGoogleContacts"];
    [savedObjList setValue:appSettings forKey:@"appSettings"];

    for (NSString* key in savedObjList) {
        
        NSMutableString *fileName = [[NSMutableString alloc] initWithString:key];
        
        [fileName appendString:@".plist"];
        
        NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createFileAtPath:path contents:nil attributes:nil];
        }
        
        [[savedObjList valueForKey:key] writeToFile:path atomically:YES];
    }
}

@end
