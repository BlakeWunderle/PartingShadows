class_name BattleDisplay
extends RefCounted

## Display helper for the battle scene. Handles floating damage numbers,
## portrait cards, turn order display, and post-battle summary overlay.

const FighterData := preload("res://scripts/data/fighter_data.gd")
const AbilityData := preload("res://scripts/data/ability_data.gd")
const PortraitCard := preload("res://scripts/ui/portrait_card.gd")

var _battle: Control


func _init(battle: Control) -> void:
	_battle = battle


func on_combat_event(target: FighterData, amount: int, event_type: String) -> void:
	# Track battle stats for party members (independent of card visuals)
	if event_type in ["damage", "crit", "spell_damage", "spell_crit"]:
		if _battle._current_actor != null and _battle._battle_stats.has(_battle._current_actor):
			_battle._battle_stats[_battle._current_actor]["damage_dealt"] += amount
		if _battle._battle_stats.has(target):
			_battle._battle_stats[target]["damage_taken"] += amount
	elif event_type == "heal":
		if _battle._current_actor != null and _battle._battle_stats.has(_battle._current_actor):
			_battle._battle_stats[_battle._current_actor]["healing_done"] += amount

	var card: PortraitCard = find_card_for_fighter(target)
	if not card:
		return
	match event_type:
		"damage":
			SFXManager.play(SFXManager.Category.STRIKE)
			card.flash_hit()
			card.show_floating_text("-%d" % amount, Color(1.0, 0.3, 0.3))
		"crit":
			SFXManager.play(SFXManager.Category.IMPACT)
			card.flash_hit()
			card.show_floating_text("-%d!" % amount, Color(1.0, 0.85, 0.2), 22)
		"spell_damage":
			SFXManager.play(SFXManager.Category.SPELL)
			card.flash_hit()
			card.show_floating_text("-%d" % amount, Color(0.6, 0.4, 1.0))
		"spell_crit":
			SFXManager.play(SFXManager.Category.IMPACT)
			card.flash_hit()
			card.show_floating_text("-%d!" % amount, Color(1.0, 0.85, 0.2), 22)
		"heal":
			SFXManager.play(SFXManager.Category.SHIMMER)
			card.show_floating_text("+%d" % amount, Color(0.3, 1.0, 0.4))
		"buff":
			SFXManager.play(SFXManager.Category.BUFF)
			card.show_floating_text("BUFF", Color(0.4, 0.8, 1.0))
			_battle._tip_overlay.show_tip_once("status_effects",
				"Buffs and debuffs modify a fighter's stats for several " +
				"turns. Watch for status icons on the fighter portraits.\n\n" +
				"Select Stats during your turn to see exact effects on " +
				"each party member.")
		"debuff":
			SFXManager.play(SFXManager.Category.DEBUFF)
			card.show_floating_text("DEBUFF", Color(0.8, 0.3, 0.8))
			_battle._tip_overlay.show_tip_once("status_effects",
				"Buffs and debuffs modify a fighter's stats for several " +
				"turns. Watch for status icons on the fighter portraits.\n\n" +
				"Select Stats during your turn to see exact effects on " +
				"each party member.")
		"miss":
			SFXManager.play(SFXManager.Category.WHOOSH, 0.7)
			card.show_floating_text("MISS", Color(0.7, 0.7, 0.7))
		"mp_restore":
			card.show_floating_text("+%d MP" % amount, Color(0.3, 0.6, 1.0))
			card.update_display(target)
		"block":
			SFXManager.play(SFXManager.Category.BUFF)
			card.show_floating_text("BLOCK +%d MP" % amount, Color(0.4, 0.7, 1.0))
			card.update_display(target)
		"rest":
			SFXManager.play(SFXManager.Category.SHIMMER)
			card.show_floating_text("REST +%d MP" % amount, Color(0.5, 0.8, 0.4))
			card.update_display(target)


func find_card_for_fighter(fighter: FighterData) -> PortraitCard:
	for card: PortraitCard in _battle._party_cards:
		if card.get_fighter() == fighter:
			return card
	for card: PortraitCard in _battle._enemy_cards:
		if card.get_fighter() == fighter:
			return card
	return null


func show_battle_summary() -> void:
	var overlay := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.08, 0.12, 0.92)
	style.border_color = Color(0.9, 0.8, 0.5, 0.6)
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	style.set_content_margin_all(24)
	overlay.add_theme_stylebox_override("panel", style)
	overlay.set_anchors_preset(Control.PRESET_CENTER)
	overlay.offset_left = -220.0
	overlay.offset_top = -160.0
	overlay.offset_right = 220.0
	overlay.offset_bottom = 160.0
	overlay.pivot_offset = Vector2(220, 160)
	overlay.modulate.a = 0.0
	overlay.scale = Vector2(0.95, 0.95)
	_battle.add_child(overlay)

	# Fade-in + scale animation
	var intro_tw := _battle.create_tween().set_parallel(true)
	intro_tw.tween_property(overlay, "modulate:a", 1.0, 0.3).set_ease(Tween.EASE_OUT)
	intro_tw.tween_property(overlay, "scale", Vector2(1.0, 1.0), 0.3).set_ease(Tween.EASE_OUT)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	overlay.add_child(vbox)

	var title := Label.new()
	title.text = "BATTLE SUMMARY"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	vbox.add_child(title)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	for f: FighterData in _battle._all_party:
		var stats: Dictionary = _battle._battle_stats.get(f, {})
		var dmg: int = stats.get("damage_dealt", 0)
		var heal: int = stats.get("healing_done", 0)
		var kills: int = stats.get("kills", 0)
		var line := Label.new()
		line.text = "%s the %s  -  DMG: %d, HEAL: %d, KOs: %d" % [
			f.character_name, f.character_type, dmg, heal, kills]
		line.add_theme_font_size_override("font_size", SettingsManager.font_size)
		vbox.add_child(line)

	var hint := Label.new()
	hint.text = "\nPress any key to continue..."
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.add_theme_font_size_override("font_size", 14)
	hint.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
	vbox.add_child(hint)

	# Wait for confirm input or mouse click to dismiss
	await _battle.get_tree().create_timer(0.5, false).timeout  # Brief delay to prevent accidental skip
	_battle._summary_waiting = true
	while _battle._summary_waiting:
		await _battle.get_tree().process_frame
	overlay.queue_free()


