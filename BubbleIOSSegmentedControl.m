//
//  BubbleSegmentedControl.m
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 8/7/14.
//
//

#import "BubbleIOSSegmentedControl.h"

#pragma mark -
#pragma mark Custom Macro Constants
#define MODULE_REVISION_STRING  @"1.0.02"

#pragma mark -
#pragma mark Custom Functional Macros
#define DEG_TO_RADIANS(x) (((float)(x) * 3.141592654f) / 180.0f)

/*
 *
 */
typedef enum __segmentType{
    SEGMENT_LEFT,
    SEGMENT_MIDDLE,
    SEGMENT_RIGHT
} segmentType;


/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentButton Private Interface
@interface BubbleIOSSegmentButton : UIButton{
    segmentType myType;
    
@private
    unsigned int cornerRadius;
}

//@property (nonatomic) BOOL isSelected;
@property (nonatomic)         BOOL      autoCalculateWidth;
@property (nonatomic, retain) UIColor * tintColor;

//
-(void)setSegmentType:(segmentType)aType;

@end

/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentButton Implementation
@implementation BubbleIOSSegmentButton

@synthesize tintColor;

#pragma mark -
#pragma mark BubbleIOSSegmentButton Custom Initilization
-(void)initializeSegmentButton{
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    [self setSelected:NO];
    
    myType = SEGMENT_LEFT;
    self.autoCalculateWidth = YES;
    
    cornerRadius = 6;
}

#pragma mark -
#pragma mark BubbleIOSSegmentButton  Overridden Initialization
-(id)init{
    if( self = [super init] ) [self initializeSegmentButton];
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame] ) [self initializeSegmentButton];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) [self initializeSegmentButton];
    return self;
}

#pragma mark -
#pragma mark BubbleIOSegmentButton Overridden routine for setting the button selected
-(void)setIsSelected:(BOOL)isSelected{
    [self setIsSelected:isSelected];
}

#pragma mark - 
#pragma mark BubbleIOSegmentButton Type Setup (left, middle, right)
-(void)setSegmentType:(segmentType)aType{
    myType = aType;
    [self setNeedsDisplay];
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark BubbleIOSegmentButton Custom Drawing
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
#pragma mark -
#pragma mark BubbleIOSSegmentedControl Private Interface
@interface BubbleIOSSegmentedControl ()

@property unsigned short totalSelectedSegments;

@end


/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentedControl Implementation
@implementation BubbleIOSSegmentedControl

@synthesize buttonArray             = _buttonArray;
@synthesize allowsMultipleSelection = _allowsMultipleSelection;
@synthesize allowsNullSelection     = _allowsNullSelection;
@synthesize selectedSegmentIndex    = _selectedSegmentIndex;
@synthesize tintColor               = _tintColor;

@synthesize totalSelectedSegments   = _totalSelectedSegments;

#pragma mark -
#pragma mark BubbleIOSSegmentedControl Custom Initialization
-(void)initializeSegmentedControlDefaults{
    // Setup Default parameters, Blue Font and Outline, see through backing
    self.opaque              = NO;
    self.backgroundColor     = [UIColor clearColor];
    _tintColor               = [UIColor colorWithRed:0.0 green:124.0 / 255.0 blue:1.0 alpha:1.0];
    _allowsMultipleSelection = NO;
    _allowsNullSelection     = YES;
    
    _totalSelectedSegments   = 0;
}

#pragma mark -
#pragma mark BubbleIOSSegmentedControl Overridden Initialization
-(id)init{
    if( self = [super init] ) [self initializeSegmentedControlDefaults];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if( self = [super initWithCoder:aDecoder] ) [self initializeSegmentedControlDefaults];
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if( self  = [super initWithFrame:frame] ) [self initializeSegmentedControlDefaults];
    return self;
}

#pragma mark -
#pragma mark Programmatic Segment Selection
-(void)setSelectedSegmentIndex:(int)selectedSegmentIndex{
    if( NO == _allowsMultipleSelection ){
        
        if( selectedSegmentIndex < 0 ){             // "selectedSegmentIndex < 0" is essentially UISegmentedControlNoSegment
            if( YES == _allowsNullSelection ){      // if we allow null selection, deselect all segments, else leave the currently selected segment alone
                _selectedSegmentIndex  = UISegmentedControlNoSegment;
                _totalSelectedSegments = 0;
            }
        }else{
            if( selectedSegmentIndex > ( _buttonArray.count - 1 ) ){
                if( YES == _allowsNullSelection ){  // The control allows for NULL selection
                    _selectedSegmentIndex  = UISegmentedControlNoSegment;
                    _totalSelectedSegments = 0;
                }else{                              // The control does NOT allow for NULL selection
                    selectedSegmentIndex   = _buttonArray.count - 1;
                    _totalSelectedSegments = 1;
                }
            }else{  // The attempted selection is within range
                _selectedSegmentIndex  = selectedSegmentIndex;
                _totalSelectedSegments = 1;
            }
        }
        
        for(unsigned int index = 0; index < self.buttonArray.count; index++){
            if( index == _selectedSegmentIndex ) [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:index]) setSelected:YES];
            else                                 [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:index]) setSelected:NO];
        }
    }
}

-(void)selectSegment:(unsigned int)segment{
    if( _totalSelectedSegments < 1 ){
        if( segment < self.buttonArray.count && ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected == NO ){
            [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:YES];
            _totalSelectedSegments = 1;
        }
    }else{
        if( YES == _allowsMultipleSelection )   // Only allow the NEW selection IFF we are in allow multiple selection mode
            if( segment < self.buttonArray.count && ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected == NO ){
                [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:YES];
                _totalSelectedSegments++;
            }
    }
}

-(void)deSelectSegment:(unsigned int)segment{
    if( _totalSelectedSegments > 1 ){
        if( segment < self.buttonArray.count && ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected == YES ){
            [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:NO];
            _totalSelectedSegments--;
        }
    }else{
        if( YES == _allowsNullSelection ){
            if( segment < self.buttonArray.count && ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected == YES ){
                [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:NO];
                _totalSelectedSegments--;
            }
        }
    }
}

-(void)selectAllSegments{
    if( YES == _allowsMultipleSelection ) _totalSelectedSegments = _buttonArray.count;
    else                                  _totalSelectedSegments = 1;
    
    for(unsigned short segment = 0; segment < _totalSelectedSegments; segment++)
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:YES];
}

-(void)deselectAllSegments{
    if( YES == _allowsNullSelection ) _totalSelectedSegments = 0;
    else                              _totalSelectedSegments = 1;
    
    for(unsigned short segment = _totalSelectedSegments; segment < _buttonArray.count; segment++)
        [((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]) setSelected:NO];
}

-(void)emulateTouchOnSegment:(unsigned int)segment{
    
    // Ensure the user is asking to emulate a touch on a segment that exists
    if( segment < _buttonArray.count ){
        if( NO == ((BubbleIOSSegmentButton  *)[self.buttonArray objectAtIndex:segment]).isSelected ) [self selectSegment:  segment];
        else                                                                                         [self deSelectSegment:segment];
    }// END --> if(segment < buttonArray.count)
    
}

#pragma mark -
#pragma mark BubbleIOSSegmentedControl Segment Setup Routines
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

-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection{
    _allowsMultipleSelection = allowsMultipleSelection;
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

#pragma mark -
#pragma mark BubbleIOSSegmentedControl High Level Control Parameter Setup
-(void)setAllowsNullSelection:(BOOL)allowsNullSelection{
    if( NO == allowsNullSelection ){
        
    }else{
        _allowsNullSelection = allowsNullSelection;
    }
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






