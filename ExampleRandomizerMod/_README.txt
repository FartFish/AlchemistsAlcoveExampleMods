Hi there! This guide is slightly more advanced, but also not really. Most of the interesting stuff is happening over in "randomizer.gd", so be sure to check it out once you've read through this!

As usual, here's a refresher on syntax:

To begin making an Object, you'll need to begin your txt file with a path to the class it will be instanced from.
Here is the syntax for setting an Object's class:
(class):(<path/to/class.tres>);

If you'd prefer not to start from scratch and instead duplicate an existing Object, use this syntax:
(duplicate):(<path/to/obj>);

From there, we can start setting our Object's values! Remember, not all of these will need to be filled in manually -- each class has default values!
Here is the syntax for setting an Object's attribute:
(<attribute_name>):(<value>);
Keep in mind, sometimes a value will need to be duplicated in order to separate it from its base instance. Otherwise, you will find multiple references to the same instance, all sharing the same values. You can denote that a File or Object needs to be duplicated by using apostrophes, like so:
('<value>');

Some Objects have attributes that are Arrays!
Here is the syntax for appending a value to an Object's Array:
([<array_name>]):(<value>);
If you want to set the value of an array at an index instead of appending, you can do so using the following syntax:
([<array_name>][<index>]):(<value>);

All lines should be suffixed by a semicolon like so!
(<param1>):(<param2>);


Except... we won't be needing any of that for this lesson!


RUNNING SCRIPTS

I'm sure lots of you will want to do much more than just make custom Units or Items -- You'll want to make your own Scripts that will fundamentally alter how the game works in some way.

Godot runs using GDScript. It also has C# support, but it mainly uses GDScript. At the time of writing, I haven't implemented .cs File support (though that is planned!) so you'll need to use a .gd file!

And it's as simple as this --

Simply make a GD Script, write a Function called "_on_loaded", and voila! All the code in that function will run when that Script is loaded.

Keep in mind, *all* code in that function will run. As with any game, be careful when downloading anything from strangers. Some of these Scripts may be malicious! 

Just like with .TXT and .TRES files, we'll need to load any Script within a ModMaster.txt file.


For the purposes of this lesson, we'll be making a Randomizer Mod that randomly swaps Game Object IDs so that each run is a COMPLETELY new experience!

The Script is already made -- randomizer.gd

We just need to load it!


Here's our ModMaster.txt File:
```
mod://randomizer.gd
```


...And that's it! The Mod's done! The Script will be loaded and run its "_on_loaded" Function. In this case, we connect a Signal in the ModManager Singleton to a separate Function that handles the randomization.

Be sure to check out randomizer.gd to get greater insight into how to interact with Alchemist's Alcove using Scripts!