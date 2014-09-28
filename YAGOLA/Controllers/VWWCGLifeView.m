//
//  VWWCGLifeView.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGLifeView.h"
#import "VWWGOLLife.h"



@implementation VWWCGLifeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    NSLog(@"%s", __func__);
    
    //    self.backgroundColor = [UIColor clearColor];
    
//    NSLog(@"Self.bounds.width: %.2f", self.bounds.size.width);
//    NSLog(@"self.life.width: %.2f", (float)self.life.width);
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = self.bounds.size.height / self.life.height;
    
    CGFloat red, green, blue, alpha;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    for(NSInteger x = 0; x < self.physics.width; x++){
    //        for(NSInteger y = 0; y < self.physics.height; y++){
    //            VWWGOLCell *cell = [self.physics cellAtIndex:y + self.physics.width * x];
    //            if(cell){
    //                [cell.color getRed:&red green:&green blue:&blue alpha:&alpha];
    //                CGContextSetRGBFillColor(context, red, green, blue, alpha);
    //            }
    //            else{
    //                CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    //            }
    //
    //            CGFloat rectX = cellWidth * x;
    //            CGFloat rectY = cellHeight * y;
    //
    //            CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
    ////            CGContextFillEllipseInRect(context, cellRect);
    //            CGContextFillRect(context, cellRect);
    //        }
    //    }
    
    
    for(VWWGOLCell *cell in [self.life.cells allValues]){
        [cell.color getRed:&red green:&green blue:&blue alpha:&alpha];
        CGContextSetRGBFillColor(context, red, green, blue, alpha);
        CGFloat rectX = cellWidth * cell.x;
        CGFloat rectY = cellHeight * cell.y;
        CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
        CGContextFillRect(context, cellRect);
    }
    
    
    
    
    CGContextDrawPath(context,kCGPathStroke);
    
}





-(void)touchesGlider:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint begin = [touch locationInView:self];
    
    
    
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = self.bounds.size.height / self.life.height;
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellHeight;
    
    // 00X
    // X0X
    // 0XX
    [self.delegate cgLifeView:self userTouchedAtX:x andY:y];
    [self.delegate cgLifeView:self userTouchedAtX:x+1 andY:y+1];
    [self.delegate cgLifeView:self userTouchedAtX:x+2 andY:y+1];
    [self.delegate cgLifeView:self userTouchedAtX:x+2 andY:y];
    [self.delegate cgLifeView:self userTouchedAtX:x+2 andY:y-1];

}

-(void)touchesSpaceship:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint begin = [touch locationInView:self];
    
    
    
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = self.bounds.size.height / self.life.height;
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellHeight;
    
    // 0XXXX
    // X000X
    // 0000X
    // X00X0
    
    [self.delegate cgLifeView:self userTouchedAtX:x andY:y];
    [self.delegate cgLifeView:self userTouchedAtX:x+3 andY:y];
    [self.delegate cgLifeView:self userTouchedAtX:x+4 andY:y-1];
    [self.delegate cgLifeView:self userTouchedAtX:x+4 andY:y-2];
    [self.delegate cgLifeView:self userTouchedAtX:x+4 andY:y-3];
    [self.delegate cgLifeView:self userTouchedAtX:x+3 andY:y-3];
    [self.delegate cgLifeView:self userTouchedAtX:x+2 andY:y-3];
    [self.delegate cgLifeView:self userTouchedAtX:x+1 andY:y-3];
    [self.delegate cgLifeView:self userTouchedAtX:x andY:y-2];
}

-(void)setLife:(VWWGOLLife *)life{
    _life = life;
}
-(void)touches:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint begin = [touch locationInView:self];
    
    
    
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = self.bounds.size.height / self.life.height;
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellHeight;
    
    [self.delegate cgLifeView:self userTouchedAtX:x andY:y];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate cgLifeViewTouchesBegan:self];
    
    if(self.touchType == VWWCGLifeViewTouchTypeNormal){
        [self touches:touches withEvent:event];
    } else if(self.touchType == VWWCGLifeViewTouchTypeGlider){
        [self touchesGlider:touches withEvent:event];
    } else if(self.touchType == VWWCGLifeViewTouchTypeSpaceship){
        [self touchesSpaceship:touches withEvent:event];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.touchType == VWWCGLifeViewTouchTypeNormal){
        [self touches:touches withEvent:event];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.touchType == VWWCGLifeViewTouchTypeNormal){
        [self touches:touches withEvent:event];
    }

    [self.delegate cgLifeViewTouchesEnded:self];
}




@end
