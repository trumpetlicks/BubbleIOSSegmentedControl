//
//  BubbleSegmentedControl.h
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 8/7/14.
//
//

#import <UIKit/UIKit.h>

typedef enum __segmentType{
    SEGMENT_LEFT,
    SEGMENT_MIDDLE,
    SEGMENT_RIGHT
} segmentType;


/*
 *
 */
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
@interface BubbleIOSSegmentedControl : UIControl{
    @public
    
    
    @private
}

@property (nonatomic, retain) NSMutableArray * buttonArray;
@property (nonatomic)         int              selectedSegmentIndex;
@property (nonatomic)         BOOL             allowsMultipleSelection;
@property (nonatomic)         BOOL             allowsNullSelection;

@property (nonatomic, retain) UIColor * tintColor;

@property (nonatomic, retain) UIColor * unSelectedOutlineColor;
@property (nonatomic, retain) UIColor * selectedOutlineColor;

-(void)setupWithNamesArray:(NSArray *)namesArray;
-(void)insertSegments:(NSArray *)namesArray atIndex:(int)segment; // 0 places before front, - values place at end, other values place within
-(void)insertSegment:(NSString *)name after:(int)segment; // 0 places before front, - values place at end, other values place within

-(void)removeSegmentsWithNames:(NSArray *)names;
-(void)removeSegmentByString:(NSString *)name;
-(void)removeSegmentAtIndex:(unsigned int)segment;

-(void)selectSegment:(unsigned int)segment;
-(void)deSelectSegment:(unsigned int)segment;
-(void)selectAllSegments;
-(void)deselectAllSegments;
-(void)emulateTouchOnSegment:(unsigned int)segment;

-(BOOL)isSegmentSelected:(unsigned int)segment;

-(void)underlineFirstOccuranceOfChar:(char)inChar forSegment:(unsigned int)segment;

-(void)setStaticWidth:(unsigned int)width forSegment:(unsigned int)segment;

@end
