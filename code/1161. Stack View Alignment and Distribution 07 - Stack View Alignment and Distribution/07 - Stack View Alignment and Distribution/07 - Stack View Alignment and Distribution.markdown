# Stack View Alignment and Distribution

# Demo 1

**Catie**  
Back to our app! Let's experiement with alignment options.

In the case of this little stack view on the bottom, both buttons have exactly the same intrinsic height. They use the same font, have the same inset values, and only have one line of text. So the changing the alignment isn't going to do anything here. 

>try all alignments and see no change

But if you change the font size of one of the buttons...

>change the font size of FAQs to something really high
  
Suddenly, alignment makes a big difference!

>change the alignment again to see options

In particular, note what happens with First or Last Baseline.

>try those two options

The buttons are aligned based on the baseline of their text, as opposed to their edges or centers.

**Jessy**  
We really did want these to have the same size text, so change this back to 17:

>change font size back

You can also see alignment in action if you select the parent stack view and start changing things up. This is a vertical stack view, so the alignment affects its subviews in the horizontal axis.

>Select parent stack view, and change the alignment value

**Catie**  
The other options look pretty messy for this particular use case. We're very neat and tidy pirates, so I think I preferred how the labels used to all line up on the left and right side.

**Jessy**  
The default value, fill, is what makes those top two labels stretch out to fill the space that this bottom stack view is demanding with its intrinsic size.

>Change alignment back to fill

We've got one more property to test out, distribution!

# Interlude - Distribution

# Demo 2

**Jessy**  
Grab this bottom stack view again, and try changing its distribution property to "Fill Equally"

>change to fill equally

These buttons are now exactly the same size. They were already the same height, but now they're also the same width. 

**Catie**  
Again, the stack view itself doesn't have a defined size. That means the button with the largest intrinsic size, in this case, Privacy Policy, determined the size for both buttons and the stack view.

**Jessy**  
Fill Equally is the only distribution option that uses the intrinsic size of only one subview. The rest of them take the size of all subviews into account when resizing.

Distribution becomes much more important when the size of the stack view is defined. You'll get into constraints in the next section, but just to illustrate the point...

>Set a width constraint on the stack view

Notice how Privacy Policy is being clipped. These two buttons are still the same width, but that width is now determined by the width I just set on the stack view.

If you change the distribution again, this time to Fill Proportionally...

>Change distribution to Fill Proportionally

The FAQs button is still shorter than the Privacy Policy button, but niether button is set to its exact intrinsic size. Instead, they're proportionally scaled to fill up the stack view's width. 

>Change to Equal spacing

**Catie**  
Equal spacing sets both buttons back to their intrinsic size, and adjusts the spacing between them to fill up the stack view. 

If you use this options, you can clearly see that the Spacing property is just the minimum spacing required by the stack view.

**Jessy**  
Go ahead and reset everything, so that your handbook looks nice and tidy again.

>Set back to "fill", delete constraint 









