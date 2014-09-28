//
//  VWWCGLifeView.h
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWGridView.h"
@class VWWGOLLife;
@class VWWCGLifeView;

typedef enum {
    VWWCGLifeViewTouchTypeNormal = 0,
    VWWCGLifeViewTouchTypeGlider = 1,
    VWWCGLifeViewTouchTypeSpaceship = 2,
} VWWCGLifeViewTouchType;

@protocol VWWCGLifeViewDelegate <NSObject>
-(void)cgLifeView:(VWWCGLifeView*)sender userTouchedAtX:(NSInteger)x andY:(NSInteger)y;
-(void)cgLifeViewTouchesBegan:(VWWCGLifeView*)sender;
-(void)cgLifeViewTouchesEnded:(VWWCGLifeView*)sender;
@end

@interface VWWCGLifeView : VWWGridView
@property (nonatomic, weak) id <VWWCGLifeViewDelegate> delegate;
@property (nonatomic, strong) VWWGOLLife *life;
@property (nonatomic) VWWCGLifeViewTouchType touchType;
@end
