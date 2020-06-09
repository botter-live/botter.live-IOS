# Botter Mobile SDK!

Hello Here is a brief guide to integrate with botter mobile SDK
the files attached with this document is a SDK for iPhone simulator and another for iPhone devices 

# Installation

**Steps**
>1- Add the attached framework to your project
>2- Add WebKit Framework 
>3- Customize your app to allow multiple window in case you want to show floating button on to of your entire app /*if not skip  this*/ to this follow this steps
>> 1 - remove _Scene Manifest_ from info.plist file 
>> 2- comment scene configuration functions in App delegate 
>> 3- **var  window: UIWindow?** add this line in App Delegate class



## Implementation

**Option #1** 
*Place chat button over the entire app*
 > in app delegate class **import  BotterSDK**
 > in **didFinishLaunchingWithOptions** function will add this 
 > **BotterSDK.show()**

**Option #2** 
*trigger open chat action on your custom button*

> in the class that contains the button include the framework **import  BotterSDK**
> in the **@IBAction** function add this line **BotterSDK.openChatScreen()** *OR* **BotterSDK.openChatScreen(in: UIViewController)**

**Option #3** 

> we can hide launcher button in certain controllers to do so we have two ways 
>
> > make the controller where we want to hide the button inhirit from **BotterControllerWithHiddenLauncher** 
>
> or
>
> > call these two functions whenever we want to show/hide launcher button