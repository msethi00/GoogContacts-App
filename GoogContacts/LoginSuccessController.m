//
//  LoginSuccessController.m
//  GoogContacts
//
//  Created by Muneesh Sethi on 2014-06-02.
//  Copyright (c) 2014 Muneesh Sethi. All rights reserved.
//

#import "LoginSuccessController.h"
#import "DetailViewController.h"
#import "AppConfig.h"
#import "AppManager.h"
#import "InitialViewController.h"
#import "LoginViewController.h"

@interface LoginSuccessController ()

@end

@implementation LoginSuccessController

@synthesize googleContactsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)logoutButtonTouched:(id)sender
{
    [[AppManager sharedAppManager] logoutClient];
    [[AppManager sharedAppManager] saveAllData];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    NSLog(@"Size of googleContactsArray is %d", [self.googleContactsArray count]);
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.googleContactsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Contact";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    NSDictionary *contact =  [googleContactsArray objectAtIndex:indexPath.row];
    NSString *name = [contact objectForKey:kContactName];
    
    cell.textLabel.text = name;
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ContactDetailsSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        [destViewController setContact:(NSMutableDictionary*)[googleContactsArray objectAtIndex:indexPath.row]];
    }
}



 

@end
