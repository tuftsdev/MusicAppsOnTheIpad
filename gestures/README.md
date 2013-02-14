#Overview#
* Gestures: combination of touch events
* Must be added to instances of the `UIView` class
* A single view can have more than one gesture recognizer

#The Gesture Recognizers in iOS#
* Swipe (`UISwipeGestureRecognizer`)
* Rotation (`UIRotationGestureRecognizer`)
* Pinch (`UIPinchGestureRecognizer`)
* Pan (`UIPanGestureRecognizer`)
* Long press (`UILongPressGestureRecognizer`)
* Tap (`UITapGestureRecognizer`)

#Implementation of a Gesture#
1. Choose the gesture recognizer that you want
2. Create an action to respond to the gesture
  * This method must return void
  * It must either accept no parameters, or accept a single parameter of type `UIGestureRecognizer *` in which the system will pass the gesture recognizer that calls this method
3. Instantiate an instance of the gesture recognizer and specify the name of the callback action
4. Add gesture recognizer to the view via `addGestureRecognizer`
