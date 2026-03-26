class_name PartyCreationText

## Pure text helpers for the party creation scene.
## All methods are static and return narrative string arrays with no scene dependencies.


static func get_intro_text(story_id: String) -> Array[String]:
	if story_id == "story_2":
		return get_intro_text_s2()
	if story_id == "story_3":
		return get_intro_text_s3()
	return [
		"The Copper Mug. Your regular haunt. You know every crack in the floorboards, every stain on the bar.",
		"But tonight something is different. The fire burns low without anyone stoking it. The other regulars have gone quiet.",
		"A shrouded stranger sits in the corner booth, one that was empty just a moment ago.",
		"The air feels heavy. Wrong. Like the room itself is holding its breath.",
		"The stranger catches your eye and waves you over.",
	]


static func get_bridge_1_text(story_id: String) -> Array[String]:
	if story_id == "story_2":
		return get_bridge_1_text_s2()
	if story_id == "story_3":
		return get_bridge_1_text_s3()
	return [
		"Shortly after, another warrior overhears the conversation and slides into the booth.",
		"The stranger looks them over and asks the same question.",
	]


static func get_bridge_2_text(story_id: String) -> Array[String]:
	if story_id == "story_2":
		return get_bridge_2_text_s2()
	if story_id == "story_3":
		return get_bridge_2_text_s3()
	return [
		"One last warrior takes a seat at the now crowded table.",
		"The stranger doesn't even hesitate.",
	]


static func get_outro_text(story_id: String) -> Array[String]:
	if story_id == "story_2":
		return get_outro_text_s2()
	if story_id == "story_3":
		return get_outro_text_s3()
	return [
		"The stranger leans in close, voice barely above a whisper.",
		"'Something evil has taken root beyond the forest. The city needs heroes whether it knows it or not.'",
		"'Find the source. End it. I'll be watching, and I'll find you when the time is right.'",
		"The stranger raises a glass but doesn't drink. Just holds it, watching the liquid catch the firelight.",
		"Then they set it down, untouched, and disappear into the crowd. The coin left on the table is gold. Blank on one side.",
	]


# --- Story 2: Cave amnesia narrative ---

static func get_intro_text_s2() -> Array[String]:
	return [
		"Darkness. Complete, suffocating darkness.",
		"A sound. Dripping water. The echo of breathing that isn't yours.",
		"Your eyes adjust. Stone walls. A low ceiling. A cave.",
		"You don't know where you are. You don't know how you got here.",
		"You don't know who you are.",
		"But you're not alone. Two other figures stir in the darkness nearby.",
	]


static func get_bridge_1_text_s2() -> Array[String]:
	return [
		"A groan from deeper in the cave. Someone else is here.",
		"They stumble into the faint light, clutching their head. Same confusion. Same emptiness.",
	]


static func get_bridge_2_text_s2() -> Array[String]:
	return [
		"A third figure pulls themselves up from the stone floor, blinking against the dim glow.",
		"No recognition. No memory. Just another stranger in the dark.",
	]


static func get_outro_text_s2() -> Array[String]:
	return [
		"Three strangers. No memories. A cave that hums with a light that shouldn't exist.",
		"The crystal veins in the walls pulse faintly, pointing deeper into the dark.",
		"Whatever answers exist, they're not here. The only way out is forward.",
	]


# --- Story 3: Inn arrival narrative ---

static func get_intro_text_s3() -> Array[String]:
	return [
		"The road has been long and the light is fading. A town appears between the hills, smaller than expected, but the sign above the inn door glows warm in the dusk.",
		"'The Weary Traveler.' The name alone is enough.",
		"Inside, the common room is everything a tired body could want. A fire crackles in the hearth. The smell of roasted meat and fresh bread fills the air.",
		"The innkeeper, a thin woman with deep-set eyes, looks up from behind the bar. Her smile is practiced and perfect.",
		"'Welcome. You look like you could use a meal and a bed. Sit anywhere you like.'",
		"The long table near the fire has room. Other travelers are already eating.",
	]


static func get_bridge_1_text_s3() -> Array[String]:
	return [
		"Another traveler settles onto the bench across the table, setting down a heavy pack.",
		"'Mind if I sit? Everywhere else is taken.' It isn't, but the fire is warm and the company is welcome.",
	]


static func get_bridge_2_text_s3() -> Array[String]:
	return [
		"A third traveler appears at the end of the table, plate in hand, looking for a seat.",
		"'Room for one more?' They sit without waiting for an answer.",
	]


static func get_outro_text_s3() -> Array[String]:
	return [
		"Three strangers sharing a table, a meal, and stories of the road.",
		"The innkeeper refills their cups without being asked. 'Stay as long as you like,' she says. 'Most people do.'",
		"A young serving girl with auburn hair clears the plates. She pauses, watching the three of them for a moment longer than seems natural, then disappears into the kitchen.",
		"The fire burns low. The conversation fades. The beds upstairs are calling.",
		"Sleep comes fast. Faster than it should.",
	]