func on_fighter_died(fighter: FighterData) -> void:
	# Track kills for party members
	if _battle._current_actor != null and _battle._battle_stats.has(_battle._current_actor) \
			and not _battle._all_party.has(fighter):
		_battle._battle_stats[_battle._current_actor]["kills"] += 1


func rebuild_cards_if_needed() -> void:
	# Mark dead fighters' cards as dead (desaturated) instead of hiding
	for card: PortraitCard in _battle._party_cards:
		var fighter: FighterData = card.get_fighter()
		var is_dead: bool = not _battle._engine.units.has(fighter)
		card.set_dead(is_dead)
		card.update_display(fighter)
	for card: PortraitCard in _battle._enemy_cards:
		var fighter: FighterData = card.get_fighter()
		var is_dead: bool = not _battle._engine.enemies.has(fighter)
		card.set_dead(is_dead)
		card.update_display(fighter)


func compute_turn_order() -> void:
	## Predict the next several turns by simulating ATB ticks forward.
	_battle._turn_queue.clear()

	var all_fighters: Array = []
	for f: FighterData in _battle._engine.units:
		all_fighters.append(f)
	for f: FighterData in _battle._engine.enemies:
		all_fighters.append(f)

	if all_fighters.is_empty():
		return

	# Snapshot current ATB values
	var atb: Dictionary = {}
	for f: FighterData in all_fighters:
		atb[f] = f.turn_calculation

	var show_count: int = mini(8, all_fighters.size() * 2)

	while _battle._turn_queue.size() < show_count:
		# Tick until someone reaches 100
		var ready: Array = []
		for _i: int in 200:  # safety limit
			for f: FighterData in all_fighters:
				atb[f] += f.speed
			ready.clear()
			for f: FighterData in all_fighters:
				if atb[f] >= 100:
					ready.append(f)
			if not ready.is_empty():
				break

		if ready.is_empty():
			break

		# Sort by highest ATB (same as get_acting_units)
		ready.sort_custom(func(a: FighterData, b: FighterData) -> bool:
			return atb[a] > atb[b])

		for f: FighterData in ready:
			atb[f] -= 100
			_battle._turn_queue.append(f)


func display_turn_order() -> void:
	## Render the turn queue. Current actor in green, allies cyan, enemies salmon.
	var parts: Array[String] = []

	# Current actor first (green)
	if _battle._current_actor != null:
		parts.append("[color=lime]%s[/color]" % _battle._current_actor.character_name)

	# Remaining queue
	for f: FighterData in _battle._turn_queue:
		if _battle._engine.units.has(f):
			parts.append("[color=cyan]%s[/color]" % f.character_name)
		else:
			parts.append("[color=salmon]%s[/color]" % f.character_name)

	_battle._turn_order_label.clear()
	_battle._turn_order_label.append_text(
		"[color=gray]Turn Order:[/color]  " + "  >  ".join(parts))


func get_portrait_texture(fighter: FighterData) -> Texture2D:
	var key: String
	if fighter.is_user_controlled or fighter.is_shadow:
		key = fighter.character_type + "_" + fighter.portrait_variant
		if fighter.is_shadow:
			key += "_shadow"
	else:
		key = fighter.class_id if not fighter.class_id.is_empty() else fighter.character_type
	if _battle._portrait_cache.has(key):
		return _battle._portrait_cache[key]

	var path: String
	if fighter.is_user_controlled or fighter.is_shadow:
		var slug: String = fighter.character_type.to_lower().replace(" ", "_")
		path = "res://assets/art/portraits/classes/%s_%s.png" % [slug, fighter.portrait_variant]
	else:
		var slug: String = key.to_snake_case()
		path = "res://assets/art/portraits/enemies/%s.png" % slug

	var tex: Texture2D = null
	if ResourceLoader.exists(path):
		tex = load(path) as Texture2D

	_battle._portrait_cache[key] = tex
	return tex


func highlight_active_card(fighter: FighterData) -> void:
	# Deactivate previous
	if _battle._active_card:
		_battle._active_card.set_active(false)
		_battle._active_card = null

	if fighter == null:
		return

	# Find the card for this fighter
	for card: PortraitCard in _battle._party_cards:
		if card.get_fighter() == fighter:
			card.set_active(true)
			_battle._active_card = card
			return
	for card: PortraitCard in _battle._enemy_cards:
		if card.get_fighter() == fighter:
			card.set_active(true)
			_battle._active_card = card
			return
