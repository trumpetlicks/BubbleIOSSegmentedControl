//
//  BubbleSegmentedControl.m
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 8/7/14.
//
//

#import "BubbleIOSSegmentedControl.h"

@implementation BubbleIOSSegmentButton

@synthesize tintColor;

-(id)init{
    
    if( self = [super init] ){
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setSelected:NO];
    
        myType = SEGMENT_LEFT;
        self.autoCalculateWidth = YES;
    
        cornerRadius = 6;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame] ){
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setSelected:NO];
        
        myType = SEGMENT_LEFT;
        self.autoCalculateWidth = YES;
        
        cornerRadius = 6;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setSelected:NO];
        
        myType = SEGMENT_LEFT;
        self.autoCalculateWidth = YES;
        
        cornerRadius = 6;
    }
    return self;
}

-(void)setSegmentType:(segmentType)aType{
    myType = aType;
    [self setNeedsDisplay];
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

#define DEG_TO_RADIANS(x) (((float)(x) * 3.141592654f) / 180.0f)

-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx   = UIGraphicsGetCurrentContext();
	CGRect       frame = self.bounds;
    
    CGContextSaveGState(ctx);
    
    if( YES == self.isSelected ){
        
        CGContextSetFillColorWithColor(ctx, self.tintColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
        
        switch (myType) {
            case SEGMENT_LEFT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(270), DEG_TO_RADIANS(180), 1);
                CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(180), DEG_TO_RADIANS(90), 1);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                //CGPathAddLineToPoint(path, nil, cornerRadius, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, cornerRadius, 0);
                CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(275), DEG_TO_RADIANS(175), 1);
                CGPathMoveToPoint(path, nil, 0, frame.size.height - cornerRadius);
                CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(175), DEG_TO_RADIANS(85), 1);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, 0, cornerRadius - 2);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height - cornerRadius + 2);
                CGPathMoveToPoint(path, nil, cornerRadius - 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                CGPathAddLineToPoint(path, nil, cornerRadius - 2, 0);
                CGContextSetLineWidth(ctx, 2.0);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
            }
                break;
            case SEGMENT_RIGHT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, frame.size.width - cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(270), DEG_TO_RADIANS(0), 0);
                CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(0), DEG_TO_RADIANS(90), 0);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width - cornerRadius, 0);
                CGPathAddArc(path, nil, frame.size.width - cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(265), DEG_TO_RADIANS(5), 0);
                CGPathMoveToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius);
                CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(355), DEG_TO_RADIANS(95), 0);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width, cornerRadius - 2);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius + 2);
                CGPathMoveToPoint(path, nil, frame.size.width - cornerRadius + 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, 0);
                CGPathAddLineToPoint(path, nil, frame.size.width - cornerRadius + 2, 0);
                CGContextSetLineWidth(ctx, 2.0);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
            }
                break;
            default:
                CGContextTranslateCTM(ctx, 0, 0);
                CGContextFillRect(ctx, CGRectMake(0, 0, frame.size.width, frame.size.height));
                CGContextSetLineWidth(ctx, 2.0);
                CGContextStrokeRect(ctx, frame);
                break;
        } // END --> switch (myType)
        
        CGContextSetBlendMode(ctx, kCGBlendModeSourceOut);
        //[self.titleLabel drawTextInRect:self.titleLabel.frame];
        [[self attributedTitleForState:self.state] drawInRect:self.titleLabel.frame];
        
    }else{
        
        
        if( self.isHighlighted ) CGContextSetFillColorWithColor(ctx, [self.tintColor colorWithAlphaComponent:0.15].CGColor);
        else CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
        
        CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
        
        switch (myType) {
            case SEGMENT_LEFT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(270), DEG_TO_RADIANS(180), 1);
                CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(180), DEG_TO_RADIANS(90), 1);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                //CGPathAddLineToPoint(path, nil, cornerRadius, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, cornerRadius, 0);
                CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(275), DEG_TO_RADIANS(175), 1);
                CGPathMoveToPoint(path, nil, 0, frame.size.height - cornerRadius);
                CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(175), DEG_TO_RADIANS(85), 1);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, 0, cornerRadius - 2);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height - cornerRadius + 2);
                CGPathMoveToPoint(path, nil, cornerRadius - 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                CGPathAddLineToPoint(path, nil, cornerRadius - 2, 0);
                CGContextSetLineWidth(ctx, 2.0);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                }
                break;
            case SEGMENT_RIGHT:{
                    CGMutablePathRef path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                    CGPathAddArc(path, nil, frame.size.width - cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(270), DEG_TO_RADIANS(0), 0);
                    CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(0), DEG_TO_RADIANS(90), 0);
                    CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, 0);
                    CGPathCloseSubpath(path);
                    CGContextAddPath(ctx, path);
                    CGContextFillPath(ctx);
                
                    // Draw the rounded corners on the left
                    CGPathRelease(path);
                    path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width - cornerRadius, 0);
                    CGPathAddArc(path, nil, frame.size.width - cornerRadius, cornerRadius, cornerRadius, DEG_TO_RADIANS(265), DEG_TO_RADIANS(5), 0);
                    CGPathMoveToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius);
                    CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, DEG_TO_RADIANS(355), DEG_TO_RADIANS(95), 0);
                    CGContextSetLineWidth(ctx, 1.15);
                    CGContextAddPath(ctx, path);
                    CGContextStrokePath(ctx);

                    // Draw the straight line paths
                    CGPathRelease(path);
                    path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width, cornerRadius - 2);
                    CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius + 2);
                    CGPathMoveToPoint(path, nil, frame.size.width - cornerRadius + 2, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, 0);
                    CGPathAddLineToPoint(path, nil, frame.size.width - cornerRadius + 2, 0);
                    CGContextSetLineWidth(ctx, 2.0);
                    CGContextAddPath(ctx, path);
                    CGContextStrokePath(ctx);
                }
                break;
            default:
                CGContextTranslateCTM(ctx, 0, 0);
                CGContextFillRect(ctx, CGRectMake(0, 0, frame.size.width, frame.size.height));
                CGContextSetLineWidth(ctx, 2.0);
                CGContextStrokeRect(ctx, frame);
                break;
        } // END --> switch (myType)
        
    } // END --> if( YES == isSelected )
    
    CGContextRestoreGState(ctx);
    
} // END --> -(void)drawRect:(CGRect)rect

