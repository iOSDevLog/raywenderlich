# Intro
---
> make sure just iPhone X is showing

**Jessy 😺**
We're going to center our stack view. That *will* involve switching from autoresizing, to using constraints.

But first, select the Stack View, and we'll go over a tip that you can use to help when positioning views.

> select it in the document outline 

In the size inspector, click the drop down next to the word **Arrange**, and select **Center Horizontally In Container**, and then, **Center Vertically In Container**.

> select both, then open the menu again to talk about it

![width=50%](Images/Arrange.png)

When you choose something from this dropdown, it does _not_ create constraints. Instead, just the frames of views are moved. That can give you better Auto Layout previews, and make it easier to create constraints. 

**Catie 🐸**  
In order to preserve the centering across other devices, we'll create constraints on the stack view. 

Now, we want to constrain the Stack View to its superview, but it's problematic to do that in the editor. Not only is it difficult to start right- or control- click-dragging from the stack view itself, because of all the buttons in the way, but letting go on the superview doesn't work, because the background image view completely covers it.

![width=50%](Images/Background.png)

The document outline is a much better option in this case. The same dragging works there, as in the editor. Only better!

**Jessy 😺**

Hold shift, and then you can select "center horizontally in container", and its vertical counterpart, at the same time.

> do that

Then either hit "Add constraints", or the Return key.

![width=50%](Images/DocOutline.png)

You can switch between all the devices now, and the stack view stays centered!

> choose largest and smallest previews