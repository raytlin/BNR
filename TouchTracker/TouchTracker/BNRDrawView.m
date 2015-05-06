//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Ray Lin on 5/5/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

//@property (nonatomic, strong) BNRLine* currentLine;
@property (nonatomic, strong)NSMutableDictionary* linesInProgress;

@property (nonatomic, strong) NSMutableArray* finishedLines;

@end

@implementation BNRDrawView

-(void)doubleTap:(UIGestureRecognizer*)gr{
    NSLog(@"Recognized double tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
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
    }
    return self;
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
    
//    if (self.currentLine) {
//        [[UIColor redColor]set];
//        [self strokeLine:self.currentLine];
//    }
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