@end



/*
 *
 */
@implementation BubbleIOSSegmentedControl

@synthesize buttonArray;
@synthesize allowsMultipleSelection;
@synthesize allowsNullSelection;
@synthesize selectedSegmentIndex = _selectedSegmentIndex;
@synthesize tintColor            = _tintColor;

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        
        // Setup Default parameters, Blue Font and Outline, see through backing
        self.opaque                  = NO;
        self.backgroundColor         = [UIColor clearColor];
        _tintColor                   = [UIColor colorWithRed:0.0 green:124.0 / 255.0 blue:1.0 alpha:1.0];
        self.allowsMultipleSelection = NO;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque                  = NO;
        self.backgroundColor         = [UIColor clearColor];
        _tintColor                   = [UIColor colorWithRed:0.0 green:124.0 / 255.0 blue:1.0 alpha:1.0];
        self.allowsMultipleSelection = NO;
    }
    return self;
}


-(void)setSelectedSegmentIndex:(unsigned int)selectedSegmentIndex{
    if( NO == allowsMultipleSelection ){
        _selectedSegmentIndex = selectedSegmentIndex;
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:_selectedSegmentIndex]) setSelected:YES];
    }
}

-(void)setupWithNamesArray:(NSArray *)namesArray{
    
    if( nil != namesArray && namesArray.count > 0){
        
        self.buttonArray = [NSMutableArray array];
        
        for(NSString * string in namesArray){
            if( [string isKindOfClass:[NSString class]] ){
                BubbleIOSSegmentButton  * newButton = [BubbleIOSSegmentButton  buttonWithType:UIButtonTypeCustom];
                newButton.backgroundColor = self.backgroundColor;
                newButton.tintColor       = [_tintColor copy];
                
                newButton.titleLabel.font = [UIFont systemFontOfSize:12];
                
                // Setup the initial attributed string for the "" Label
                NSDictionary * attrDictNorm    = @{NSFontAttributeName:newButton.titleLabel.font,
                                                   NSForegroundColorAttributeName:_tintColor};
                
                NSDictionary * attrDictHigh    = @{NSFontAttributeName:newButton.titleLabel.font,
                                                   NSForegroundColorAttributeName:_tintColor};
                
                NSDictionary * attrDictSel     = @{NSFontAttributeName:newButton.titleLabel.font,
                                                   NSForegroundColorAttributeName:[UIColor clearColor]};
                
                NSDictionary * attrDictSelHigh = @{NSFontAttributeName:newButton.titleLabel.font,
                                                   NSForegroundColorAttributeName:[UIColor clearColor]};
                
                // Make the first occurance of " underlined for the "Visible Light Limits" Label
                NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:string attributes:attrDictNorm];
                [newButton setAttributedTitle:title forState:UIControlStateNormal];
                
                title = [[NSMutableAttributedString alloc] initWithString:string attributes:attrDictHigh];
                [newButton setAttributedTitle:title forState:UIControlStateHighlighted];
                
                title = [[NSMutableAttributedString alloc] initWithString:string attributes:attrDictSel];
                [newButton setAttributedTitle:title forState:UIControlStateSelected];
                
                title = [[NSMutableAttributedString alloc] initWithString:string attributes:attrDictSelHigh];
                [newButton setAttributedTitle:title forState:UIControlStateSelected | UIControlStateHighlighted];
                
                [newButton setSelected: NO];
                newButton.autoCalculateWidth = YES;
                [newButton setSegmentType:SEGMENT_MIDDLE];
                [newButton addTarget:self
                              action:@selector(buttonAction:)
                    forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
                [self.buttonArray addObject:newButton];
            }
        }
        
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:0]) setSegmentType:SEGMENT_LEFT];
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:(self.buttonArray.count - 1)]) setSegmentType:SEGMENT_RIGHT];
        
        unsigned int mainButtonWidth = (int)self.frame.size.width / self.buttonArray.count;
        unsigned int excess          = (int)self.frame.size.width % self.buttonArray.count;
        unsigned int runningX        = 0;
        
        for(unsigned int buttonCount = 0; buttonCount < self.buttonArray.count; buttonCount++){
            
            if      ( 0 == buttonCount ){
                ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0, 0, mainButtonWidth + (excess / 2) + (excess % 2), self.bounds.size.height);
                runningX += ( mainButtonWidth + (excess / 2) + (excess % 2) );
            }else if( ( self.buttonArray.count - 1 ) == buttonCount){
                ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1, 0, mainButtonWidth + 1 + (excess / 2), self.bounds.size.height);
                runningX += (mainButtonWidth + (excess / 2) );
            }else{
                ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1, 0, mainButtonWidth + 1, self.bounds.size.height);
                runningX += mainButtonWidth;
            }
            
            [self addSubview:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:buttonCount])];
            
        } // END --> for(unsigned int buttonCount = 0; buttonCount < buttonArray.count; buttonCount++) <--
        
    } // END --> if( nil != namesArray && namesArray.count > 0) <--
    
    [self setNeedsDisplay];
    
} // END --> -(void)initWithNamesArray:(NSArray *)namesArray


