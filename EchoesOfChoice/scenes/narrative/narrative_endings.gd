class_name NarrativeEndings

## Pure text-returning helpers for story endings and unlock notifications.
## No scene dependencies; all methods are static and take only primitive parameters.


static func get_ending_text_story_1(game_won: bool) -> Array[String]:
	if game_won:
		return [
			"The stranger is gone and with them, the shadow that covered the land.",
			"The sky clears. The city stirs. People emerge from hiding.",
			"It will take time, but the world will heal.",
			"Our heroes stand in the light, bruised and exhausted and alive.",
			"Every choice left an echo, and theirs will ring through the ages.",
			"",
			"Thank you for playing Echoes of Choice.",
		]
	else:
		return [
			"Our heroes fall and the darkness grows a little stronger.",
			"This journey may be over, but every great story deserves another telling.",
		]


static func get_ending_text_story_2(game_won: bool) -> Array[String]:
	if game_won:
		return [
			"The Eye closes for the last time. The crystallized memories shatter, and light rises from the depths like a thousand lanterns set free.",
			"Across the coast, people stop mid-sentence. A name they forgot. A face they lost. A moment that was taken, returned without explanation.",
			"The old woman in the fishing village remembers the dinner. The blacksmith remembers why the sword was urgent. The barkeep remembers the conversations.",
			"Deep below, in the place where the Eye once watched, the party stands in silence. The machinery is dark. The crystals are empty.",
			"A voice, faint as breath, echoes through the chamber. Sera's voice, carried on the last of the light.",
			"'Thank you.'",
			"They carry her memory with them. Not because they have to. Because they choose to.",
			"",
			"Thank you for playing Echoes of Choice.",
		]
	else:
		return [
			"The Eye remains open. The memories do not return.",
			"In the darkness below the world, something watches. Something waits. Something remembers everything it has taken.",
			"This journey may be over, but every great story deserves another telling.",
		]


static func get_ending_text_story_3(game_won: bool, battle_id: String) -> Array[String]:
	var is_path_b: bool = battle_id == "S3_B_DreamNexus"
	var is_path_c: bool = battle_id == "S3_C_DreamNexus"
	if game_won:
		if is_path_c:
			return _get_ending_text_story_3_path_c()
		if is_path_b:
			return _get_ending_text_story_3_path_b()
		return _get_ending_text_story_3_path_a()
	else:
		if is_path_c:
			return [
				"The Threadmaster pulls Lira back into the threads. Her scream fades into the hum of the Loom. The dream tightens, and the travelers forget they ever heard her voice.",
				"Somewhere in a quiet town, a serving girl pours ale with trembling hands. The chains beneath her skin pulse, and she cannot remember why she is crying.",
				"This journey may be over, but every great story deserves another telling.",
			]
		if is_path_b:
			return [
				"The threads hold. The girl smiles. She was always going to smile.",
				"Somewhere in a quiet town, a serving girl pours ale for the next weary traveler. She has done this for centuries. She will do it for centuries more.",
				"This journey may be over, but every great story deserves another telling.",
			]
		return [
			"The Loom holds. The threads tighten. The dream does not end.",
			"Somewhere in a quiet town, a kind face smiles and pours ale for the next weary traveler. She was never real, but no one will ever know.",
			"This journey may be over, but every great story deserves another telling.",
		]


static func _get_ending_text_story_3_path_a() -> Array[String]:
	return [
		"The Loom is broken. The threads dissolve into the morning light, carrying with them every stolen dream, every pilfered night of rest.",
		"Across the town, people wake feeling something they cannot name. A lightness. A clarity. As if a weight they never knew they carried has been lifted.",
		"Where the innkeeper stood, there is nothing. No body, no trace. She was never real. Just another thread in the Loom, a familiar face woven from stolen dreams to lure the weary inside.",
		"The travelers stand in the street as the sun rises. For the first time in days, they are not tired. The weariness is gone, truly gone, and the road ahead feels possible again.",
		"'The Weary Traveler,' one of them reads aloud from the sign, shaking their head. 'She named the inn after what she was doing to people.'",
		"Lira watches from the doorway as they leave. Her hand rests on the doorframe, fingers tracing a pattern they cannot see.",
		"They leave the town behind. Their dreams that night are their own.",
		"",
		"Thank you for playing Echoes of Choice.",
	]


static func _get_ending_text_story_3_path_b() -> Array[String]:
	return [
		"The Loom is broken. Not by trust. By suspicion. By the courage to look at a kind face and ask what it was hiding.",
		"Across the town, people wake differently. Not gently. Sharply, like cold water. The fog lifts and what remains is a town that must learn what it is without the lie that sustained it.",
		"There is no serving girl to pour the morning ale. No innkeeper to smile and ask if they slept well. The woman behind every face this town has ever known is gone, unraveled with the threads she wove.",
		"Brother Callum stands in the town square as the sun rises. He does not look away from the questions.",
		"The travelers leave by midmorning. Their dreams that night are quiet, and empty, and entirely their own.",
		"",
		"Thank you for playing Echoes of Choice.",
	]


static func _get_ending_text_story_3_path_c() -> Array[String]:
	return [
		"The Loom is broken. Not by force. Not by suspicion. By the simplest thing in the world: one person asking another to tell the truth.",
		"Across the town, people wake lighter than they have in years. The fog lifts. The cult members stir and look at their hands as if seeing them for the first time.",
		"Lira stands in the doorway of the inn. She is not the innkeeper. She never was. But she pours the morning ale for those who want it, and this time, the smile is her own.",
		"She looks different in the daylight. The centuries of the Loom's weight have lifted, and what remains is a woman who has been fighting alone for a very long time and has finally, at last, stopped running.",
		"'I do not know what I am now,' she says. 'I have been the Threadmaster's prisoner for so long that I forgot what it felt like to just be a person.'",
		"One of the travelers sets a cup of ale in front of her. 'Start with breakfast,' they say. 'Figure the rest out later.'",
		"They leave the town by midmorning, truly rested. Their dreams that night are kind.",
		"",
		"Thank you for playing Echoes of Choice.",
	]


static func get_unlock_notification_lines(story_id: String) -> Array[String]:
	match story_id:
		"story_1":
			return [
				"",
				"New content unlocked!",
				"A new story awaits: \"Echoes in the Dark.\" Three strangers wake in a cave with no memory.",
				"A new class has emerged: the Wanderer. A wilderness fighter who learned to endure the land's magic.",
			]
		"story_2":
			return [
				"",
				"New content unlocked!",
				"A new story awaits: \"The Woven Night.\" Three travelers rest at a quiet inn. Their dreams are not their own.",
			]
		"story_3":
			return [
				"",
				"New content unlocked!",
				"You have completed all available stories. More adventures may follow.",
			]
		_:
			return []
