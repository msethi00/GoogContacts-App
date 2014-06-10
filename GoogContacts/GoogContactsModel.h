//
//  GoogContactsModel.h
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-10.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataFeedContact.h"
#import "GDataContacts.h"


@interface GoogContactsModel : NSObject
{

    NSMutableArray *googleContactsArray;
    GDataServiceTicket *mContactFetchTicket;
    NSError *mContactFetchError;
    
}

@property (nonatomic,retain) NSMutableArray *googleContactsArray;

-(id) init;
/////GET GOOGLE CONTACTS
-(void)getGoogleContacts:(int)maxResultsSize userName:(NSString*)userName passWord:(NSString*)passWord;
//////GENERIC SORT FUNCTION
-(void) sortArray:(NSMutableArray*)arrayToSort sortKey:(NSString*)sortKey;


@end
