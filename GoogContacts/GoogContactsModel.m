//
//  GoogContactsModel.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-10.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "GoogContactsModel.h"
#import "AppManager.h"
#import "AppConfig.h"

@implementation GoogContactsModel

@synthesize googleContactsArray;

-(id) init
{
    if( (self=[super init]))
    {
        NSLog(@"INIT GOOGLE CONTACTS MODEL");
    }
    
    googleContactsArray = [[NSMutableArray alloc] init];
    
    return self;
}


/////GET GOOGLE CONTACTS
-(void)getGoogleContacts:(int)maxResultsSize userName:(NSString*)userName passWord:(NSString*)passWord
{
    [[AppManager sharedAppManager] saveUserNamePassword:userName passWord:passWord];
    
    GDataServiceGoogleContact *service = [self contactService:userName passWord:passWord];
    GDataServiceTicket *ticket;
    
    BOOL shouldShowDeleted = TRUE;
    
    NSURL *feedURL = [GDataServiceGoogleContact contactFeedURLForUserID:kGDataServiceDefaultUser];
    
    GDataQueryContact *query = [GDataQueryContact contactQueryWithFeedURL:feedURL];
    [query setShouldShowDeleted:shouldShowDeleted];
    [query setMaxResults:maxResultsSize];
    
    ticket = [service fetchFeedWithQuery:query
                                delegate:self
                       didFinishSelector:@selector(contactsFetchTicket:finishedWithFeed:error:)];
    
    [self setContactFetchTicket:ticket];
}


- (void)setContactFetchTicket:(GDataServiceTicket *)ticket
{
    mContactFetchTicket = ticket;
}

- (GDataServiceGoogleContact *)contactService:(NSString*)userName passWord:(NSString*)passWord
{
    static GDataServiceGoogleContact* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleContact alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
    }
    
    [service setUserCredentialsWithUsername:userName
                                   password:passWord];
    
    return service;
}



//////GOOGLE CONTACTS CALLBACK
- (void)contactsFetchTicket:(GDataServiceTicket *)ticket
           finishedWithFeed:(GDataFeedContact *)feed
                      error:(NSError *)error {
    
    if (error) {
        NSDictionary *userInfo = [error userInfo];
        NSLog(@"Contacts Fetch error :%@", [userInfo objectForKey:@"Error"]);
        if ([[userInfo objectForKey:@"Error"] isEqual:@"BadAuthentication"]) {
            
          //  [self createAlertView:self alertViewTitle:@"Error!" alertViewMsg:@"Authentication Failed" delegate:self alertViewCancelButtonTitle:@"OK"];
            
            NSString *errorMsg = [[NSString alloc] init];
            errorMsg = @"Authentication Failed";
            [self postNotif:kNotifGoogleContactsFetchError object:errorMsg];
            
        } else {
            
           // [self createAlertView:self alertViewTitle:@"Error!" alertViewMsg:@"Failed to get Contacts" delegate:self alertViewCancelButtonTitle:@"OK"];
            
            NSString *errorMsg = [[NSString alloc] init];
            errorMsg = @"Failed to get contacts";
            [self postNotif:kNotifGoogleContactsFetchError object:errorMsg];

        }
    } else {
        
        NSArray *contacts = [feed entries];
        NSLog(@"Contacts Count: %d ", [contacts count]);
        [googleContactsArray removeAllObjects];
        for (int i = 0; i < [contacts count]; i++) {
            GDataEntryContact *contact = [contacts objectAtIndex:i];
            
            // Name
            NSString *ContactName = [[[contact name] fullName] contentStringValue];
            NSLog(@"Name    :  %@", ContactName);
            
            // Email
            GDataEmail *email = [[contact emailAddresses] objectAtIndex:0];
            NSString *ContactEmail =  @"";
            if (email && [email address]) {
                ContactEmail = [email address];
                NSLog(@"EmailID :  %@", ContactEmail);
            }
            
            // Phone
            GDataPhoneNumber *phone = [[contact phoneNumbers] objectAtIndex:0];
            NSString *ContactPhone = @"";
            if (phone && [phone contentStringValue]) {
                ContactPhone = [phone contentStringValue];
                NSLog(@"Phone   :  %@", ContactPhone);
            }
            
            // Address
            GDataStructuredPostalAddress *postalAddress = [[contact structuredPostalAddresses] objectAtIndex:0];
            NSString *address = @"";
            if (postalAddress && [postalAddress formattedAddress]) {
                NSLog(@"Formatted Address   :  %@", [postalAddress formattedAddress]);
                address = [postalAddress formattedAddress];
            }
            
            // Birthday
            NSString *dob = @"";
            if ([contact birthday]) {
                dob = [contact birthday];
                NSLog(@"dob   :  %@", dob);
            }
            
            
            if (!ContactName || !(ContactEmail || ContactPhone) ) {
                NSLog(@"Empty Contact Fields. Not Adding.");
            }
            else
            {
                NSArray *keys = [[NSArray alloc] initWithObjects:kContactName, kContactEmail, kContactPhone, kContactAddress, kContactBirthday, nil];
                NSArray *objs = [[NSArray alloc] initWithObjects:ContactName, ContactEmail, ContactPhone, address, dob, nil];
                NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
                
                [googleContactsArray addObject:dict];
            }
        }
        
        ////SORT THE ARRAY
        [self sortArray:googleContactsArray sortKey:kContactName];
        
        ////TELL APPMANGER CONTACT LIST DOWNLOADED ATLEAST ONE
        [[AppManager sharedAppManager] setContactListDownloaded];
        
        
        ////LOGIN SUCCESS SEND NOTIF
        [self postNotif:KNotifGoogleLoginSuccess];
        
    }
    
}

//////GENERIC SORT FUNCTION
-(void) sortArray:(NSMutableArray*)arrayToSort sortKey:(NSString*)sortKey
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [arrayToSort sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
}


-(void) postNotif:(NSString*)notif
{
    [self postNotif:notif object:self];
}

-(void) postNotif:(NSString*)notif object:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notif object:object];
}


@end
