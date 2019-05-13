# Intro
---
> Make sure iPhone SE is selected for the Editor

## Main.Storyboard
**Jessy**  

The first thing we'll be doing here is creating some explicit width and height constraints for our buttons. That will allow us to override the height that gets applied to them based on their intrinsic content size.

To do that, let's first select the button on top
> select it

Then, hit the Add New Constraints Button
> hit it

Select the checkbox for Height, and enter 50.
> do that

Then you can hit the Return key, or the Add Constraints button on the bottom. I like keyboard shortcuts so I'm hitting Return.

> hit Return

Now the button is 50 points tall. To do the other ones all at once, we can select them… and I'll do with a selection using the shift modifier key to select all three of them, and a little extra.

> select

Then, command-click on that "little extra", which is the stack view.

> command-click

Now, we *could* take the same steps again, clicking on Add New Constraints, and setting height to 50

> show what that would look like

And you'd see at the bottom that you can add more than one constraint. But don't do that! Instead, add the top button to the selection, using command-click, and go back to the same menu… 

> go there

Because we want them all to have the same height, there's a better way to do this: check "Equal Heights"!

And now you'll see at the bottom, "Add _three_ constraints" again. I'll hit the button itself, just to show you that it works.
 
> Hit the button!! Not Return!
 
**Catie**  
Now we've got height constrained for all the buttons, the stack view continues to take care of laying everything out, accordingly!

Next, let's drag a label in from the object library to the bottom left of our view, to hold a copyright notice…

> do that

Double-clicking to edit the text… Option-G makes the copyright symbol, and I'll follow that with "Please do not pirate the Pirate Handbook"!
> © Please do not pirate the Pirate Handbook

Next, before we set up more constraints, let's drag the right side of the frame's edge over to the guide on the right.

There's not enough room to show the text. That might not be true of a larger phone, like the iPhone 10…

> select it and drag

But, there's no automatic resizing happening. We're just locking the frame's width.

---
# Interlude
---
**Jessy**
This time around, let's make sure, as we Add New Constraints to this label…

> do that 

…that we do Constrain to Margins.

> make sure of that

The constraints we make will be to the leading and trailing margins, with 0 offset. 

> set 0 if they're both not

Do that by clicking the little I-beams.

> click them

Also, let's create a constraint to the bottom.

> hit the I-beam and select

And with that, let's use the dropdown, to select the standard value. (That's 8 points, but they make it so you don't have to remember that.)

**Catie**  
That looks good on the 10, let's switch back to the SE.

It's not perfect yet, but let's have a look at how the ellipsis on the right edge might be better than the alternative. 

If we delete the trailing constraint we made, in the Size Inspector…

> do that

The text just runs off the screen. Let's undo that, making sure the label is selected and hitting Command-Z. And then, let's make even better use of the trailing constraint, by allowing the font size to shrink. We can do that in the attributes inspector, in the Autoshrink section.

> go there but don't click yet

Choosing "Minimum Font Scale", and going with the default of default of 0.5, allows the text to be rendered smaller than the 17 points, that are set above. 

**Jessy**
Lookin' good. If you'd like, you can preview more than one device rendering at a time. To do that, open the Assistant Editor with this button at the top.

> open assistant editor with button

The, choose "Preview", from its dropdown menu at the upper-left.

> just click "preview" without a sub-selection, but don't bother going into it.

I'll choose the two smallest devices in portrait, to make sure the text scales well for both.

> Preview 4s and SE

Then we can switch back to the 10 in the editor.

> switch
 
And, to get an idea of what the looks like when it doesn't take up the whole width of the screen, I'll rotate the SE preview.

> rotate it