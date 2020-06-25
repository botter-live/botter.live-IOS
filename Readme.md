# Botter Mobile SDK!

Hello Here is a brief guide to integrate with botter mobile SDK
the files attached with this document is a SDK for iPhone simulator and another for iPhone devices 

# Installation

**Steps**
>1- add pod 'Botter' , :git => 'https://github.com/NoraSayed135/Botter.git'  in your pod file
>3- Customize your app to allow multiple window in case you want to show floating button on to of your entire app /*if not skip  this*/ to this follow this steps
>
>> 1 - remove _Scene Manifest_ from info.plist file 
>> 2- comment scene configuration functions in App delegate 
>> 3- **var  window: UIWindow?** add this line in App Delegate class



## Implementation

**Option #1** 
*Place chat button over the entire app*
 > in app delegate class **import  Botter**
 > in **didFinishLaunchingWithOptions** function will add this 
 > **Botter.show(APIKey: "nKmovPCdWNZ")**

**Option #2** 
*trigger open chat action on your custom button*

> in the class that contains the button include the framework **import  Botter**
> in the **@IBAction** function add this line **Botter.openChatScreen(APIKey: "nKmovPCdWNZ")** 

**Option #3** 

> we can hide launcher button in certain controllers to do so we have two ways 
>
> > make the controller where we want to hide the button inhirit from **BotterControllerWithHiddenLauncher** 
>
> or
>
> > call these two functions whenever we want to show/hide launcher button 
> >
> > **Botter.hideLauncherButton()**
> >
> > **Botter.showLauncherButton()**

## Customization

**Change Launcher Position** 

> to change launcher Position you can set bottom margin calling this:
>
> > *Botter.setLauncherBottomMargin(marginValue: Float(40))*

**Change Title Text** 

> to change title text you can set it calling this :
>
> > **BotterSettingsManager.ChatTitleText = "Botter"**