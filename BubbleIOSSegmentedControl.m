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
#define MODULE_REVISION_STRING                  @"1.0.03"

#define BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS 6.0

#pragma mark -
#pragma mark Custom Functional Macros
#define DEG_TO_RADIANS(x) (((float)(x) * 3.141592654f) / 180.0f)

/*
 *
 */
typedef enum __BubbleIOButtonSegmentType{
    SEGMENT_LEFT,
    SEGMENT_MIDDLE,
    SEGMENT_RIGHT,
    SEGMENT_ONLY    // Use this if there is only a single segment, it will round both sides of the button
} BubbleIOButtonSegmentType;


/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentButton Private Interface
@interface BubbleIOSSegmentButton : UIButton

//@property (nonatomic) BOOL isSelected;
@property (getter=getSegmentType, setter=setSegmentType:) BubbleIOButtonSegmentType segmentType;
@property (nonatomic)                                     BOOL                      isStaticSize;

// If this property is set, it will automatically set all other colors to it as the blanket color
@property (nonatomic, retain, setter=setTintColor:)       UIColor *                 tintColor;

// These colors when set, can change the appearance of all segments for the particular parameter
@property (nonatomic, retain)                             UIColor *                 unselectedOutlineColor;
@property (nonatomic, retain)                             UIColor *                 selectedOutlineColor;

@property (nonatomic, retain)                             UIColor *                 unselectedFillColor;
@property (nonatomic, retain)                             UIColor *                 selectedFillColor;

@property (nonatomic, retain)                             UIColor *                 unselectedFontColor;
@property (nonatomic, retain)                             UIColor *                 selectedFontColor;



//
-(BubbleIOButtonSegmentType)getSegmentType;
-(void)setSegmentType:(BubbleIOButtonSegmentType)segmentType;
-(void)setSegmentColorsWithUSOC:(UIColor *)USOC SOC:(UIColor *)SOC USFC:(UIColor *)USFC SFC:(UIColor *)SFC USFoC:(UIColor *)USFoC SFoC:(UIColor *)SFoC;

@end

/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentButton Implementation
@implementation BubbleIOSSegmentButton

@synthesize segmentType            = _segmentType;
@synthesize isStaticSize           = _isStaticSize;

@synthesize tintColor              = _tintColor;

@synthesize unselectedOutlineColor = _unselectedOutlineColor;
@synthesize selectedOutlineColor   = _selectedOutlineColor;

@synthesize unselectedFillColor    = _unselectedFillColor;
@synthesize selectedFillColor      = _selectedFillColor;

@synthesize unselectedFontColor    = _unselectedFontColor;
@synthesize selectedFontColor      = _selectedFontColor;

#pragma mark -
#pragma mark BubbleIOSSegmentButton Custom Initilization
-(void)initializeSegmentButton{
    self.opaque          = NO;
    self.backgroundColor = [UIColor clearColor];
    _segmentType         = SEGMENT_LEFT;
    _isStaticSize        = NO;
    [self setSelected:NO];
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
    [self setSelected:isSelected];
}

#pragma mark -
#pragma mark Custom Getter and Setter routines
-(void)setTintColor:(UIColor *)tintColor{
    _tintColor              = tintColor;
    
    _unselectedOutlineColor = _tintColor;
    _selectedOutlineColor   = _tintColor;
    
    _unselectedFillColor    = _tintColor;
    _selectedFillColor      = _tintColor;
    
    _unselectedFontColor    = _tintColor;
    _selectedFontColor      = [UIColor clearColor];
    
    [self setNeedsDisplay];
}

-(void)setUnselectedOutlineColor:(UIColor *)unselectedOutlineColor{
    _unselectedOutlineColor = unselectedOutlineColor;
    [self setNeedsDisplay];
}

-(void)setSelectedOutlineColor:(UIColor *)selectedOutlineColor{
    _selectedOutlineColor = selectedOutlineColor;
    [self setNeedsDisplay];
}

-(void)setUnselectedFillColor:(UIColor *)unselectedFillColor{
    _unselectedFillColor = unselectedFillColor;
    [self setNeedsDisplay];
}

-(void)setSelectedFillColor:(UIColor *)selectedFillColor{
    _selectedFillColor = selectedFillColor;
    [self setNeedsDisplay];
}

