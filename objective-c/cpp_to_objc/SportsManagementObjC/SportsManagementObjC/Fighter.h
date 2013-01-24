//
//  Fighter.h
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportsClient.h"

@interface Fighter : SportsClient
{
    unsigned int weight;
    NSString *nickname;
    NSString *affiliation;
}

@property (retain, nonatomic) NSString *nickname;
@property (retain, nonatomic) NSString *affiliation;
@property (nonatomic) unsigned int weight;

-(id) initWith:(NSString *)fname and:(NSString *)lname and:(unsigned int)a and:(NSString *)e;
-(void) print;
-(void) dealloc;

@end
