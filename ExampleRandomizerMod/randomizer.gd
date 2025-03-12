class_name Randomizer extends Resource

@export var randomize_items:bool = true
@export var randomize_units:bool = true

## If a loaded Resource or Script has a function titled "_on_loaded", that function will be called once it is loaded by the ModManager.
func _on_loaded():
	## Here, we connect the "_on_game_start" signal from the GameManager to our randomize_all() function
	## This way, we will randomize everything at the start of every game.
	GameManager._on_game_start.connect(randomize_objects)
	
	## As a note, any important signals will be at the top of a Node
	## If you have any requests for signals, please reach out to me on Discord!

## Randomize Objects
func randomize_objects():
	randomize()
	
	## ITEMS
	if randomize_items:
		## Exclude specific items
		var excluded_items = [
			"boots",
			"glove",
			"dagger",
			"compass",
			"diminution",
			"diminution_powder",
			"fragment_philosopher",
			"fragment_philosopher2",
			"scroll",
			"first_matter",
			"default_spell",
			"breath_of_life",
			"breath_of_life_respawn",
			"dying_breath_taken",
		]
		
		var elligible_items = []
		for i in GameLoader.items.size():
			var item = GameLoader.items.values()[i]
			if item.id not in excluded_items:
				elligible_items.append(item)
		
		## Separate active Items from ingredients so that active Items are only swapped with other active Items
		## (Ensures all Units have usable inventory items)
		var spells_check = elligible_items.duplicate()
		var spells = []
		for i in spells_check.size():
			var item = spells_check[i]
			if item.behaviors:
				spells.append(item)
				elligible_items.erase(item)
		
		## First Pass -- randomize all Item IDs
		var rand_items = elligible_items.duplicate()
		rand_items.shuffle()
		
		var done_items = []
		for i in rand_items.size():
			if rand_items[i].id not in done_items and elligible_items[i].id not in done_items:
				if elligible_items[i].id == rand_items[i].id:
					print("RandomMod: Items: 1st Pass: " + elligible_items[i].id + " chose self")
					continue
				var tmp_id = rand_items[i].id
				print("RandomMod: Items: 1st Pass: Swapping (1) " + elligible_items[i].id + " and (2) " + rand_items[i].id)
				rand_items[i].id = elligible_items[i].id
				elligible_items[i].id = tmp_id
				print("RandomMod: Items: 1st Pass: Results: (1) " + elligible_items[i].id + " and (2) " + rand_items[i].id)
				
				done_items.append(rand_items[i].id )
				done_items.append(elligible_items[i].id )
		
		## Second Pass -- Randomize active Item IDs
		var rand_spells = spells.duplicate()
		rand_spells.shuffle()
		
		var done_spells = []
		for i in rand_spells.size():
			if rand_spells[i].id not in done_spells and spells[i].id not in done_spells:
				if elligible_items[i].id == rand_items[i].id:
					print("RandomMod: Items: 2nd Pass: " + elligible_items[i].id + " chose self")
					continue
				var tmp_id = rand_spells[i].id
				print("RandomMod: Items: 2nd Pass: Swapping (1) " + spells[i].id + " and (2) " + rand_spells[i].id)
				rand_spells[i].id = spells[i].id
				spells[i].id = tmp_id
				print("RandomMod: Items: 2nd Pass: Results: (1) " + spells[i].id + " and (2) " + rand_spells[i].id)
				
				done_spells.append(rand_spells[i].id )
				done_spells.append(spells[i].id )
		
		## Set all Item references to ID
		GameLoader.set_all_items_to_id()
	
	## UNITS
	if randomize_units:
		## Exclude specific units
		var excluded_units = [
			"player",
			"phoenix"
		]
		
		var elligible_units = []
		for i in GameLoader.units.size():
				var unit = GameLoader.units.values()[i]
				if unit.id not in excluded_units:
					elligible_units.append(unit)
		
		## Randomize Unit IDs
		var rand_units = elligible_units.duplicate()
		rand_units.shuffle()
		
		var done_units = []
		for i in rand_units.size():
			if rand_units[i].id not in done_units and elligible_units[i].id not in done_units:
				if elligible_units[i].id == rand_units[i].id:
					print("RandomMod: Units: " + elligible_units[i].id + " chose self")
					continue
				var tmp_id = rand_units[i].id
				print("RandomMod: Units: Swapping (1) " + elligible_units[i].id + " and (2) " + rand_units[i].id)
				rand_units[i].id = elligible_units[i].id
				elligible_units[i].id = tmp_id
				print("RandomMod: Units: Results: (1) " + elligible_units[i].id + " and (2) " + rand_units[i].id)
				
				done_units.append(rand_units[i].id )
				done_units.append(elligible_units[i].id )
		
		## Set all Unit references to ID
		GameLoader.set_all_units_to_id()
