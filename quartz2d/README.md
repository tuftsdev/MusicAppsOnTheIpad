#Overview#
* Two ways to render 2D graphics on iOS:
  * Quartz 2D
  * OpenGL (we'll not discuss this)

#Implementation#
* Must subclass `UIView`
* Change the class of your `.xib` file to the subclass (in Interface Builder)
* Override the method `-(void)drawRect:(CGRect)rect` in your subclass. This is where you do all your drawing stuff.
* But what about initialization in your subclass (e.g., for gesture recognizers)?
  * Override the method `- (id)initWithCoder:(NSCoder *)aDecoder` in your subclass
  * From the `UIView` class reference: "If you use Interface Builder to design your interface, this method (`initWithFrame:`) is not called when your view objects are subsequently loaded from the nib file. Objects in a nib file are reconstituted and then initialized using their initWithCoder: method, which modifies the attributes of the view to match the attributes stored in the nib file. For detailed information about how views are loaded from a nib file, see Resource Programming Guide."
  * Another method: `- (id)initWithFrame:(CGRect)frame`; Initializes and returns a newly allocated view object with the specified frame rectangle.
#The Drawing Context#
* Represents a drawing destination (e.g., the surface or canvas)
* `CGContextRef currentContext = UIGraphicsGetCurrentContext();`

#Redrawing#
* Call `[self setNeedsDisplay];` which will call `drawRect`

#References#
* https://developer.apple.com/library/ios/#documentation/graphicsimaging/conceptual/drawingwithquartz2d/Introduction/Introduction.html