-(void)setUnselectedFontColor:(UIColor *)unselectedFontColor{
    _unselectedFontColor = unselectedFontColor;
    [self setNeedsDisplay];
}

-(void)setSelectedFontColor:(UIColor *)selectedFontColor{
    _selectedFontColor = selectedFontColor;
    [self setNeedsDisplay];
}

-(void)setSegmentColorsWithUSOC:(UIColor *)USOC SOC:(UIColor *)SOC USFC:(UIColor *)USFC SFC:(UIColor *)SFC USFoC:(UIColor *)USFoC SFoC:(UIColor *)SFoC{
    _unselectedOutlineColor = USOC;
    _selectedOutlineColor   = SOC;
    
    _unselectedFillColor    = USFC;
    _selectedFillColor      = SFC;
    
    _unselectedFontColor    = USFoC;
    _selectedFontColor      = SFoC;
    
    [self setNeedsDisplay];
}

#pragma mark - 
#pragma mark BubbleIOSegmentButton Type Setup (left, middle, right)
-(BubbleIOButtonSegmentType)getSegmentType{
    return _segmentType;
}

-(void)setSegmentType:(BubbleIOButtonSegmentType)segmentType{
    _segmentType = segmentType;
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
        
        CGContextSetFillColorWithColor(ctx, _tintColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, _tintColor.CGColor);
        
        switch (_segmentType) {
            case SEGMENT_LEFT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(270), DEG_TO_RADIANS(180), 1);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(180), DEG_TO_RADIANS(90), 1);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                //CGPathAddLineToPoint(path, nil, cornerRadius, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, 0);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(275), DEG_TO_RADIANS(175), 1);
                CGPathMoveToPoint(path, nil, 0, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(175), DEG_TO_RADIANS(85), 1);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, 0, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2);
                CGPathMoveToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                CGPathAddLineToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2, 0);
                CGContextSetLineWidth(ctx, 2.0);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
            }
                break;
            case SEGMENT_RIGHT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(270), DEG_TO_RADIANS(0), 0);
                CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(0), DEG_TO_RADIANS(90), 0);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, 0);
                CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(265), DEG_TO_RADIANS(5), 0);
                CGPathMoveToPoint(path, nil, frame.size.width, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS);
                CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(355), DEG_TO_RADIANS(95), 0);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2);
                CGPathMoveToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                CGPathAddLineToPoint(path, nil, 0, 0);
                CGPathAddLineToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2, 0);
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
        
        if( self.isHighlighted ) CGContextSetFillColorWithColor(ctx, [_tintColor colorWithAlphaComponent:0.15].CGColor);
        else CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
        
        CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
        
        switch (_segmentType) {
            case SEGMENT_LEFT:{
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(270), DEG_TO_RADIANS(180), 1);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(180), DEG_TO_RADIANS(90), 1);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                //CGPathAddLineToPoint(path, nil, cornerRadius, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(ctx, path);
                CGContextFillPath(ctx);
                
                // Draw the rounded corners on the left
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, 0);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(275), DEG_TO_RADIANS(175), 1);
                CGPathMoveToPoint(path, nil, 0, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS);
                CGPathAddArc(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(175), DEG_TO_RADIANS(85), 1);
                CGContextSetLineWidth(ctx, 1.15);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                
                // Draw the straight line paths
                CGPathRelease(path);
                path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, 0, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2);
                CGPathAddLineToPoint(path, nil, 0, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2);
                CGPathMoveToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height);
                CGPathAddLineToPoint(path, nil, frame.size.width, 0);
                CGPathAddLineToPoint(path, nil, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2, 0);
                CGContextSetLineWidth(ctx, 2.0);
                CGContextAddPath(ctx, path);
                CGContextStrokePath(ctx);
                }
                break;
            case SEGMENT_RIGHT:{
                    CGMutablePathRef path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width / 2, 0);
                    CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(270), DEG_TO_RADIANS(0), 0);
                    CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(0), DEG_TO_RADIANS(90), 0);
                    CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, 0);
                    CGPathCloseSubpath(path);
                    CGContextAddPath(ctx, path);
                    CGContextFillPath(ctx);
                
                    // Draw the rounded corners on the left
                    CGPathRelease(path);
                    path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, 0);
                    CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(265), DEG_TO_RADIANS(5), 0);
                    CGPathMoveToPoint(path, nil, frame.size.width, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS);
                    CGPathAddArc(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS, DEG_TO_RADIANS(355), DEG_TO_RADIANS(95), 0);
                    CGContextSetLineWidth(ctx, 1.15);
                    CGContextAddPath(ctx, path);
                    CGContextStrokePath(ctx);

                    // Draw the straight line paths
                    CGPathRelease(path);
                    path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, nil, frame.size.width, BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS - 2);
                    CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2);
                    CGPathMoveToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, frame.size.height);
                    CGPathAddLineToPoint(path, nil, 0, 0);
                    CGPathAddLineToPoint(path, nil, frame.size.width - BUBBLEIOSSEGMENTEDCONTROL_CORNER_RADIUS + 2, 0);
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

