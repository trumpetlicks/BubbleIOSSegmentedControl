BubbleIOSSegmentedControl
=========================

Similar to Apple's UISegmentedControl only supports text underlining and other attributes.  Also supports multiple selection.

This is a custom segmented control object for iOS (that looks like the iOS 7 variant)

I created this object because when upgrading one of my Bubble Imagineering published apps, and trying to add external keyboard
interfacing, I wanted to be able to underline the letters of the keyboard shortcut.  I also wanted the control to look the same
between iOS 6 and 7.

This Object looks extremely similar to the iOS 7 variant, only is more customizable.

Drawing
=================
This object will draw as wide as you like, but will always be 30 px high.  It will always draw at the top left of whatever
rect the control is initialized with.


TO USE
=================
the easiest way is:
  - Include both the .h and .m files within your project  
  - put a standard UIView on whatever view you wish to have the switch on, within your xib file.
  - define that newly placed UIView as a "BubbleIOSSegmentedControl" within the xib file.
  - the UIView should be sized no smaller than 30 px high (it can be larger, but look at the drawing note above) and any width.
  - In your viewDidLoad routine for the encapsulating UIViewController, utilize the setupWithNamesArray routine:
    (ex. [yourSegmentControl setupWithNamesArray:@[@"segment 1", @"segment 2", @"segment 3"]];)
  - If you want to underline a letter (as I was using it for):
    (ex. [yourSegmentControl underlineFirstOccuranceOfChar:'s' forSegment:0];)
  
Version History
=================
v1.0 - initial upload

Future Releases
=================
- Potentially a vertially oriented version (as opposed to horizontally functioning)
- Ability to add and remove segments at runtime
- Ability to customize outline and internal colors of unselected and selected state segmenets
- Ability to add images to each segment
- Ability to auto-size all segments besed upon content, currently all segments are sized the same regardless of if the contents
  fit or not.
- The ability to define SPECIFIC sizes for each segment
