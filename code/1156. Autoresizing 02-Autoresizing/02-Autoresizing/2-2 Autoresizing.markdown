# Intro
---
> Set main device as iPhone X

**Jessy 😺**  
In these sections on Auto Layout, we'll be working exclusively in the main storyboard. The starter project is totally empty.

First, let's get a background set up, and use autoresizing to make sure that it always fills up the screen.

Grab an image view, by starting to type it in the object library, and then dragging it over onto the main view, wherever.

> drag it on, wherever

Set its image to be "background", and its content mode to be "aspect fill".

> set both

Then, drag all four edges to make the view the full size of its superview.

**Catie 🐸**
Let's get a preview of what this looks like, for other devices.

Open the assistant editor with this "joined circles" button at the top, and choose "Preview", from its dropdown menu at the upper-left.

> open the Assistant Editor  
> just click "preview" without a sub-selection, but don't bother going into it.

I'll rotate the iPhone X preview to landscape

> rotate

**Jessy 😺**  
Lookin' bad!

**Catie 🐸**
Hold your horses! I'll add one more device that looks bad, and then we'll fix it. An iPad Pro in portrait'll work fine.

> choose an iPad pro in portrait

Now, let's re-select the image view in the editor, and go to the Size Inspector: which you access with this tiny ruler icon at the top of the Utilities area.

> view Size Inspector, and hover over UI

Hovering over either element of the autoresizing UI, shows an animation of the selected view's flexibilities: this image view is represented in red. Its superview is the surrounding white rectangle.

Autoresizing defaults to having no flexibility for the left and top margins. For the background, we additionally want to remove flexibility for the other two margins.

> remove them!

But we do want flexibility for width and height.

> add those!

**Jessy 😺**  
Lookin' *good*!

Autoresizing is useful for more than filling up the screen, though. Let's demonstrate that with a button.

Add one centered, near the the bottom.

> add the button there

Then, change some of attributes:

background: "button"

> that

font: custom, marker felt, wide, 17

> that

and text color: black
> that

Then, make the button wide enough to display its text, and move move it back to center

> that

**Catie 🐸**  
Lookin' bad, in the previews!

**Jessy 😺**  
Now! We want a set of autoresizing flexibilities that will keep this button in the center regardless of device.

First, I'll remove flexibility for the bottom margin and add flexibility for the top margin.
> do that

Improvement.

Then, I'll add flexibility for the left margin. too.
> that 

**Catie 🐸**  
Lookin' good!