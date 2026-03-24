class_name PauseSaveSlots
extends RefCounted

## Save-slot sub-menu logic extracted from PauseOverlay.
## Manages showing save slots, handling selection / overwrite / delete,
## performing the save, and navigating back to the main pause menu.

const StoryDB := preload("res://scripts/data/story_db.gd")

var _overlay: CanvasLayer  # The PauseOverlay instance


func _init(overlay: CanvasLayer) -> void:
	_overlay = overlay


# =============================================================================
# Show save slots
# =============================================================================

func show_save_slots() -> void:
	_overlay._mode = _overlay.Mode.SAVE_SLOTS
	_overlay._main_vbox.visible = false

	# Clear old slot buttons
	for child: Node in _overlay._save_vbox.get_children():
		child.queue_free()

	# Build slot buttons with summaries
	for i: int in SaveManager.MAX_SAVE_SLOTS:
		var summary: Dictionary = SaveManager.get_save_summary(i)
		var label: String
		if summary.get("exists", false):
			var story_title: String = StoryDB.get_story(
				summary.get("story_id", "story_1")).get("title", "")
			var secs: float = summary.get("play_seconds", 0.0)
			var h: int = int(secs) / 3600
			var m: int = (int(secs) % 3600) / 60
			label = "Slot %d: %s the %s - Lv %d (%s) [%dh %dm]" % [
				i + 1,
				summary.get("lead_name", "???"),
				summary.get("lead_class", "???"),
				summary.get("level", 1),
				story_title,
				h, m,
			]
		else:
			label = "Slot %d: Empty" % [i + 1]
		var btn: Button = _overlay._make_button(label)
		var slot: int = i  # Capture for lambda
		btn.pressed.connect(on_save_slot_selected.bind(slot))
		_overlay._save_vbox.add_child(btn)

		# Delete button for occupied slots
		if summary.get("exists", false):
			var del_btn: Button = _overlay._make_button("  Delete Slot %d" % [i + 1])
			del_btn.add_theme_color_override("font_color", Color(0.8, 0.4, 0.4))
			del_btn.custom_minimum_size.y = 28
			del_btn.pressed.connect(on_delete_slot_selected.bind(slot))
			_overlay._save_vbox.add_child(del_btn)

	# Back button
	var back_btn: Button = _overlay._make_button("Back")
	back_btn.pressed.connect(_overlay._back_to_main)
	_overlay._save_vbox.add_child(back_btn)

	_overlay._save_vbox.visible = true

	# Focus first slot after frame so buttons are ready
	await _overlay.get_tree().process_frame
	if _overlay._save_vbox.get_child_count() > 0:
		var first: Button = _overlay._save_vbox.get_child(0) as Button
		if first:
			first.grab_focus()


# =============================================================================
# Slot selection / overwrite
# =============================================================================

func on_save_slot_selected(slot: int) -> void:
	if SaveManager.has_save(slot):
		_overlay._pending_save_slot = slot
		_overlay._confirm_dialog.confirmed.connect(on_overwrite_confirmed, CONNECT_ONE_SHOT)
		_overlay._confirm_dialog.show_confirm("Overwrite this save?")
	else:
		do_save(slot)


func on_overwrite_confirmed(accepted: bool) -> void:
	if accepted and _overlay._pending_save_slot >= 0:
		do_save(_overlay._pending_save_slot)
	_overlay._pending_save_slot = -1


# =============================================================================
# Perform save
# =============================================================================

func do_save(slot: int) -> void:
	SaveManager.save_to_slot(slot)
	for i: int in _overlay._save_vbox.get_child_count():
		var btn: Button = _overlay._save_vbox.get_child(i) as Button
		if btn and i == slot:
			btn.text = "Slot %d: Saved!" % [slot + 1]
	await _overlay.get_tree().create_timer(0.6).timeout
	if _overlay._mode == _overlay.Mode.SAVE_SLOTS:
		_overlay._back_to_main()


# =============================================================================
# Delete slot
# =============================================================================

func on_delete_slot_selected(slot: int) -> void:
	_overlay._pending_save_slot = slot
	_overlay._confirm_dialog.confirmed.connect(on_delete_confirmed, CONNECT_ONE_SHOT)
	_overlay._confirm_dialog.show_confirm("Delete this save? This cannot be undone.")


func on_delete_confirmed(accepted: bool) -> void:
	if accepted and _overlay._pending_save_slot >= 0:
		SaveManager.delete_save(_overlay._pending_save_slot)
		show_save_slots()  # Refresh the slot list
	_overlay._pending_save_slot = -1
