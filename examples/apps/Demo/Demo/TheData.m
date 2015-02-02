//
//  TheData.m
//  Demo
//
//  Created by Ron Lasser on 9/13/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "TheData.h"

@interface TheData()

@property (nonatomic, strong) NSMutableArray *dataX;
@property (nonatomic, strong) NSMutableArray *dataY;

@end

@implementation TheData

- (NSArray *) getDataX
{
    return (NSArray *) self.dataX;
}

- (NSArray *) getDataY
{
    return (NSArray *) self.dataY;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        [self myInitialization];
//        NSLog(@"%s", __FUNCTION__);
    }
    
    return self;
}



- (void)myInitialization
{
    // Initialization code
    
    NSString *filePathCSV = [[NSBundle mainBundle] pathForResource:@"DemoData" ofType:@"csv"];
    
    [self readColumnFromCSV:filePathCSV AtColumn:1];
    
    self.dataX = [NSMutableArray arrayWithArray: [self readColumnFromCSV:filePathCSV AtColumn:0] ];
    self.dataY = [NSMutableArray arrayWithArray: [self readColumnFromCSV:filePathCSV AtColumn:1] ];
    
    for (NSInteger i = 0; i < [self.dataX count]; ++i) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        self.dataX[i] = [f numberFromString:[self.dataX objectAtIndex:i]]; // NSNumber
        self.dataY[i] = [f numberFromString:[self.dataY objectAtIndex:i]]; // NSNumber
        //CGFloat nx = [self.dataX[i] floatValue];
        //CGFloat ny = [self.dataY[i] floatValue];
        //NSLog(@" data: %3.2f  %3.2f", nx, ny);
    }

}

#pragma mark -- file loader

-(NSMutableArray *)readColumnFromCSV:(NSString*)path AtColumn:(int)column
{
    
    NSMutableArray *readArray=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\r"];
    
    for (NSString *lineString in linesArray)
    {
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [readArray addObject:[columnArray objectAtIndex:column]];
    }
    
    return readArray;
    
    // for debug: NSLog(@"%@",readArray);
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"TheData - read from CSV file returns array of NSNumbers."];
}
/*
- (NSMutableDictionary *) readColumnFromCSVFile: (NSString *) path
{
    NSMutableArray *readKeys = [[NSMutableArray alloc]init];
    NSMutableArray *readValues = [[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\r"];
    
    for (NSString *lineString in linesArray)
    {
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        NSNumber * n0 = [NSNumber numberWithFloat:[[columnArray objectAtIndex:0] floatValue]];
        NSNumber * n1 = [NSNumber numberWithFloat:[[columnArray objectAtIndex:1] floatValue]];
        NSArray *numberArray = [NSArray arrayWithObjects:n0, n1, nil];
 
         //for (NSNumber *num in numberArray) {
         //NSLog(@"  %3.2f",[num floatValue]);
         //}
 
        [readKeys addObject:[numberArray objectAtIndex:0]];
        [readValues addObject:[numberArray objectAtIndex:1]];
        
    }
    NSMutableDictionary * data = [NSMutableDictionary dictionaryWithObjects:readValues forKeys:readKeys];
    //NSLog(@"%@", data);
    
    return data;
    
}
*/

@end