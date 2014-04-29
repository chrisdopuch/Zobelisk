//
//  UIView+FormScroll.h
//  Zobelisk
//
//  Created by Victor Tran on 4/27/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView_FormScroll : UIViewController


@end
#import <Foundation/Foundation.h>

@interface UIView (FormScroll)

-(void)scrollToY:(float)y;
-(void)scrollToView:(UIView *)view;
-(void)scrollElement:(UIView *)view toPoint:(float)y;

@end