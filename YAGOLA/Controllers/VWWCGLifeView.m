//
//  VWWCGLifeView.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGLifeView.h"
#import "VWWGOLLife.h"

@interface VWWCGLifeView ()
@property (nonatomic, strong) NSMutableSet *usedCells;
@end

@implementation VWWCGLifeView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.usedCells = [[NSMutableSet alloc]init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    self.cellsWide = self.life.width;
    [super drawRect:rect];
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = cellWidth;
    CGContextRef context = UIGraphicsGetCurrentContext();

    @try {
        for(VWWGOLCell *cell in self.usedCells){
            UIColor *color = [UIColor darkGrayColor];
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGFloat rectX = cellWidth * cell.x;
            CGFloat rectY = cellHeight * cell.y;
            CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
            CGContextFillRect(context, cellRect);
        }
        
        
        
        for(VWWGOLCell *cell in [self.life.cells allValues]){
            UIColor *color = [self colorForAge:cell.age];
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGFloat rectX = cellWidth * cell.x;
            CGFloat rectY = cellHeight * cell.y;
            CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
            CGContextFillRect(context, cellRect);
            [self.usedCells addObject:cell];
            
        }
        CGContextDrawPath(context,kCGPathStroke);
    }
    @catch (NSException *exception) {

    }
    @finally {

    }
    
    
    
    
}

-(UIColor*)colorForAge:(NSUInteger)age{
    float red = 0;
    float green = 0;
    float blue = 0;
    float alpha = 1.0;
    
    float base =0.0625;
    red = base * (age+1);

    blue = base * (age+1);
    green = 0.5 + base / 2.0 * (age+1);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    
}





-(void)touchesGlider:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint begin = [touch locationInView:self];
    
    
    
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellWidth;
    
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
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellWidth;
    
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
    
    NSInteger x = begin.x / cellWidth;
    NSInteger y = begin.y / cellWidth;
    
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