// Functional Properties
@synthesize buttonArray             = _buttonArray;
@synthesize numberOfSegments        = _numberOfSegments;
@synthesize selectedSegmentIndex    = _selectedSegmentIndex;
@synthesize allowsMultipleSelection = _allowsMultipleSelection;
@synthesize allowsNullSelection     = _allowsNullSelection;

@synthesize autoSizingMode          = _autoSizingMode;

// Blanket color for the entire control
@synthesize tintColor               = _tintColor;

// Individual component colors (still at control level)
@synthesize unselectedOutlineColor  = _unselectedOutlineColor;
@synthesize selectedOutlineColor    = _selectedOutlineColor;

@synthesize unselectedFillColor     = _unselectedFillColor;
@synthesize selectedFillColor       = _selectedFillColor;

@synthesize unselectedFontColor     = _unselectedFontColor;
@synthesize selectedFontColor       = _selectedFontColor;

// Private Properties
@synthesize totalSelectedSegments   = _totalSelectedSegments;

#pragma mark -
#pragma mark BubbleIOSSegmentedControl Custom Initialization
-(void)initializeSegmentedControlDefaults{
    // Setup Default parameters, Blue Font and Outline, see through backing
    self.opaque              = NO;
    self.backgroundColor     = [UIColor clearColor];
    _tintColor               = [UIColor colorWithRed:0.0 green:124.0 / 255.0 blue:1.0 alpha:1.0];
    
    _unselectedOutlineColor = _tintColor;
    _selectedOutlineColor   = _tintColor;
    
    _unselectedFillColor    = _tintColor;
    _selectedFillColor      = _tintColor;
    
    _unselectedFontColor    = _tintColor;
    _selectedFontColor      = [UIColor clearColor];
    
    _allowsMultipleSelection = NO;
    _allowsNullSelection     = YES;
    
    _autoSizingMode          = SEGMENT_ALL_SEGMENTS_EQUAL;
    
    _numberOfSegments        = 0;
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
#pragma mark Custom Getters and Setters for Control Properties
-(unsigned int)getNumberOfSegments{
    return _buttonArray.count;
}

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    
    _unselectedOutlineColor = _tintColor;
    _selectedOutlineColor   = _tintColor;
    
    _unselectedFillColor    = _tintColor;
    _selectedFillColor      = _tintColor;
    
    _unselectedFontColor    = _tintColor;
    _selectedFontColor      = [UIColor clearColor];
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.tintColor = _tintColor;
    
    [self setNeedsDisplay];
}

-(UIColor *)getTintColor{
    return _tintColor;
}

-(void)setUnselectedOutlineColor:(UIColor *)unselectedOutlineColor{
    _unselectedOutlineColor = unselectedOutlineColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.unselectedOutlineColor = _unselectedOutlineColor;
    
    [self setNeedsDisplay];
}

-(void)setSelectedOutlineColor:(UIColor *)selectedOutlineColor{
    _selectedOutlineColor = selectedOutlineColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.selectedOutlineColor = _selectedOutlineColor;
    
    [self setNeedsDisplay];
}

-(void)setUnselectedFillColor:(UIColor *)unselectedFillColor{
    _unselectedFillColor = unselectedFillColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.unselectedFillColor = _unselectedFillColor;
    
    [self setNeedsDisplay];
}

-(void)setSelectedFillColor:(UIColor *)selectedFillColor{
    _selectedFillColor = selectedFillColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.selectedFillColor = _selectedFillColor;
        
    [self setNeedsDisplay];
}

