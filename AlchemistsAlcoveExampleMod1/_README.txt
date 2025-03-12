HOW TO MAKE A MOD

Alchemist's Alcove loads mods using either TXT files, TRES files, or GD files!
TRES files can be made within the game, but this is a whole complicated process that's a bit of a headache for anyone not making the game themselves (in other words, anyone but me!) -- however an easier option is to simply make a couple TXT files and follow the syntax outlined in this guide!


FARTFISH'S MAGICAL TXT SYNTAX

TXT files are used within Alchemist's Alcove in order to create new Objects using the game's built-in Classes. Unless stated otherwise within the TXT file, a newly-instanced Object will use the Class' default values. 

All files to be loaded will be listed in "ModMaster.txt" (including non-TXT files, if you'd like to include TRES files). You can temporarily disable mods by renaming this file in the mod's folder! To re-enable a mod, simply rename its master file back to "ModMaster.txt".

When referencing a file, you can do so by using its path!
For paths native to Alchemist's Alcove, use "res://path/to/file". As a helpful note, all of Alchemist's Alcove's native classes are stored in "res://classes"!
For paths within your mod folder, use "mod://path/to/file"

For a list of important filepaths (e.g. tags, behaviors, etc) please refer to _STARTERS_CHEATSHEET.txt!

Additionally, be wary of using non-alphanumeric symbols like parentheses or curly brackets in your txt files, variables, etc! This can interfere with the program's methods for separating Object attributes.

Now that we have that starting information out of the way, let's start making an Object! 
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

And this is all we need to know to start making Objects! Let's get to it!


MAKING OBJECTS

Most Objects within Alchemist's Alcove have attributes that are other Objects! As an example, the "Item" Class has an Array of Behaviors it uses to dictate how it interacts with the game world.

This means that in order to make an Item Object, we would first need to make its Behaviors. The same is true for Units and Items -- Units hold an Array of Items they use in battle, and so in order to make a Unit, you'll need to make an Item first -- which means you'll also need to make that Item's Behaviors!

This can quickly get out of hand, so let's start by making a plan.

Let's make a "Blue Kobold" Unit that has a "Blue Fireball" Item in its Inventory. This Blue Fireball will need to deal damage, so the very first thing we have to do is make a "SpellBehaviorSimpleDealDamage" Object!



To get started, we need to set our Object's Class! The "SpellBehaviorSimpleDealDamage" Class is located at "res://classes/behaviors/spell_behaviors/simple_act_deal_damage.gd".
(class):(res://classes/behaviors/spell_behaviors/simple_act_deal_damage.gd);

Then, we can set the damage type by appending a "Tag" Object to our behavior's "tags" array. Our Fireball should deal "Burning" damage -- the "Burning" Tag is located at "res://resources/tags/dmg_types/burning.tres".
([tags]):(res://resources/tags/dmg_types/burning.tres);

We also want to make sure that the player will know where the spell is coming from when enemy Units are using it. The "draw_path" attribute allows us to create harmless displays along a spell's path.
(draw_path):(true);

Next up, in order to actually deal damage, we'll need to use an integer value in the "dmg" array. This is an array so that if an Item has multiple damage types, it can have separate damage values for separate Tags. This won't be necessary here, though, as we're only using one damage type.
However, the default value of the "dmg" array is an array with a single value of 1. Because of this, we don't want to append the value of 2 -- Instead, let's set the value of the "dmg" array at index 0 (the first index) to 2, like so:
([dmg][0]):(2);

No fireball's a proper fireball without some radius! Let's set its "radius" Attribute to 2. This radius includes the origin tile!
(radius):(2);

Finally, our fireball isn't just any fireball -- it's a *blue* fireball! By default, any damage dealt will be displayed as its corresponding tag's damage visual, but we can add our own custom visuals for specific Items.
(forced_texture):(mod://AlchemistsAlcoveExampleMod/sprites/dmg_blue_burning.png);


Now, we just need to make our file! As a note, TXT files will be written in this guide between three backticks like so:

```
<text>
```
This should help clarify where TXT files start and end, and make them easier to find!


Let's name our file "BlueFireballDealDamage.txt". Here it is!


```
(class):(res://classes/behaviors/spell_behaviors/simple_act_deal_damage.gd);
([tags]):(res://resources/tags/dmg_types/burning.tres);
(draw_path):(true);
([dmg][0]):(2);
(radius):(2);
(forced_texture):(mod://sprites/dmg_blue_burning.png);
```



And that's all! We've completed our Behavior for our Blue Fireball, so let's get to actually creating it!



Just like before, we need to start by setting our Object's Class! The "Item" Class is located at "res://classes/item.gd".
(class):(res://classes/item.gd);

What's more important to anything than its name? Let's set our Item's name to "Blue Fireball"!
(name):(Blue Fireball);

Just as important, though, is the Item's "ID". This is the String used by the game to refer to the Item in Dictionaries and Recipes. Let's set our Item's ID to "blue_fireball".
(id):(blue_fireball);

But we don't want our Item to look like nothing! Let's give it an icon.
(texture):(mod://sprites/blue_fireball_icon.png);

Our Blue Fireball isn't just any Item, though, it's a MAGIC Item! This should be reflected in our Item's Tags. The "Magic" Tag is located at "res://resources/tags/item_tags/spell.tres".
([tags]):(res://resources/tags/item_tags/spell.tres);

And for our last bit of flavor, let's set our Blue Fireball's description!
(postname_description):(Blue destruction awaits.);

By default, an Item's range is -2. This means that it is not able to be cast on any Tiles. Setting an Item's range to -1 will give it infinite range, but for now lets keep our range to a radius of 4.5, the same as the in-game Fireball spell!
(range):(4.5);

Additionally, Items will have "num_uses" set to -1 by default. This means they have infinite uses. If we want to put a limit on the number of times our Item can be used, we'll need to change that!
(num_uses):(3);
P.S.
If you want to have a limited number of uses, but don't want to display that, you can set "display_num_uses" to false!
(display_num_uses):(false);
The Charged Lodestone makes use of this trick so that players aren't disappointed by only having 1 use (as it returns the Inert Lodestone on cast). For this item, though, we'll leave this line out as we want players to know how many uses they have left!

Last, but not least, let's put that behavior we made earlier to use by appending it to our Item's Behaviors Array:
([behaviors]):(mod://BlueFireballDealDamage.txt);



Now let's put it all together in a new file called "BlueFireballItem.txt"!


```
(class):(res://classes/item.gd);
(name):(Blue Fireball);
(id):(blue_fireball);
(texture):(mod://sprites/blue_fireball_icon.png);
([tags]):(res://resources/tags/item_tags/spell.tres);
(range):(4.5);
(num_uses):(3);
([behaviors]):(mod://BlueFireballDealDamage.txt);
```



Now it's time to make a Blue Kobold to fire our Blue Fireball! 



You know the drill. Let's start with its Class! The "Unit" Class can be found at "res://classes/unit.gd".
(class):(res://classes/unit.gd);

And our Unit's name should be "Blue Kobold"!
(name):(Blue Kobold);

Which our Unit's ID should reflect:
(id):(blue_kobold);

And of course our Unit needs a texture to represent it!
(texture):(mod://sprites/blue_kobold.png);

Our Unit should also have some health:
(hp_max):(4);

Additionally, our unit will need some Tags!
The "Draconic" Tag is located at "res://resources/tags/unit_types/draconic.tres".
([tags]):(res://resources/tags/unit_types/draconic.tres);
The "Beast" Tag is located at "res://resources/tags/unit_types/beast.tres".
([tags]):(res://resources/tags/unit_types/beast.tres);
The "Living" Tag is located at "res://resources/tags/unit_types/living.tres".
([tags]):(res://resources/tags/unit_types/living.tres);

But our Tags aren't over -- our Unit will need Navigation Tags as well, to dictate what Tiles it can and cannot walk over!
The "Walking" Navigation Tag is located at "res://resources/tags/navigation_tags/walking.tres".
([navigation_tags]):(res://resources/tags/navigation_tags/walking.tres);

Now let's add the Blue Fireball to our Unit's Inventory!
([inventory]):(mod://BlueFireballItem.txt);

But our Blue Fireball has a finite number of uses! It'll eventually run out, and we don't want our Blue Kobold to just stand there when that happens! So let's give it a dagger as a backup weapon. The Default Enemy Dagger weapon is located at "res://resources/enemy_items/dagger_goblin.tres".
([inventory]):(res://resources/enemy_items/dagger_goblin.tres);

Most importantly, our Unit needs a Behavior to dictate its actions! We can give our Unit a new instance of the default unit behavior by referencing its script at "res://classes/behaviors/unit_behaviors/default_unit_behavior.gd". Note that this calls a file that ends in ".gd", rather than ".txt" or ".tres". This will instance a new Object from a Script with all of its default values.
(behavior):(res://classes/behaviors/unit_behaviors/default_unit_behavior.gd);

You can also give a Unit a "cast_delay" as well -- this will cause it to use Items on a slight delay from its animations. The "cast_delay" is the number of animation frames the cast is delayed by. This is purely for aesthetic purposes! Let's set our Unit's "cast_delay" to 1.
(cast_delay):(1);


Now let's take a look at our "BlueKobold.txt" file!


```
(class):(res://classes/unit.gd);
(name):(Blue Kobold);
(id):(blue_kobold);
(texture):(mod://sprites/blue_kobold.png);
(hp_max):(4);
([tags]):(res://resources/tags/unit_types/draconic.tres);
([tags]):(res://resources/tags/unit_types/beast.tres);
([tags]):(res://resources/tags/unit_types/living.tres);
([navigation_tags]):(res://resources/tags/navigation_tags/walking.tres);
([inventory]):(mod://BlueFireballItem.txt);
([inventory]):(res://resources/enemy_items/dagger_goblin.tres);
(behavior):(res://classes/behaviors/unit_behaviors/default_unit_behavior.gd);
(cast_delay):(1);
```
P.S. We can also set the DropChances and Resistances of our Blue Kobold, however those would have to be separate Objects. For the simplicity of the guide, I'm leaving them out, but feel free to check out _STARTER_CHEATSHEET.txt to see how to create Objects of these Classes!



We're not done just yet, though!

We've now created a Blue Kobold Unit, but the game has nothing to do with it! We need to create an Object Spawner in order to tell the game where and when to spawn our Blue Kobolds. We've nearly finished our Mod!!!


As always, we need to start with the Class! The Object Spawner Class is located at "res://classes/ObjectSpawner.gd".
(class):(res://classes/ObjectSpawner.gd);

Next, let's add our Blue Kobold Unit to our Spawner's Objects array! Our Spawner will randomly choose from this array, though we're only adding one Object to it this time. The "blue_kobold" ID will refer to our Blue Kobold!
([objects]):(blue_kobold);

And those Blue Kobolds will need to be spawned with a Team to dictate who their allies and enemies are! The "Aldrnari Clan" Team is located at "res://resources/teams/team_kobold_aldrnari.tres".
(team):(res://resources/teams/team_kobold_aldrnari.tres);

We'll also need to set the Layer that our Spawner will spawn Objects in! We can use Spawners to spawn Objects in the "unit" Layer or "item" Layer -- we want to spawn our Blue Kobold in the "unit" Layer!
(layer):(unit);

Next up, we'll need to set our Spawner's X and Y coordinates! This will dictate where our Unit spawn-rate will be at its strongest! For now, let's keep the same values as the in-game Kobold Spawner.
(x):(13);
(y):(6);

In order to actually control the spawn strength, we'll need to set it! Let's set "strength" to 3.
(strength):(3);

Now, we can set the radius of our Spawner to control how far from its center it will spawn Objects!
(radius):(10);

As we go further from the center, our spawn strength should decrease! We can control this decrease with the "delta" variable. As an important note, our Spawners will round *down* to integer spawn rates, but setting "delta" to a float will allow us fine control over the rate at which spawns decrease. For example, setting "delta" to -0.2 will mean that it will take 5 Rooms for the spawn rate to decrease by 1.
(delta):(-0.2);
P.S. You can set "delta" to a positive number if you want the spawn rate to increase farther from the center instead of decrease!

Finally, we have "rand_min" and "rand_max". These give us the potential for chaos in our spawns! Each room, a random number between "rand_min" and "rand_max" is added to the number of spawns for that room.
(rand_min):(-1);
(rand_max):(1);


Let's name our file "BlueKoboldSpawner.txt"!


```
(class):(res://classes/ObjectSpawner.gd);
([objects]):(blue_kobold);
(team):(res://resources/teams/team_kobold_aldrnari.tres);
(layer):(unit);
(x):(13);
(y):(6);
(strength):(3);
(radius):(10);
(delta):(-0.2);
(rand_min):(-1);
(rand_max):(1);
```



Finally, we've created all the Objects that we will need for our Mod!!!!

All we have to do is load them by loading the necessary files so that they get added to their respective arrays and Dictionaries by the game.
Objects loaded in by other Objects will also be loaded by the game! So, we only need to load in "BlueKobold.txt" and "BlueKoboldSpawner.txt" because they will load in all the necessary files for us.

We can determine what files to load in "ModMaster.txt", with the following syntax:
```
<file1>
<file2>
<file3>
...etc
```


For our Mod, we'll need to put "mod://BlueKobold.txt" *before* "mod://BlueKoboldSpawner.txt" so that our Blue Kobold gets loaded in before our Spawner.
This way, our game will have loaded our Blue Kobold Object into the global Units Dictionary as "blue_kobold".
```
mod://BlueKobold.txt
mod://BlueKoboldSpawner.txt
```


And now, when you run your game, you should find that there are Blue Kobolds running amok and sowing chaos! Oh no!

We'll need something to defend ourselves with -- how about a Blue Fireball of our own?

Because the Blue Fireball Object has already been loaded in by our Blue Kobold, we don't need to load it in manually to add it to the global Items Dictionary.

We can make an Item craftable by adding a recipe to "ModRecipes.txt"!
The syntax for this is:
"item_id1,item_id2:output_id1,output_id2,..."

We can add recipes to "ModRecipes.txt" similarly to how we add Objects to "ModMaster.txt":
```
<recipe1>
<recipe2>
<recipe3>
...etc
```

Let's make our "ModRecipes.txt" file:
```
sulfur,ultramarine:blue_fireball
```

This will allow the player to craft our Blue Fireball using sulfur and ultramarine pigment!




CONGRATULATIONS!!!!!!

We've just finished making a Mod!

I hope this guide was useful to you, and helps you make some amazing Mods! Have fun!!

-Fish