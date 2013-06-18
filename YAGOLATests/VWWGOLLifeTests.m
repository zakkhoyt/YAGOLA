//
//  VWWGOLLifeTests.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//


#import "VWWGOLLifeTests.h"
#import "VWWGOLLife.h"

@interface VWWGOLLifeTests ()
@property (nonatomic, strong) VWWGOLLife *life;
@end

@implementation VWWGOLLifeTests

- (void)setUp
{
    [super setUp];
    self.life = [[VWWGOLLife alloc]initWithWidth:10 height:10];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}


// xxxxxx
// xxxxxx
// x012xx
// xxxxxx
// xxxxxx
//- (void)test3x1Line
//{
//    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
//    [self.life addCell:cell];
//    
//
//    
//    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
//    [self.life addCell:cell1];
//    
//
//    
//    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
//    [self.life addCell:cell2];
//    
//    
//    [self.life processTimer];
//    
//    STAssertTrue((BOOL)(self.life.cells.count == 3), @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    cell = [self.life.cells objectForKey:@"2,1"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//
//    cell = [self.life.cells objectForKey:@"2,2"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//
//    cell = [self.life.cells objectForKey:@"2,3"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//
//
//    [self.life processTimer];
//    
//    STAssertTrue((self.life.cells.count == 3), @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    cell = [self.life.cells objectForKey:@"1,2"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = [self.life.cells objectForKey:@"2,2"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = [self.life.cells objectForKey:@"3,3"];
//    STAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//
//    
//    NSLog(@"");
//    
//    
//    
//    
//}

@end
