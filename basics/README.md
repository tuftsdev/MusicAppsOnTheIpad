#About the iPad and iOS#
* iOS is a slimmed down version of Mac OS X
* Limited memory
* Services (e.g., audio, location, push button notifications)
* User input: touch and gesture-based; very different than traditional desktop software development
* Internet access: be careful depending on it! Options: Wi-Fi, none, or 3G/4G
* Built-in capabilities (e.g., GPS, camera)
* App runtime:
  * Immediacy, fast
  * Secure; sandboxed apps. That is, an app cannot access other apps' data
* Multitasking
  * More than 1 app can run at the same time
  * But user can only interface / interact with one at a time
  * When memory is low, system purges app(s) that have not been used (and saves data)
* When system does not detect touch for a long time, screen dims, then turns off
* Running apps still reside in memory but does not execute code

#Anatomy of an App#
  * Again, sandboxed apps
  * Apps are installed to `/AppRoot`
  * Every app has an `AppId`

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
    
#Life Cycle of an App#

#Interface Builder#

#Your First App#
  * See `SimpleApp` project
  
#iOS Simulator#
  * The best simulator we got!
  * Very different than hardware
  
#Windows, Views, and Widgets#
  * A window is an instance of `UIWindow`; an empty surface to host one or more views
  * Apps must have one window
  * A view is an instance of `UIView`:
    * Defines content for a rectangular region of window
    * For drawing, interaction, animation, etc.
    * A view can hold a number of widgets
  * Widgets: buttons, labels, sliders, pickers, etc.

#Delegates and Protocols#

#Model-View-Controller (MVC) Design Pattern#
  * Separation of logic
  * Defines roles objects play in app
  * Defines the way objects communicate with each other
  * Abstraction
  * In short: modifying either model or view has no effect on on another
  * The value of MVC, think about it: what if Apple comes out with another device which the view is programmed differently than on the iPad or iPhone?
