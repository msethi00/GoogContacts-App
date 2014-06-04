//
//  DetailViewController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-02.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "DetailViewController.h"
#import "AppConfig.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize contact, contactEmailLabel, contactNameLabel, contactPhoneLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Detail View Is Displaying Now");
    
    
    NSString *contactName = [contact objectForKey:kContactName];
    NSString *contactPhone = [contact objectForKey:kContactPhone];
    NSString *contactEmail = [contact objectForKey:kContactEmail];
    
    
    NSLog(@"User Name is %@", contactName);
    NSLog(@"User Phone is %@",contactPhone);
    NSLog(@"User email is %@",contactEmail);
    
    
    if ([contactName isEqualToString:@""] || [contactName isEqualToString:@"NULL"])
    {
        self.contactNameLabel.text = @"N/A";
    } else {
        self.contactNameLabel.text = contactName;
    }
    
    if ([contactPhone isEqualToString:@""] || [contactPhone isEqualToString:@""])
    {
        self.contactPhoneLabel.text = @"N/A";
    } else {
        self.contactPhoneLabel.text = contactPhone;
    }

    if ([contactEmail isEqualToString:@""] || [contactEmail isEqualToString:@""])
    {
        self.contactEmailLabel.text = @"N/A";
    } else {
        self.contactEmailLabel.text = contactEmail;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
