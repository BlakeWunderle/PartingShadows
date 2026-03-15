class_name VotePanel extends VBoxContainer

## Per-player branch voting. Local co-op uses sequential selection,
## online MP uses simultaneous voting with RPC coordination.
## Majority wins; ties broken randomly.

signal vote_resolved(winning_index: int)

const ChoiceMenu := preload("res://scripts/ui/choice_menu.gd")

var _choices: Array[Dictionary] = []
var _player_count: int = 0
var _votes: Array[int] = []  ## -1 = not voted yet
var _current_voter: int = 0
var _is_online: bool = false
var _choice_menu: ChoiceMenu
var _status_label: Label
var _vote_labels: Array[Label] = []


func _init() -> void:
	add_theme_constant_override("separation", 12)
	alignment = BoxContainer.ALIGNMENT_CENTER


func _ready() -> void:
	_status_label = Label.new()
	_status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_status_label.add_theme_font_size_override("font_size", 20)
	_status_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	add_child(_status_label)

	# Per-player vote status row
	var vote_row := HBoxContainer.new()
	vote_row.alignment = BoxContainer.ALIGNMENT_CENTER
	vote_row.add_theme_constant_override("separation", 24)
	add_child(vote_row)

	# These get populated in start_local/start_online
	_vote_labels = []

	_choice_menu = ChoiceMenu.new()
	_choice_menu.choice_selected.connect(_on_local_vote)
	_choice_menu.visible = false
	add_child(_choice_menu)


## Start local co-op sequential voting.
func start_local(choices: Array[Dictionary], count: int) -> void:
	_is_online = false
	_choices = choices
	_player_count = count
	_votes.clear()
	for i: int in count:
		_votes.append(-1)
	_build_vote_labels()
	_current_voter = 0
	visible = true
	_show_local_voter()


## Start online multiplayer simultaneous voting.
func start_online(choices: Array[Dictionary]) -> void:
	_is_online = true
	_choices = choices
	_player_count = NetManager.get_connected_peer_count()
	_votes.clear()
	for i: int in _player_count:
		_votes.append(-1)
	_build_vote_labels()
	visible = true
	_status_label.text = "Choose your path:"
	_choice_menu.show_choices(_choices)


func _build_vote_labels() -> void:
	# Clear existing vote labels
	for label: Label in _vote_labels:
		label.queue_free()
	_vote_labels.clear()

	# Find the vote row (second child)
	var vote_row: HBoxContainer = get_child(1) as HBoxContainer
	for i: int in _player_count:
		var label := Label.new()
		label.add_theme_font_size_override("font_size", 16)
		_update_vote_label(label, i)
		vote_row.add_child(label)
		_vote_labels.append(label)


func _update_vote_label(label: Label, index: int) -> void:
	var name: String
	if _is_online:
		var peers: Array[int] = []
		for pid: int in NetManager.peer_names:
			peers.append(pid)
		peers.sort()
		if index < peers.size():
			name = NetManager.peer_names.get(peers[index], "Player %d" % (index + 1))
		else:
			name = "Player %d" % (index + 1)
	else:
		name = LocalCoop.get_player_name(index)

	if _votes[index] >= 0:
		label.text = "%s: Voted" % name
		label.add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))
	else:
		label.text = "%s: ..." % name
		label.add_theme_color_override("font_color", Color(0.6, 0.65, 0.7))


func _refresh_vote_labels() -> void:
	for i: int in _vote_labels.size():
		_update_vote_label(_vote_labels[i], i)


func _show_local_voter() -> void:
	LocalCoop.set_active_player(_current_voter)
	_status_label.text = "%s, choose your path:" % LocalCoop.get_player_name(_current_voter)
	_choice_menu.show_choices(_choices)


func _on_local_vote(index: int) -> void:
	if _is_online:
		# Online: this is my local vote
		_choice_menu.hide_menu()
		var my_idx: int = _get_local_peer_index()
		_votes[my_idx] = index
		_refresh_vote_labels()
		_check_all_voted()
		return

	# Local co-op: sequential
	_votes[_current_voter] = index
	_refresh_vote_labels()
	_choice_menu.hide_menu()
	_current_voter += 1

	if _current_voter >= _player_count:
		LocalCoop.clear_active_player()
		_resolve_votes()
	else:
		_show_local_voter()


## Online MP: receive a remote player's vote (called by scene RPC).
func receive_vote(player_index: int, choice_index: int) -> void:
	if player_index >= 0 and player_index < _votes.size():
		_votes[player_index] = choice_index
		_refresh_vote_labels()
		_check_all_voted()


func _check_all_voted() -> void:
	for v: int in _votes:
		if v < 0:
			return
	_resolve_votes()


func _resolve_votes() -> void:
	# Tally votes
	var tally: Dictionary = {}
	for v: int in _votes:
		tally[v] = tally.get(v, 0) + 1

	# Find max vote count
	var max_count: int = 0
	for count: int in tally.values():
		if count > max_count:
			max_count = count

	# Collect winners (may be tied)
	var winners: Array[int] = []
	for choice_idx: int in tally:
		if tally[choice_idx] == max_count:
			winners.append(choice_idx)

	# Break ties randomly
	var winner: int = winners[randi() % winners.size()]

	# Show result briefly
	var winner_label: String = _choices[winner].get("label", "???")
	_choice_menu.visible = false
	_status_label.text = "Path chosen: %s" % winner_label
	_status_label.add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))

	await get_tree().create_timer(1.5).timeout
	visible = false
	vote_resolved.emit(winner)


func _get_local_peer_index() -> int:
	var peers: Array[int] = []
	for pid: int in NetManager.peer_names:
		peers.append(pid)
	peers.sort()
	return peers.find(multiplayer.get_unique_id())
