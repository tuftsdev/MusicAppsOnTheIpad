//
//  SportsClient.m
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/24/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "SportsClient.h"

@implementation SportsClient

@synthesize firstName, lastName, email, age, comments;

-(id) init
{
    NSLog(@"Starting record for client, 1...");
    self = [super init];
    if (self) {
        firstName = @"";
        lastName = @"";
        email = @"";
        age = 0;
        comments = @"";
    }
    return self;
}

-(id) initWithFirstName: (NSString *) fname withLastName: (NSString *) lname
{
    NSLog(@"Starting record for client, 2...");
    self = [super init];
    if (self) {
        firstName = fname;
        lastName = lname;
        email = @"";
        age = 0;
        comments = @"";
    }
    return self;    
}

-(id) initWithFirstName: (NSString *) fname withLastName: (NSString *) lname withAge: (unsigned int) a withEmail: (NSString *) e
{
    NSLog(@"Starting record for client, 3...");
    self = [super init];
    if (self) {
        firstName = fname;
        lastName = lname;
        email = e;
        age = a;
        comments = @"";
    }
    return self;
}

-(void) sendEmailWithSubject: (NSString *) subject withMessage: (NSString *) message
{
    NSLog(@"Sending email...");
}

-(void) print
{
    NSLog(@"%@ %@", firstName, lastName);
}

-(void) dealloc
{
    NSLog(@"Bye!");
}

@end
