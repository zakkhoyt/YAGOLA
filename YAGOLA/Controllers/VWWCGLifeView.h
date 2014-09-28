//
//  VWWCGLifeView.h
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface VWWCGLifeView : UIView
@property (nonatomic, weak) id <VWWCGLifeViewDelegate> delegate;
@property (nonatomic, strong) VWWGOLLife *life;
@property (nonatomic) VWWCGLifeViewTouchType touchType;
@end