-(void)setAllowsMultipleSelection:(BOOL)inAllowsMultipleSelection{
    allowsMultipleSelection = inAllowsMultipleSelection;
}


-(void)insertSegments:(NSArray *)namesArray atIndex:(int)segment{
    
}

-(void)insertSegment:(NSString *)name after:(int)segment{
    
}


-(void)removeSegmentsWithNames:(NSArray *)names{
    
}

-(void)removeSegmentByString:(NSString *)name{
    
}

-(void)removeSegmentAtIndex:(unsigned int)segment{
    
}

-(void)selectSegment:(unsigned int)segment{
    
    if( segment < self.buttonArray.count ) [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:YES];
    
}

-(void)deSelectSegment:(unsigned int)segment{
    if( segment < self.buttonArray.count ) [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:NO];
}

-(void)selectAllSegments{
    
}

-(void)deselectAllSegments{
    
}

-(void)emulateTouchOnSegment:(unsigned int)segment{
    
    if(segment < buttonArray.count){
        if( YES == self.allowsMultipleSelection ){
            [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:![((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) isSelected]];
        }else{
            for(unsigned int i = 0; i < self.buttonArray.count; i++){
                if( i == segment ) [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) setSelected:YES];
                else               [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) setSelected:NO];
            } // END --> for(unsigned int i = 0; i < self.buttonArray.count; i++) <--
        } // if( YES == allowsMultipleSelection ) <--
    }// END --> if(segment < buttonArray.count)
    
}

-(BOOL)isSegmentSelected:(unsigned int)segment{
    if( segment < self.buttonArray.count ) return ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected;
    else                                   return NO;
}


-(void)underlineFirstOccuranceOfChar:(char)inChar forSegment:(unsigned int)segment{
    
    if(segment < self.buttonArray.count){
        
        // Setup the initial attributed string for the "" Label
        NSDictionary * attrDictNorm    = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:self.tintColor};
        
        NSDictionary * attrDictHigh    = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:self.tintColor};
        
        NSDictionary * attrDictSel     = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:[UIColor clearColor]};
        
        NSDictionary * attrDictSelHigh = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:[UIColor clearColor]};
        
        // Make the first occurance of " underlined for the "Visible Light Limits" Label
        NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictNorm];
        
        NSRange charRange = [[title string] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%c", inChar]]];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateNormal];
        
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictHigh];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateHighlighted];
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictSel];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateSelected];
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictSelHigh];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateSelected | UIControlStateHighlighted];
        
    } // END --> if(segment < self.buttonArray.count)
    
    [self setNeedsDisplay];
    
}


-(void)setStaticWidth:(unsigned int)width forSegment:(unsigned int)segment{
    
    
    
} // END --> -(void)setStaticWidth:(unsigned int)width forSegment:(unsigned int)segment


/*
 *
 */
-(void)buttonAction:(id)sender{
    
    if( YES == self.allowsMultipleSelection ){
        for(unsigned int i = 0; i < self.buttonArray.count; i++){
            if( sender == [self.buttonArray objectAtIndex:i] ){
                //NSLog(@"User touched index %i", i);
                [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) setSelected:![((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) isSelected]];
            }
        } // END --> for(unsigned int i = 0; i < self.buttonArray.count; i++) <--
    }else{
        for(unsigned int i = 0; i < self.buttonArray.count; i++){
            if( sender == [self.buttonArray objectAtIndex:i] ){
                //NSLog(@"User touched index %i", i);
                [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) setSelected:YES];
                _selectedSegmentIndex = i;
            }else{
                [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:i]) setSelected:NO];
            }
        } // END --> for(unsigned int i = 0; i < self.buttonArray.count; i++) <--
    } // if( YES == allowsMultipleSelection ) <--
    
    // Fire the action to the above caller
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

@end






