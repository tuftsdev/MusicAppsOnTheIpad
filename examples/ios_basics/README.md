#The Cocoa Touch Framework#
* Series of frameworks that include:
  * UIKit (based on Application Kit)
    * Provides key objects needed to run apps
    * Coordinates handling of user input
    * Coordinates display of content on screen
  * Foundation
  * Game Kit
  * iAd
  * Map Kit
    * Core Audio

#Model-View-Controller (MVC) Design Pattern#
* Separation of logic
* Defines roles objects play in app
* Defines the way objects communicate with each other
* Abstraction
* In short: modifying either model or view has no effect on on another
* The value of MVC, think about it: what if Apple comes out with another device which the view is programmed differently than on the iPad or iPhone?

#Your First App#
* See `SimpleApp` project
    
#Interface Builder#
* Good for building widget-based interfaces
* `.xib` (pronounced NIB file)
* Not good for games, anything that requires the drawing surface
 
#iOS Simulator#
* The best simulator we got!
* Very different than hardware
* Typically, networking is faster on the simulator
* Can't simulate multitouch (e.g., the three-finger salute variety)
  
#Windows, Views, and Widgets#
* A window is an instance of `UIWindow`; an empty surface to host one or more views
* Apps must have one window
* A view is an instance of `UIView`:
  * Defines content for a rectangular region of window
  * For drawing, interaction, animation, etc.
  * A view can hold a number of widgets
* Widgets: buttons, labels, sliders, pickers, etc.

#References#
* *iOS App Programming Guide* https://developer.apple.com/library/ios/documentation/iphone/conceptual/iphoneosprogrammingguide/iphoneappprogrammingguide.pdf