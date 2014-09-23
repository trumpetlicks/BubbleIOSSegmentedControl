//
//  BubbleSegmentedControl.h
//  Bubble Spectrum iPad
//
//  Created by Ryan Shier on 8/7/14.
//
//

#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark BubbleIOSSegmentedControl Dictionary Keys
#define BubbleIOSSegmentedControlSegmentName                    @"BubbleIOSSegmentedControlSegmentName"
#define BubbleIOSSegmentedControlSegmentSize                    @"BubbleIOSSegmentedControlSegmentSize"

#define BubbleIOSSegmentedControlSegmentUnSelectedBackingColor  @"BubbleIOSSegmentedControlSegmentUnSelectedBackingColor"
#define BubbleIOSSegmentedControlSegmentSelectedBackingColor    @"BubbleIOSSegmentedControlSegmentSelectedBackingColor"

#define BubbleIOSSegmentedControlSegmentUnSelectedFontColor     @"BubbleIOSSegmentedControlSegmentUnSelectedFontColor"
#define BubbleIOSSegmentedControlSegmentSelectedFontColor       @"BubbleIOSSegmentedControlSegmentSelectedFontColor"


#pragma mark -
#pragma mark Necessary Public enums
typedef enum __SegmentAutoSizingMode{
    SEGMENT_ALL_SEGMENTS_EQUAL,
    SEGMENT_EQUAL_BUFFERING
}SegmentAutoSizingMode;


/*
 *
 */
#pragma mark -
#pragma mark BubbleIOSSegmentedControl Public Interface
@interface BubbleIOSSegmentedControl : UIControl

@property (nonatomic, retain)                      NSMutableArray * buttonArray;
@property (readonly, getter = getNumberOfSegments) unsigned int numberOfSegments;
@property (nonatomic)                              int          selectedSegmentIndex;
@property (nonatomic)                              BOOL         allowsMultipleSelection;
@property (nonatomic)                              BOOL         allowsNullSelection;

@property (setter = setAutoSizingMode:, getter = getAutoSizingMode) SegmentAutoSizingMode autoSizingMode;

@property (nonatomic, retain) UIColor * tintColor;

@property (nonatomic, retain) UIColor * unSelectedOutlineColor;
@property (nonatomic, retain) UIColor * selectedOutlineColor;

-(void)setupWithNamesArray:(NSArray *)namesArray;
-(void)setupWithParamsDictionary:(NSDictionary *)paramsDict;

-(void)setAutoSizingMode:(SegmentAutoSizingMode)autoSizeMode;               // This routine will NOT reset any statically sized segments the user has set
-(void)setStaticSize:(unsigned int)size forSegment:(unsigned int)segment;   // This allows the user to set a static size for particular segments
-(void)setUseAutoSizingForSegment:(unsigned int)segment;                    // Essentially resets any static sizing of a segment and forces the segment to use the current auto sizing mode
-(void)setAllSegmentsUseAutoSizing;                                         // Resets all segments to use the current auto sizing mode

// Insertion and removal of segments
-(void)insertSegmentsWithNames:(NSArray *) namesArray atIndex:(int)segment; // 0 places before front, - values place at end, other values place within
-(void)insertSegmentWithName:  (NSString *)name       atIndex:(int)segment; // 0 places before front, - values place at end, other values place within

-(void)removeSegmentsWithNames:(NSArray *)names;
-(void)removeSegmentByString:(NSString *)name;
-(void)removeSegmentAtIndex:(unsigned int)segment;

// Selecting and Deselecting
-(void)selectSegment:(unsigned int)segment;
-(void)deSelectSegment:(unsigned int)segment;
-(void)selectAllSegments;
-(void)deselectAllSegments;
-(void)emulateTouchOnSegment:(unsigned int)segment;


-(BOOL)isSegmentSelected:(unsigned int)segment;

-(void)underlineFirstOccuranceOfChar:(char)inChar forSegment:(unsigned int)segment;

@end
