#Overview:#
* Object-Oriented Programming Language
* Circa 1980
* Originated at NeXT which was bought out by Apple
* Ideally used for interchangable software components
* Based on Smalltalk
* Strict superset of C; any Obj-C compiler can compile a C program
* Based on "message passing".  That is, you do not call a function but you send a message!
* In iOS, the LLVM Clang (clang) compiler is used, not gcc

#The Usual Gang#
* Comments
* cAsE sEnSiTiVe
* Operations and operands
* Most data types
* for, while, if
* Pointer variables
* Preprocessors (and we will no longer use iostream)
* Format strings
* Inheritence and overriding methods

#Differences#
* Methods (single param, multi-param) and nested messages
* The "id" type => used to store an object of any type

#Method (or Function) Declaration#
- (void) setNumerator: (int) n
^ method type. "-" = instance method, "+" = class method (performs some operation on the class itself)
  ^^^^^^ return type
         ^^^^^^^^^^^^ method name
                     ^ method takes argument
                       ^^^^ argument type
                             ^ argument name

#Interface Declaration (.h file)#
@interface NEWCLASSNAME : PARENTCLASSNAME
  // Properties and method declarations
@end

#Implementation Declaration (.m file)#
`@implementation NEWCLASSNAME
{
  // Member declarations here
}`

// Method declarations here
@end

* Dot syntax (Objective-C 2.0; should be only used for getters and setters)

#Keyword Changes#
* NULL => nil
* this => self
* new => alloc (but does NOT call constructor)
* delete => release

#New (or Differences)#
* All instance variables are private in Objective-C by default
* @"" => NSString object, without the @ in a string => C style string
* Memory management
* Constructor => `init`
* Destructor => `dealloc`
* Accessors (better known as "properties")
  * See http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocProperties.html
* Protocols
* Categories

#Hiccups#
* Cannot overload functions; must use a different name
* Cannot use parameter names that are same as instance variable names
* Cannot make a member function private

#The Foundation Framework#
* `#import <Foundation/Foundation.h>`
* Collection of classes, methods, functions, and documentation logically grouped together
* Many basic objects
* NSObject
* NSString vs. NSMutableString
* NSSNumber
* NSInteger
* NSLog
* NSArray
* NSMutableArray
* NSDictionary

#Using Xcode#

#Using the Organizer and RTFDocumentation#

#Resources#
* http://cocoadevcentral.com/d/learn_objectivec/
* http://developer.apple.com/
