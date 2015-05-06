//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Ray Lin on 5/5/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import <UIKit/UIKit.h>

@interface BNRDrawView () <UIGestureRecognizerDelegate>

//@property (nonatomic, strong) BNRLine* currentLine;
@property (nonatomic, strong) UIPanGestureRecognizer* moveRecognizer;

@property (nonatomic, strong)NSMutableDictionary* linesInProgress;

@property (nonatomic, strong) NSMutableArray* finishedLines;

@property (nonatomic, weak) BNRLine* selectedLine;

@end

@implementation BNRDrawView



-(void)deleteLine:(id)sender{
    [self.finishedLines removeObject:self.selectedLine];
    
    [self setNeedsDisplay];
}

-(void)doubleTap:(UIGestureRecognizer*)gr{
    NSLog(@"Recognized double tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    
    
    [self setNeedsDisplay];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)tap:(UIGestureRecognizer*)gr{
    NSLog(@"recognized tap");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController * menu = [UIMenuController sharedMenuController];
        UIMenuItem* deleteItem = [[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }else{
        [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return self;
}

-(void)moveLine:(UIPanGestureRecognizer*)gr{
    if (!self.selectedLine) {
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

-(void)longPress:(UIGestureRecognizer*)gr{
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
        else if (gr.state == UIGestureRecognizerStateEnded){
            self.selectedLine = nil;
        }
        [self setNeedsDisplay];
    }
}

-(void)strokeLine:(BNRLine *)line{
    UIBezierPath* bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

-(void)drawRect:(CGRect)rect{
    
    //why?
    [[UIColor blackColor]set];
    
    for (BNRLine* line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor]set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor]set];
        [self strokeLine:self.selectedLine];
    }
}

-(BNRLine*)lineAtPoint:(CGPoint)p{
    for (BNRLine* l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        for (float t = 0.0; t<=1.0; t+=0.05) {
            float x = start.x + t* (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            if (hypot(x-p.x, y - p.y)<20.0) {
                return l;
            }
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch* t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    self.currentLine = [[BNRLine alloc]init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        CGPoint location = [t locationInView:self];
        
        BNRLine *line = [[BNRLine alloc]init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //is this bc the nsset contains all touches for multitouch? what does anyobject return for multitouch?
//    UITouch* t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    self.currentLine.end = location;

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue* key = [NSValue valueWithNonretainedObject:t];
        BNRLine* line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    
    //what is setNeedsDisplay?
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.finishedLines addObject:self.currentLine];
//    self.currentLine = nil;
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch* t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        BNRLine* line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
        
        
        
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch* t in touches) {
        NSValue* key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
        
    }
    [self setNeedsDisplay];
}

@end
