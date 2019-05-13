# Create Layouts with Stack Views

# Demo
>Start with the reference image off to the right

**Catie**  
Let's stack some views! I'll take the top one. It looks like I need two buttons and a label.

First, I'll find a button in the Object library and drag that in. Then I'll drag in a label.

>Drag in a button and a label

I'm just going to change the background color of this button. I like green, so I'll make it green.

>Make the background color green

**Jessy**  
Green isn't very piratey.

**Catie**  
Fine, I'll make them red. 

>Make the background color red.

Pirates love red. And while I’m here I’ll make the text black. Then I'll duplicate the button.

>Duplicate the button

Now, just like in the last video, I'll drag in a horizontal stack view, and pop all of my views on top of it.

>Drag in a stack view, select all views, drop them in the stack view

Then I'll position the whole stack near the top of the screen. 

>Position stack view

It looks like we need more space between these views, so I'll open up the attributes inspector and change the spacing to.... 16.

>Change spacing to 16


**Jessy**  
Looks good! My turn.

I need two labels and an image view.

>drag a two labels and an image view in

I'll make one label a title, and the other a caption

>Set the title on one to "Image Title" and set font to "heading 2"
>Set title on the other to "Image caption goes here" and font to "caption 1"

And then I'll set the image on the image view to be the only image contained in this project!

>Set background image ont he image view

Time to stack them. I'll try the way we haven't yet, selecting all of the views and using the embed in stack view button.

>Do that

And I'll set a spacing of 8. 

>Set the spacing to 8 in attributes inspector.

**Catie**
Close! Let's center this whole stack in the view controller

>select stack view, center in the VC

And it looks like this label is aligned along the trailing edge. If we set the stack view’s alignment to center...

>Set the alignment to center

It will look more like our reference image!

Now that these are all set up, you can play with different values for alignment and distribution, if you want to. 

In the next video you'll learn about **intrinsic content size**, an important concept for understanding how both of those properties work under the hood.