-(void)setUnselectedFontColor:(UIColor *)unselectedFontColor{
    _unselectedFontColor = unselectedFontColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.unselectedFontColor = _unselectedFontColor;
    
    [self setNeedsDisplay];
}

-(void)setSelectedFontColor:(UIColor *)selectedFontColor{
    _selectedFontColor = selectedFontColor;
    
    for(BubbleIOSSegmentButton * aButton in _buttonArray) aButton.selectedFontColor = _selectedFontColor;
    
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Private Segment Resizing Helpers
-(void)resizeSegmentsAllEqualHorizontal{
    
    // Lets make sure that we actually have an array of buttons to work with, and that the count of buttons is greater than 1
    if( nil != _buttonArray && _buttonArray.count > 1 ){
    
        unsigned int autoSizedButtonWidth     = (int)self.frame.size.width;
        unsigned int amountStaticSizedButtons = 0;
        for(BubbleIOSSegmentButton * aButton in _buttonArray){
            if( YES == aButton.isStaticSize ){
                autoSizedButtonWidth -= aButton.frame.size.width;
                amountStaticSizedButtons++;
            }
        }
        
        // If the amount of statically sized buttons is equal to the total amount of buttons, there is no work to do
        if( amountStaticSizedButtons == _buttonArray.count ) return;
        else{
        
            unsigned int excess     = autoSizedButtonWidth % ( _buttonArray.count - amountStaticSizedButtons );
            autoSizedButtonWidth   /= ( _buttonArray.count - amountStaticSizedButtons );
            unsigned int runningX   = 0;
            
            for(unsigned int buttonCount = 0; buttonCount < _buttonArray.count; buttonCount++){
                
                // Check to see if the button has been set to a static size
                if( YES == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).isStaticSize ){
                    ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0,
                                                                                                             0,
                                                                                                             ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame.size.width,
                                                                                                             self.bounds.size.height);
                    runningX += ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame.size.width;
                }else{
                
                    // If the current button being re-sized is the leftmost or rightmost, add the excess pixels to those
                    if      ( 0 == buttonCount ){
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + (excess / 2) + (excess % 2),
                                                                                                                 self.bounds.size.height);
                        runningX += ( autoSizedButtonWidth + (excess / 2) + (excess % 2) );
                    }else if( ( _buttonArray.count - 1 ) == buttonCount ){
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + 1 + (excess / 2),
                                                                                                                 self.bounds.size.height);
                        runningX += ( autoSizedButtonWidth + (excess / 2) );
                    }else{
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + 1,
                                                                                                                 self.bounds.size.height);
                        runningX += autoSizedButtonWidth;
                    } // END --> if( 0 == buttonCount )
                
                } // END --> if( YES == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).isStaticSize )
                
            } // END --> for(unsigned int buttonCount = 0; buttonCount < buttonArray.count; buttonCount++) <--
            
            [self setNeedsDisplay];
        
        } // END --> if( amountStaticSizedButtons == _buttonArray.count )
        
    } // END --> if( nil != _buttonArray && _buttonArray.count > 1 )
    
} // END --> -(void)resizeSegmentsAllEqualHorizontal

