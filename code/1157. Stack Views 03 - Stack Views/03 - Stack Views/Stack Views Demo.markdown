# Stack Views

# Demo 1

>Begin looking at image of the layout we want to achieve. Image will be open in Preview on the right. Xcode on the left. 
>ZOOM in on the image to start.

**Catie**  
We've got a reference image here, and we're going to leave it off side while we work, to remind us what we're trying to do.

>ZOOM out to fullscreen

If you open up the project and look at the storyboard, we're exactly where we left off. We've got a nice piratey backdrop and one button.

**Jessy**  
Let's give this button a better title. I think it should go to a Treasure Map, so select the button, open up the attributes inspector, and change the title to... Treasure Map

>Select button, open Attributes inspector, change title to "Treasure Map"

There we go! If only you could read it on the actual button...

**Catie**  
We can make Interface Builder figure out how big the button needs to be by going to the editor menu, and clicking "Size to fit Content"

>In editor menu, choose size to fit content

If it’s disabled, deselect the button, then reselect it. This is a common bug, so don’t fret about it.

**Jessy**  
That's still not what we want! The background image and text are running together.

**Catie**  
To fix that, make sure the button is selected, and open the Size inspector on the right. 

Set the Content Insets to 15 on the left and right.

>set content inset to 15 left and right

Now size to fit content. This time, use the keyboard shortcut, Command Equals

>Command =  Size to Fit Content

Now the content, the text in this case, is inset 15 points from the left and right edge of the button.

But that's only one button and we know from our image over there that we want three buttons! Pirates do not take kindly to be shortchanged on their buttons.

**Jessy**  
You could drag two more out from the Object library, but you already set this one button up with the content inset that we want. A better idea is to duplicate the button you already have. 

You can do this with an option-click and drag, or with a keyboard shortcut: Command + D.

>Duplicate the button

And now we've got three buttons! But they all say the same thing. 

Select one of the buttons and change its title in the attributes inspector. This button will show us the Weather Forecast, so we can pack the right pirate clothes for our treasure-hunting escapades.

>Name button Weather Forecast

and do the same for the other button. That one should give us the Privacy Policy, a must have for any pirate handbook.

>Name button Privacy Policy

**Catie**  
These new buttons aren't adjusted for the size of their contents, but we're going to ignore that for the moment and let the stack view fix it for us.

There are a couple ways to create a stack view in Interface Builder. You could select all of the views you want to stack and then click this "Embed in Stack View Button". 

But you can also look up a stack view in the object library, like you would any other type of view.

>Look up the stack view in object library

You should see two options, one horizontal and on vertical stack view. These are exactly the same aside from their axis property, which you can freely reset from the  attributes inspector.

We want a vertical stack view, so drag that onto the view controller.

We've got a stack view and we've got the three buttons we want to be laid out by the stack view. How do we smoosh those things together to get what we want?

**Jessy**  
Select all three buttons, and drag them on top of the stack view.

>Drag buttons onto stack view

That doesn’t look like what we expect at all, and if that happens to you, try this “Update Frames” button.

Now, magically, the stack view has already resized the buttons so they are all the same width, and you can read all of their labels. 

This is thanks to the stack view's default settings and how it interacts with intrinsic content size: a subject we'll cover in the next exercise. Stack views won't always work this beautifully out of the box, but as we said, they really shine for layouts like this!

**Catie**  
Now let's get the stack view placed a little less haphazardly. Select the stack view again...

We've actually got a button selected now. You could select the stack view via the document outline...

>click document outline button

but there is another thing you can do right from the storyboard editor.

>click to close document outline

If you hold shift and then right click on a view...

>Shift right-click on a button

...you can see the entire hierarchy of views below the selected view, including the stack view that we want!

**Jessy**  
Go ahead and select the stack view from that little menu. 

>Select stack view

Now you can drag it into place near the top of the view controller. And then use Autoresizing to keep it there using the size inspector.

>Drag stack view to top layout guide, centered horizontally. Go to size inspector.

Set the top margin to be fixed, and the left and right margins should be flexible. 

>Do that

Go ahead and build and run to see that this is, in fact, working as well as Interface Builder tells us it is.

>Build and run

And it's working! 

**Catie**  
And this is just the default settings! Let's take a short break to find out more about the properties you can set on stack views.



# Interlude - Stack View Properties

# Demo 2

**Jessy**  
Let's see some of those stack view properties in action!

Select the stack view again with shift + right click.

>Select the stack view

Then open up the attributes inspector.

>Open attributes inspector

Right at the top, you can see the axis of the stack view is Vertical. We dragged a vertical stack view in from the Object library, so that makes perfect sense! If we'd dragged in a horizontal stack view, this would be set to horizontal:

>Change to horizontal

But that is not what we're after, we really did want a vertical stack view.

>Change back to Vertical

**Catie**  
The next three properties are still on their default settings. `Fill` for both alignment and distribution, and Spacing is at 0.

If we take another look at our example image:

>ZOOM out to see image on the right

We can see that we want some spacing between our buttons. Let's try 8.

>ZOOM back into Xcode
>
>Change Spacing to 8

Then we can see the stack view has, again, magically added 8 points worth of space between all of the buttons inside of it.

**Jessy**  
We've got one more trick to show you in this exercise:

This isn't the order we want our buttons in! To put them in the right order, you can actually drag items around inside of the stack view and drop them where they should go. 

As you can see, stack views are very flexible *and* Interface Builder friendly.

**Catie**  
The other stack view properties, Alignment and Distribution, require a little more information to understand well, so we'll return to them in a future video. 

Before we go, we wanted to address these warnings you probably got when you ran your project. 

>Click on yellow triangle at top

If you use Auto-resizing to position your stack views, like we currently are, you’ll get these Ambiguous Layout warnings. Basically, Xcode is telling you it doesn’t know where your labels should be positioned, even though they’re in a stack view, and that stack view is being positioned with Autoresizing options. 

You can consider this a bug in Xcode, and ignore it for now.

Next up, a challenge! 











