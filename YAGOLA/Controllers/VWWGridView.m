//
//  VWWGridView.m
//  YAGOLA
//
//  Created by Zakk Hoyt on 9/27/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWGridView.h"

@implementation VWWGridView




-(void)drawSolidLineUsingContext:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint color:(UIColor*)color{
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    CGContextStrokePath(context);
    
}


- (void)drawRect:(CGRect)rect {
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(cgContext);
    
    UIColor *color = [UIColor greenColor];
    CGContextSetStrokeColorWithColor(cgContext , color.CGColor);
    
    CGFloat width = self.bounds.size.width / (float)self.cellsWide;

    
    
    for(NSUInteger y = 0; y < self.cellsWide; y++){
        CGPoint beginPoint = CGPointMake(y*width, 0);
        CGPoint endPoint = CGPointMake(y*width, self.bounds.size.height);
        [self drawSolidLineUsingContext:cgContext fromPoint:beginPoint toPoint:endPoint color:color];
    }
    
    
    NSUInteger cellsHigh = self.bounds.size.height / self.bounds.size.width * self.cellsWide;
    for(NSUInteger x = 0; x < cellsHigh; x++){
        CGPoint beginPoint = CGPointMake(0, x*width);
        CGPoint endPoint = CGPointMake(self.bounds.size.width, x*width);
        [self drawSolidLineUsingContext:cgContext fromPoint:beginPoint toPoint:endPoint color:color];
        
    }
    
    
    
}


@end