-(void)resizeSegmentsEqualBufferingHorizontal{
    
    // Lets make sure that we actually have an array of buttons to work with, and that the count of buttons is greater than 1
    if( nil != _buttonArray && _buttonArray.count > 1 ){
        
        unsigned int autoSizedButtonWidth              = (int)self.frame.size.width;
        unsigned int amountStaticSizedButtons          = 0;
        unsigned int totalWidthOfNonStaticSizedContent = 0;
        for(BubbleIOSSegmentButton * aButton in _buttonArray){
            if( YES == aButton.isStaticSize ){
                autoSizedButtonWidth -= aButton.frame.size.width;
                amountStaticSizedButtons++;
            }else{
                totalWidthOfNonStaticSizedContent += (unsigned int)[[aButton attributedTitleForState:UIControlStateNormal] size].width;
            }
        }
        
        // If the amount of statically sized buttons is equal to the total amount of buttons, there is no work to do
        if( amountStaticSizedButtons == _buttonArray.count ) return;
        else{
            
            autoSizedButtonWidth   -= totalWidthOfNonStaticSizedContent;
            unsigned int excess     = autoSizedButtonWidth % ( _buttonArray.count - amountStaticSizedButtons );
            autoSizedButtonWidth   /= ( _buttonArray.count - amountStaticSizedButtons );
            unsigned int runningX   = 0;
            
            for(unsigned int buttonCount = 0; buttonCount < _buttonArray.count; buttonCount++){
                
                // Check to see if the button has been set to a static size
                if( YES == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).isStaticSize ){
                    ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0,
                                                                                                             0,
                                                                                                             ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame.size.width,
                                                                                                             self.bounds.size.height);
                    runningX += ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame.size.width;
                }else{
                    
                    // If the current button being re-sized is the leftmost or rightmost, add the excess pixels to those
                    if      ( 0 == buttonCount ){
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width + (excess / 2) + (excess % 2),
                                                                                                                 self.bounds.size.height);
                        runningX += ( autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width + (excess / 2) + (excess % 2) );
                    }else if( ( _buttonArray.count - 1 ) == buttonCount ){
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width + 1 + (excess / 2),
                                                                                                                 self.bounds.size.height);
                        runningX += ( autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width + (excess / 2) );
                    }else{
                        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                                 0,
                                                                                                                 autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width + 1,
                                                                                                                 self.bounds.size.height);
                        runningX += ( autoSizedButtonWidth + (unsigned int)[[((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]) attributedTitleForState:UIControlStateNormal] size].width );
                    } // END --> if( 0 == buttonCount )
                    
                } // END --> if( YES == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).isStaticSize )
                
            } // END --> for(unsigned int buttonCount = 0; buttonCount < buttonArray.count; buttonCount++) <--
            
            [self setNeedsDisplay];
            
        } // END --> if( amountStaticSizedButtons == _buttonArray.count )
        
    } // END --> if( nil != _buttonArray && _buttonArray.count > 1 )
    
} // END -->-(void)resizeSegmentsEqualBufferingHorizontal

#pragma mark -
#pragma mark BubbleIOSSegmentedControl Segment Setup Routines
-(void)setupWithSpaceForN:(unsigned int)segments{
    
    // If array exists already, clear it, if not, create it
    if( nil != _buttonArray ) [_buttonArray removeAllObjects];
    else                      _buttonArray = [NSMutableArray array];
    
    // Create the buttons, and add them to the button array
    for(unsigned int i = 0; i < segments; i++){
        BubbleIOSSegmentButton  * newButton = [BubbleIOSSegmentButton  buttonWithType:UIButtonTypeCustom];
        newButton.backgroundColor           = self.backgroundColor;
        newButton.tintColor                 = [_tintColor copy];
        newButton.isSelected                = NO;
        newButton.isStaticSize              = NO;
        newButton.segmentType               = SEGMENT_MIDDLE;
        
        [newButton addTarget:self
                      action:@selector(buttonAction:)
            forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
        [_buttonArray addObject:newButton];
    }
    
    [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:0]) setSegmentType:SEGMENT_LEFT];
    [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:(_buttonArray.count - 1)]) setSegmentType:SEGMENT_RIGHT];
    
}

-(void)setupWithNamesArray:(NSArray *)namesArray{
    
    if( nil != namesArray && namesArray.count > 0){
        
        _buttonArray = [NSMutableArray array];
        
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
                
                newButton.isSelected   = NO;
                newButton.isStaticSize = NO;
                newButton.segmentType  = SEGMENT_MIDDLE;
                [newButton addTarget:self
                              action:@selector(buttonAction:)
                    forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
                [_buttonArray addObject:newButton];
            }
        }
        
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:0]) setSegmentType:SEGMENT_LEFT];
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:(_buttonArray.count - 1)]) setSegmentType:SEGMENT_RIGHT];
        
        unsigned int mainButtonWidth = (int)self.frame.size.width / _buttonArray.count;
        unsigned int excess          = (int)self.frame.size.width % _buttonArray.count;
        unsigned int runningX        = 0;
        
        for(unsigned int buttonCount = 0; buttonCount < _buttonArray.count; buttonCount++){
            
            if      ( 0 == buttonCount ){
                ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(0,
                                                                                                         0,
                                                                                                         mainButtonWidth + (excess / 2) + (excess % 2),
                                                                                                         self.bounds.size.height);
                runningX += ( mainButtonWidth + (excess / 2) + (excess % 2) );
            }else if( ( _buttonArray.count - 1 ) == buttonCount){
                ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                         0,
                                                                                                         mainButtonWidth + 1 + (excess / 2),
                                                                                                         self.bounds.size.height);
                runningX += ( mainButtonWidth + (excess / 2) );
            }else{
                ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount]).frame = CGRectMake(runningX - 1,
                                                                                                         0,
                                                                                                         mainButtonWidth + 1,
                                                                                                         self.bounds.size.height);
                runningX += mainButtonWidth;
            }
            
            [self addSubview:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:buttonCount])];
            
        } // END --> for(unsigned int buttonCount = 0; buttonCount < buttonArray.count; buttonCount++) <--
        
    } // END --> if( nil != namesArray && namesArray.count > 0) <--
    
    [self setNeedsDisplay];
    
} // END --> -(void)initWithNamesArray:(NSArray *)namesArray

