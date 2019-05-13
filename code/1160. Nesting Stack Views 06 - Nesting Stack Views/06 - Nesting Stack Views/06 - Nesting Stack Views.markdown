# Nesting Stack Views

>Start looking at image


**Catie**  
We're back in our pirate handbook app, and this time we want to add a FAQs button next to the Privacy Policy button, so that the app will look like this. 
 
One stack view can't do this, but we can easily build this layout with two stack views!

Start by visually breaking the layout down into stackable groups. There is a set of two buttons, stacked horizontally on the bottom. And then that small group can be vertically stacked with the top two buttons.

**Jessy**  
In Xcode, our app is just as we left it. Let's start creating those two stacks.

First, we need one more button. I'll just duplicate this Privacy Policy button with Command D. 

>Command D to duplicate

Notice how this helpfully duplicates the button inside of the stack view, and the stack view automatically lays it out for us! 

But this isn't what we want, so let's fix that by changing the title of the button to FAQs in the attributes inspector.

>Change title to FAQs

**Catie**  
We decided we wanted to stack these two buttons together, so grab both of them. This time I'll do so from the document outline, just because I can! And then stack them using the embed in stack view button.

>Select bottom 2 buttons, embed in stack view

Take a look back in the document outline. Our new stack view is nested *inside* of the original stack view!

But this still isn't exactly what we want, we need to change the axis of this stack view. So select it in the document outline, and change the axis to horizontal.

>Select new stack, change axis to horizontal

**Jessy**  
That's pretty close! It's both close to the layout we want, and the buttons are too close! Let's add some spacing. This time, use 12.

>Change spacing to 12

Lets readjust our parent stack view to be centered again. This is the problem with using autoresizing to position your views. 

Autoresizing options have no real understanding of where you want your views to be positioned. So when a view changes size like this, its not going to stay centered. Constraints allow you to be very specific about what you want Auto Layout to do with the position and size of views, and you'll get into that in the next section.

For now, just grab the stack view and move it back over as needed.

**Catie**  
This nesting business is working quite well, out of the box, for this simple layout. But you'll certainly run into more complex layouts than this and need to actually change the alignment and distribution of a stack view eventually!  

In the last video, we learned about intrinsic content size. All of these buttons have an intrinsic size. A stack view, however, does not. If you don't constrain or specify the stack view's size, it inherits its size from its subviews.

**Jessy**  
All of this plays into how the alignment and distribution properties work, and we'll look at that, next!