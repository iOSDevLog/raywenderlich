# Challenge #5: Nested Stack Views

**Catie**  
OK I'm ready to go! I've got our reference image over here. Let's just start at the top and work our way down. 

Start by adding an image view for the ghost. I'll also give it a black background.

>Drag in image. change background to black. change image to ghost

I've just hit command equals to size to fit content on this spooky pirate ghost.

**Jessy**  
Next, add two labels for this title and description of the ghost. He’s a Pirate Ghost.

>Label 1 - Pirate Ghost - Size 20, Bold

And before he was a ghost, he was a Mighty Pirate... TM

>Lable 2 - Formerly a Mighty Pirate™ - Size 14

Then stack those two labels.

>Select them. Click stack button.

And set up that stack view. In our reference image, the text is left aligned, so set Alignment to leading. There's also some space between the text. I'll set Spacing to 8 to take care of that.

>Set alignment ot leading, spacing to 8

**Catie**  
Next up, we can stack that label stack view with the ghost image!

>Stack 'em

If you had your label stack view somewhat aligned with the bottom of the image, and then stacked them, the stack view might have guessed at your alignment intention already!

If yours did not, go ahead and set the alignmet to "Bottom". Also set spacing to 18 while we're here!

>Set alignment to bottom, spacing to 18

**Jessy**  
Moving on, our next task is to create a horizontal stack of pirate loot! That's three images...

>drag an image in, then duplicate, 

Stack those together...

>stack again!

And then set their images to Treasure, Ring, and Golden Swift.

>Set the images

**Catie**  
That's a pirate's best friend. A swift with a gold dubloon around its neck!

We want this excellent parrot replacement, the pile of treasure, and this diamond ring to have equal spacing between them along the horizontal axis. 

This is a horizontal stack view, which means we need ot change the distribution. Set that to "Equal Spacing". We also want "Fill" for the alignment, so all of the images will be the same height.

>set distribution to "equal spacing", fill for alignment

**Jessy**  
All of these stack views called stack view are getting out of control in the Document Outline. Let's name the stack views so we can tell them apart.

>Profile - Ghost + Labels
>Description - Labels
>Loot - ... loot

Now grab the Loot stack view and the Profile stack view and stack those together! This is actually going ot be the parent stack view of the final layout.

**Catie**  
That didn't turn out quite right! But it's no big deal. Just change the axis of the stack view. Then, in the document outline, drag the Profile and Loot stacks around so they're in the right order.

What's left to do?

**Jessy**  
We're still missing our treasure map. Add one more image from the object library, and this time, drag it directly into the stack view.

>Drag image into the stack view

And set the image to "Treasure Map"

>Set the image.

**Catie**  
The very last thing to add, is a pair of very non-descript "buttons" to tack onto the bottom.

>Drag in 1 button. Set background to black, text to white, and set inset to 20 on left and right, 10 top and bottom

Set one button up with the backbround and inset values we want, and then duplicate the button...

>Duplicate button

And stack 'em!

>stack them

Now, over in the document outline, name that stack view "Buttons" and drag it right up under "treasure map" to add it to the stack view. 

**Jessy**  
That's all the pieces from the reference image, contained in their own stack views. But this looks kinda broken.

To clean things up, we can constrain the parent stack view so it will stay put and the same width.

Use this "Add New Constraints" button to constrain the top and both sides of the stack view. The exact values aren't important right now.

>Set constraints 

**Catie**  
We're getting there!

Now we can set up the properties on that parent stack view. You'll know which one it is, because it's the only one still called "Stack View".

First off, set a healthy spacing of 20 to give all of the subviews some room.

Then, check out the Alignment. From our reference image

>look at reference image

It looks like we want to fill up the the stack view horizontally, and since this is a vertical stack view, that means setting the alignment.

>Set alignment to fill

The distribution we'll leave as "fill" as well. Currently, the stack view is calculating its height based on the vertical intrinsic size of all of these subviews, and that will work just fine.

**Jessy**  
This stack view almost looks like what we want. We just have to get the Buttons to align to the right instead of the left, and give them some spacing.

Select the buttons stack view and change the spacing to 8. We want the buttons to line up on the right side of the stack view, so set the alignment to "trailing"...

>change alignmen tot trailing.

**Catie**  
That's it!! We did it!

*And* now you've got a complex hierarchy of nested stack views to test out all the settings you want! 