-(void)setupWithParamsDictionary:(NSDictionary *)paramsDict{
    
}

#pragma mark -
#pragma mark Setting Segment Sizing
-(SegmentAutoSizingMode)getAutoSizingMode{
    return _autoSizingMode;
}

-(void)setAutoSizingMode:(SegmentAutoSizingMode)autoSizingMode{
    // Lets check to see if we are even changing the mode before we tell the display to update
    if(autoSizingMode != _autoSizingMode && autoSizingMode <= SEGMENT_EQUAL_BUFFERING && nil != _buttonArray){
        
        _autoSizingMode = autoSizingMode;
        switch(_autoSizingMode) {
            case SEGMENT_EQUAL_BUFFERING:
                [self resizeSegmentsEqualBufferingHorizontal];
                break;
            default:
                [self resizeSegmentsAllEqualHorizontal];
                break;
        }
        
    }
}

-(void)setStaticSize:(unsigned int)size forSegment:(unsigned int)segment{
    if( segment < _buttonArray.count ){
        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isStaticSize = YES;
        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).frame = CGRectMake(((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).frame.origin.x,
                                                                                             0,
                                                                                             size,
                                                                                             self.bounds.size.height);
        
        // Now we need to resize all of the other segments because of the static size we just set for the user intputted segment
        switch(_autoSizingMode){
            case SEGMENT_EQUAL_BUFFERING:
                [self resizeSegmentsEqualBufferingHorizontal];
                break;
            default:
                [self resizeSegmentsAllEqualHorizontal];
                break;
        }
    }
}

-(void)setUseAutoSizingForSegment:(unsigned int)segment{
    if( segment < _buttonArray.count && YES == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isStaticSize ){
        ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isStaticSize = NO;
        
        switch(_autoSizingMode) {
            case SEGMENT_EQUAL_BUFFERING:
                [self resizeSegmentsEqualBufferingHorizontal];
                break;
            default:
                [self resizeSegmentsAllEqualHorizontal];
                break;
        }
    }
}

-(void)setAllSegmentsUseAutoSizing{
    unsigned int segmentCount = 0;
    for(BubbleIOSSegmentButton * aButton in _buttonArray){
        if( YES == aButton.isStaticSize ){
            aButton.isStaticSize = NO;
            segmentCount++;
        }
    }
    
    // Lets only redraw if there were indeed segments whose state actually changed
    if(segmentCount > 0){
        switch(_autoSizingMode) {
            case SEGMENT_EQUAL_BUFFERING:
                [self resizeSegmentsEqualBufferingHorizontal];
                break;
            default:
                [self resizeSegmentsAllEqualHorizontal];
                break;
        }
        
        [self setNeedsDisplay];
    }
}



-(void)insertSegmentsWithNames:(NSArray *)namesArray atIndex:(int)segment{
    
}

-(void)insertSegmentWithName:(NSString *)name atIndex:(int)segment{
    
}

-(void)removeSegmentsWithNames:(NSArray *)names{
    
}

-(void)removeSegmentByString:(NSString *)name{
    
}

-(void)removeSegmentAtIndex:(unsigned int)segment{
    
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
        
        for(unsigned int index = 0; index < _buttonArray.count; index++){
            if( index == _selectedSegmentIndex ) [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:index]) setSelected:YES];
            else                                 [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:index]) setSelected:NO];
        }
    }
}

