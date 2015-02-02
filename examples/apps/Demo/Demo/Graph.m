//
//  Graph.m
//  Demo
//
//  Created by Ron Lasser on 9/13/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "Graph.h"


@interface Graph()

@property (nonatomic, assign) CGFloat scaleX;
@property (nonatomic, assign) CGFloat scaleY;

@property (nonatomic, assign) NSInteger plotStep;


@end

@implementation Graph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self myInitialization];
    }
    return self;
}

- (NSMutableArray *) graphXData
{
    if (!_graphXData){
        _graphXData = [[NSMutableArray alloc] init];
    }
    
    return _graphXData;
}

- (NSMutableArray *) graphYData
{
    if (!_graphYData){
        _graphYData = [[NSMutableArray alloc] init];
    }
    
    return _graphYData;
}


- (void)myInitialization
{
    // Initialization code
    self.backgroundColor = [UIColor darkGrayColor];
    self.scaleX = self.bounds.size.width/50.0;
    self.scaleY = self.bounds.size.height/50.0;
    self.plotStep = 0;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self myInitialization];
    }
    
    return self;
}

- (void) drawAxisX
{
    CGPoint start = CGPointMake(0, -0.5);
    CGPoint end = CGPointMake(43, -0.5);
    
     UIBezierPath *axisX = [[UIBezierPath alloc] init];
    [[UIColor whiteColor] setStroke];
    axisX.lineWidth = 3.0;
    [axisX moveToPoint: [self scalePoint: start]];
    [axisX addLineToPoint:[self scalePoint: end]];
    [axisX stroke];
    
}

- (void) drawAxisY
{
   
    CGPoint start = CGPointMake(0, -14);
    CGPoint end = CGPointMake(0, 34);
    
    UIBezierPath *axisY = [[UIBezierPath alloc] init];
    [[UIColor whiteColor] setStroke];
    axisY.lineWidth = 3.0;
    [axisY moveToPoint: [self scalePoint: start]];
    [axisY addLineToPoint:[self scalePoint: end]];
    [axisY stroke];
    
}

- (void) PlacePoint
{
    NSArray *ax = [self.graphXData copy];
    NSArray *ay = [self.graphYData copy];
    
    for (NSInteger i = 0; i < [ax count]; ++i) {
        CGPoint pa = CGPointMake([ax[i] floatValue], [ay[i] floatValue]);
        //CGPoint p = CGPointMake([[ax objectAtIndex:i] floatValue], [[ay objectAtIndex:i] floatValue]);
        CGPoint ra = [self scalePoint:pa];
        //NSLog(@"point: %3.2f, %3.2f", ra.x, ra.y);
        [[UIColor greenColor] setFill];
        CGRect oRect = CGRectMake(ra.x, ra.y, 5, 5);
        UIBezierPath *pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
        [pPath fill];
 /*
        [[UIColor redColor] setFill];
        UIBezierPath *gPath = [UIBezierPath bezierPath];
        [gPath moveToPoint:CGPointMake(150, 150)];
        [gPath addArcWithCenter:CGPointMake(150, 150) radius:25 startAngle:0 endAngle:3.14159 clockwise:YES];
        [gPath fill];
 */
    }
    /*
     NSArray *x = @[@0, @1, @2, @3, @10, @25, @50];
     NSArray *y = @[@0, @1, @2, @3, @10, @25, @40];
     for (NSInteger i = 0; i < [x count]; ++i) {
     CGPoint p = CGPointMake([x[i] floatValue], [y[i] floatValue]);
     //CGPoint p = CGPointMake([[x objectAtIndex:i] floatValue], [[y objectAtIndex:i] floatValue]);
     CGPoint r = [self scalePoint:p];
     NSLog(@"point: %3.2f, %3.2f", r.x, r.y);
     }
    */
}

- (void) AnimatedPlacePoint
{

    NSArray *ax = [self.graphXData copy];
    NSArray *ay = [self.graphYData copy];
    
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    
    UIColor *lightBlueColor = [UIColor colorWithRed:76.0/256.0 green:206.0/256.0 blue:1.0 alpha:1.0];
    
    NSInteger numberOfPoints = 22;

    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(goTime:) userInfo:nil repeats:YES];
    
    [lightBlueColor setFill];
    //[[UIColor yellowColor] setFill];
    for (NSInteger i = 0; i < numberOfPoints; ++i) {
        UIBezierPath *pPath = [UIBezierPath bezierPath];
        CGPoint pa = CGPointMake([ax[(self.plotStep+i)%35] floatValue], [ay[(self.plotStep+i)%35] floatValue]);
        CGPoint ra = [self scalePoint:pa];
        CGRect oRect = CGRectMake(ra.x,ra.y, 5, 5);
        pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
        [paths addObject:pPath];
    }
    
    for (NSInteger i = 0; i < numberOfPoints; ++i) {
        [[paths objectAtIndex:i] fill];
    }
/*
    
    for (NSInteger i = 0; i <= 22; ++i) {
        CGPoint na = CGPointMake([ax[(self.plotStep+i)%35] floatValue], [ay[(self.plotStep+i)%35] floatValue]);
        CGPoint ra = [self scalePoint:na];
        CGContextFillEllipseInRect(context, CGRectMake(ra.x, ra.y, 5, 5));
    }
    
    
    UIBezierPath *pPath = [UIBezierPath bezierPath];
    [[UIColor greenColor] setFill];
    CGPoint ra = CGPointMake(150, 150);
    
    CGRect oRect = CGRectMake(ra.x,ra.y, 5, 5);
    pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
    
    UIBezierPath *qPath = [UIBezierPath bezierPath];
     ra = CGPointMake(170, 150);
    
     oRect = CGRectMake(ra.x,ra.y, 5, 5);
    qPath = [UIBezierPath bezierPathWithOvalInRect:oRect];

    
    [pPath fill];
    [qPath fill];
 */
    // GFloat ax[] ={5, 10, 15};
    // CGFloat ay[] ={5, 10, 15};
    
