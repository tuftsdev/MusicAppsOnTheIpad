//
//  SportsClient.h
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/24/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportsClient : NSObject
{
    NSString *firstName;
    NSString *lastName;
    NSString *email;
    unsigned int age;
    NSString *comments;
}

@property (retain, nonatomic) NSString *firstName;
@property (retain, nonatomic) NSString *lastName;
@property (retain, nonatomic) NSString *email;
@property (nonatomic) unsigned int age;
@property (retain, nonatomic) NSString *comments;

-(id) init;
-(id) initWithFirstName: (NSString *) fname withLastName: (NSString *) lname;
-(id) initWithFirstName: (NSString *) fname withLastName: (NSString *) lname withAge: (unsigned int) a withEmail: (NSString *) e;
-(void) sendEmailWithSubject: (NSString *) subject withMessage: (NSString *) message;
-(void) print;
-(void) dealloc;

@end