-(void)selectSegment:(unsigned int)segment{
    if( _totalSelectedSegments < 1 ){
        if( segment < _buttonArray.count && ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected == NO ){
            [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:YES];
            _totalSelectedSegments = 1;
        }
    }else{
        if( YES == _allowsMultipleSelection )   // Only allow the NEW selection IFF we are in allow multiple selection mode
            if( segment < _buttonArray.count && ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected == NO ){
                [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:YES];
                _totalSelectedSegments++;
            }
    }
}

-(void)deSelectSegment:(unsigned int)segment{
    if( _totalSelectedSegments > 1 ){
        if( segment < _buttonArray.count && ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected == YES ){
            [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:NO];
            _totalSelectedSegments--;
        }
    }else{
        if( YES == _allowsNullSelection ){
            if( segment < _buttonArray.count && ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected == YES ){
                [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:NO];
                _totalSelectedSegments--;
            }
        }
    }
}

-(void)selectAllSegments{
    if( YES == _allowsMultipleSelection ) _totalSelectedSegments = _buttonArray.count;
    else                                  _totalSelectedSegments = 1;
    
    for(unsigned short segment = 0; segment < _totalSelectedSegments; segment++)
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:YES];
}

-(void)deselectAllSegments{
    if( YES == _allowsNullSelection ) _totalSelectedSegments = 0;
    else                              _totalSelectedSegments = 1;
    
    for(unsigned short segment = _totalSelectedSegments; segment < _buttonArray.count; segment++)
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setSelected:NO];
}

-(void)emulateTouchOnSegment:(unsigned int)segment{
    
    // Ensure the user is asking to emulate a touch on a segment that exists
    if( segment < _buttonArray.count ){
        if( NO == ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected ) [self selectSegment:  segment];
        else                                                                                         [self deSelectSegment:segment];
    }// END --> if(segment < buttonArray.count)
    
}

-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection{
    _allowsMultipleSelection = allowsMultipleSelection;
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
    if( segment < _buttonArray.count ) return ((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).isSelected;
    else                                   return NO;
}


-(void)underlineFirstOccuranceOfChar:(char)inChar forSegment:(unsigned int)segment{
    
    if(segment < _buttonArray.count){
        
        // Setup the initial attributed string for the "" Label
        NSDictionary * attrDictNorm    = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:self.tintColor};
        
        NSDictionary * attrDictHigh    = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:self.tintColor};
        
        NSDictionary * attrDictSel     = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:[UIColor clearColor]};
        
        NSDictionary * attrDictSelHigh = @{NSFontAttributeName:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.font,
                                           NSForegroundColorAttributeName:[UIColor clearColor]};
        
        // Make the first occurance of " underlined for the "Visible Light Limits" Label
        NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictNorm];
        
        NSRange charRange = [[title string] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%c", inChar]]];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateNormal];
        
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictHigh];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateHighlighted];
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictSel];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateSelected];
        
        title = [[NSMutableAttributedString alloc] initWithString:((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]).titleLabel.text attributes:attrDictSelHigh];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:charRange];
        [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:segment]) setAttributedTitle:title forState:UIControlStateSelected | UIControlStateHighlighted];
        
    } // END --> if(segment < _buttonArray.count)
    
    [self setNeedsDisplay];
    
}


/*
 *
 */
-(void)buttonAction:(id)sender{
    
    if( YES == self.allowsMultipleSelection ){
        for(unsigned int i = 0; i < _buttonArray.count; i++){
            if( sender == [_buttonArray objectAtIndex:i] ){
                //NSLog(@"User touched index %i", i);
                [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:i]) setSelected:![((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:i]) isSelected]];
            }
        } // END --> for(unsigned int i = 0; i < _buttonArray.count; i++) <--
    }else{
        for(unsigned int i = 0; i < _buttonArray.count; i++){
            if( sender == [_buttonArray objectAtIndex:i] ){
                //NSLog(@"User touched index %i", i);
                [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:i]) setSelected:YES];
                _selectedSegmentIndex = i;
            }else{
                [((BubbleIOSSegmentButton  *)[_buttonArray objectAtIndex:i]) setSelected:NO];
            }
        } // END --> for(unsigned int i = 0; i < _buttonArray.count; i++) <--
    } // if( YES == allowsMultipleSelection ) <--
    
    // Fire the action to the above caller
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

@end