/*
    UIBezierPath *pPath = [UIBezierPath bezierPath];
    [[UIColor greenColor] setFill];
    NSLog(@"------> ps: %d", self.plotStep);
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(goTime:) userInfo:nil repeats:YES];
    
    

    
//    CGPoint pa = CGPointMake([ax[self.plotStep] floatValue], [ay[self.plotStep] floatValue]);
    CGPoint pa = CGPointMake(5, 5);
    CGPoint ra = [self scalePoint:pa];
    CGRect oRect = CGRectMake(ra.x,ra.y, 5, 5);
    pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
  
    UIBezierPath *qPath = [UIBezierPath bezierPath];
    [[UIColor greenColor] setFill];

    //pa = CGPointMake([ax[self.plotStep] floatValue], [ay[self.plotStep] floatValue]);
    pa = CGPointMake(15, 15);
    ra = [self scalePoint:pa];
    oRect = CGRectMake(ra.x,ra.y, 5, 5);
    qPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
*/
/*
    pa = CGPointMake(ax[2], ay[2]);
    ra = [self scalePoint:pa];
    oRect = CGRectMake(ra.x,ra.y, 5, 5);
    pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];

    [pPath stroke];
    [pPath fill];
    //NSLog(@"ai: %d", i);

   */
    

/*    for (NSInteger i = self.plotStep; i <= self.plotStep + erasePoints; ++i) {
        //plot in darkgray
        [[UIColor darkGrayColor] setFill];
        [[UIColor darkGrayColor] setStroke];
        NSInteger p = i%numberPoints;
        CGPoint pa = CGPointMake([ax[p] floatValue], [ay[p] floatValue]);
        CGPoint ra = [self scalePoint:pa];
        CGRect oRect = CGRectMake(ra.x, ra.y, 5, 5);
        pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
        [pPath fill];
    }
*/
/*
    CGPoint pa = CGPointMake([ax[i] floatValue], [ay[i] floatValue]);
    //CGPoint p = CGPointMake([[ax objectAtIndex:i] floatValue], [[ay objectAtIndex:i] floatValue]);
    CGPoint ra = [self scalePoint:pa];
    //NSLog(@"point: %3.2f, %3.2f", ra.x, ra.y);
    CGRect oRect = CGRectMake(ra.x, ra.y, 5, 5);
    pPath = [UIBezierPath bezierPathWithOvalInRect:oRect];
    [pPath fill];
 */
  /*
    //erase point
    NSInteger ei = [[erasePt objectAtIndex:i] integerValue];
    CGFloat ex = [[ax objectAtIndex:ei] floatValue];
    CGFloat ey = [[ay objectAtIndex:ei] floatValue];
    CGPoint ea = CGPointMake(ex, ey);
    
    [[UIColor darkGrayColor] setFill];
    [[UIColor darkGrayColor] setStroke];
    CGRect eRect = CGRectMake(ea.x, ea.y, 5, 5);
    UIBezierPath *ePath = [UIBezierPath bezierPathWithOvalInRect:eRect];
    [ePath fill];
    [[UIColor whiteColor] setStroke];
    */
    //[self setNeedsDisplay];
}

- (void) goTime: (NSTimer *) timer
{
    NSLog(@"%s", __FUNCTION__);

    self.plotStep = (self.plotStep + 1)%35;
    //NSLog(@"Timer");
    [timer invalidate];
    [self setNeedsDisplay];
}

- (CGPoint) scalePoint: (CGPoint) data
{
    CGFloat offsetX = 15;
    CGFloat offsetY = 15;
    CGFloat dataX = data.x;
    CGFloat dataY = data.y;
    CGFloat yheight = self.bounds.size.height;
    CGFloat scaleX = dataX*self.scaleX;
    CGFloat scaleY = dataY*self.scaleY;
    CGFloat scaleOffY = offsetY*self.scaleY;
    CGFloat plotY = yheight - scaleY - scaleOffY;
    CGFloat plotX = scaleX + offsetX;
    
    return CGPointMake(plotX, plotY);
}

- (void) CGAnimatedPlacePoint: (CGContextRef) context
{
    NSArray *ax = [self.graphXData copy];
    NSArray *ay = [self.graphYData copy];
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(goTime:) userInfo:nil repeats:YES];
    
    for (NSInteger i = 0; i <= 22; ++i) {
        CGPoint na = CGPointMake([ax[(self.plotStep+i)%35] floatValue], [ay[(self.plotStep+i)%35] floatValue]);
        CGPoint ra = [self scalePoint:na];
        CGContextFillEllipseInRect(context, CGRectMake(ra.x, ra.y, 5, 5));
    }

    

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawAxisX];
    [self drawAxisY];
    //[self PlacePoint];
    [self AnimatedPlacePoint];
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColor(context, CGColorGetComponents([[UIColor greenColor] CGColor]));
    
    //[self CGAnimatedPlacePoint: context];
    
}

-(void) printArray
{
    for (NSInteger i = 0; i < [self.graphXData count]; ++i) {
        NSLog(@"%3.2f", [[self.graphXData objectAtIndex:i] floatValue]);
    }
}


@end
