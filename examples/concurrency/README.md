#Overview#
* Concurrency - two or more tasks executing at the same time.
* Consideration: multicore CPUs (e.g., in iPad 2); OS will dispatch tasks to the CPU and wait until they are done
* Idea: you don't have to worry about which CPU is doing what task. How? Grand Central Dispatch.
* Back in the days, one must use `NSThread`
* Several different ways to perform concurrency

#Grand Central Dispatch (GCD)#
* Low-level C API
* No need to import any libraries
* Uses block objects in Objective-C; first-class objects
* Methods and data types start with `dispatch_`
* Dispatch queues - pools of threads managed by GCD
* You do not work with threads directly; you work with the dispatch queues. Options:
  * Synchronous
  * Asynchronous
    * `dispatch_async` uses a block as parameter
    * `dispatch_async_f` uses the name of a C function as parameter
  * After a certain delay via `dispatch_after` (delay time must be in nanoseconds)
* You can use multiple dispatch queues at once

#More About Dispatch Queues#
* Main queue: performs all tasks on the main thread.
  * All UI-related functions must be performed on the main thread.
* Concurrent: retrived from the GCD in order to execute sync or async tasks
  * To get concurrent queue, call `dispatch_get_global_queue`
* Serial queue: will always execute tasks in FIFO fashion, one block at a time; does not run on main thread.

#Operations#
* Blocks (with low-level GCD C API)
* Invocation via `NSOperation`
* What if you want to run tasks concurrently, asynchronously? Use `NSOperationQueue` which is built on top of GCD

#Background Operations#
* Use `performSelectorInBackground:@selector()  withObject:`
