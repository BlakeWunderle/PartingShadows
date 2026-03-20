class_name CompendiumListView extends VBoxContainer

## Paginated grid view displaying compendium cards.
## Uses CompendiumCard for each item and PaginationControls for navigation.

signal card_clicked(item_data: Dictionary, is_discovered: bool)

const CompendiumCard := preload("res://scripts/ui/compendium/compendium_card.gd")
const PaginationControls := preload("res://scripts/ui/compendium/pagination_controls.gd")

var items: Array = []  ## Array of {item data, is_discovered} dictionaries
var items_per_page: int = 12  ## Default: 3 rows × 4 columns

var _grid: GridContainer
var _scroll: ScrollContainer
var _pagination: PaginationControls
var _current_page: int = 1


func _ready() -> void:
	add_theme_constant_override("separation", 12)

	# Scroll container for grid
	_scroll = ScrollContainer.new()
	_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_scroll.custom_minimum_size = Vector2(800, 420)
	add_child(_scroll)

	# Grid container
	_grid = GridContainer.new()
	_grid.columns = 4
	_grid.add_theme_constant_override("h_separation", 10)
	_grid.add_theme_constant_override("v_separation", 10)
	_scroll.add_child(_grid)

	# Pagination controls
	_pagination = PaginationControls.new()
	_pagination.page_changed.connect(_on_page_changed)
	add_child(_pagination)

	_refresh_page()


## Set items and refresh display
func set_items(new_items: Array, per_page: int = 12, columns: int = 4) -> void:
	items = new_items
	items_per_page = per_page
	_current_page = 1
	if is_node_ready():
		_grid.columns = columns
		_refresh_page()


## Get current page items
func _get_page_items() -> Array:
	var total_pages := ceili(float(items.size()) / float(items_per_page))
	_pagination.total_pages = total_pages

	var start_idx := (_current_page - 1) * items_per_page
	var end_idx := mini(start_idx + items_per_page, items.size())

	var page_items: Array = []
	for i in range(start_idx, end_idx):
		page_items.append(items[i])
	return page_items


## Refresh grid with current page items
func _refresh_page() -> void:
	if not is_node_ready():
		return

	# Reset scroll position
	_scroll.scroll_vertical = 0

	# Clear grid
	for child in _grid.get_children():
		child.queue_free()

	# Add cards for current page
	var page_items := _get_page_items()
	for item_dict: Dictionary in page_items:
		var card := CompendiumCard.new()
		card.set_item(item_dict.get("data", {}), item_dict.get("is_discovered", false))
		card.clicked.connect(func(data: Dictionary) -> void:
			card_clicked.emit(data, item_dict.get("is_discovered", false))
		)
		_grid.add_child(card)


func _on_page_changed(new_page: int) -> void:
	_current_page = new_page
	_refresh_page()
