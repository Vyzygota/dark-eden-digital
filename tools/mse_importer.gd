@tool
extends EditorScript

const RAW_DATA_PATH = "res://raw_data/"
const OUTPUT_FILE = "res://data/cards_db.json"

func _run():
	print("Rozpoczynam ekstrakcję danych MSE...")
	var data = parse_all_sets()
	save_json(data, OUTPUT_FILE)
	print("Ekstrakcja zakończona. Wygenerowano %d kart." % data.size())

func parse_all_sets() -> Array:
	var cards = []
	var dir = DirAccess.open(RAW_DATA_PATH)
	if dir:
		dir.list_dir_begin()
		var folder_name = dir.get_next()
		while folder_name != "":
			if dir.current_is_dir() and not folder_name.begins_with("."):
				var set_file_path = RAW_DATA_PATH + folder_name + "/set.txt"
				if FileAccess.file_exists(set_file_path):
					var set_cards = parse_set_file(set_file_path, folder_name)
					cards.append_array(set_cards)
			folder_name = dir.get_next()
	else:
		print("Nie można otworzyć folderu: " + RAW_DATA_PATH)
		
	return cards

func parse_set_file(path: String, category: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		print("Nie można otworzyć pliku: " + path)
		return []
		
	var cards = []
	var current_card = null
	var in_card = false
	var current_key = ""
	var current_value = ""

	while not file.eof_reached():
		var line = file.get_line()
		
		# Nowa karta
		if line == "card:":
			if current_card != null:
				_finalize_card(current_card, current_key, current_value)
				cards.append(current_card)
			current_card = {"category": category}
			in_card = true
			current_key = ""
			current_value = ""
			continue
			
		if not in_card:
			continue
			
		# Sprawdzamy wcięcia
		if line.begins_with("\t\t"):
			# Kontynuacja wielolinijkowej wartości (np. Nazwa w kilku linijkach)
			var text = line.substr(2).strip_edges()
			if text != "":
				if current_value != "":
					current_value += " " + text
				else:
					current_value = text
		elif line.begins_with("\t"):
			# Nowy atrybut (pojedynczy tabulator)
			if current_key != "":
				_finalize_card(current_card, current_key, current_value)
				
			var content = line.substr(1)
			var colon_idx = content.find(":")
			if colon_idx != -1:
				current_key = content.substr(0, colon_idx).strip_edges()
				current_value = content.substr(colon_idx + 1).strip_edges()
			else:
				current_key = ""
				current_value = ""

	if current_card != null:
		_finalize_card(current_card, current_key, current_value)
		cards.append(current_card)
		
	return cards

func _finalize_card(card: Dictionary, key: String, value: String):
	if key == "" or value == "":
		return
		
	if key == "Name":
		card["name"] = value
	elif key == "Resources":
		card["resources"] = _parse_resources(value)
	elif key == "Action":
		card["action"] = value
	elif key == "Image":
		card["image"] = value
	elif key == "Affiliation":
		card["affiliation"] = value
	elif key == "Air":
		card["air"] = true if value == "Yes" else false
	elif key == "Sea":
		card["sea"] = true if value == "Yes" else false
	elif key == "Land":
		card["land"] = true if value == "Yes" else false
	elif key == "CV":
		card["cv"] = value.to_int()
	elif key == "CV1":
		card["cv1"] = value.to_int()
	elif key == "Autor":
		card["author"] = value
	else:
		card[key.to_lower()] = value

func _parse_resources(raw_str: String) -> Array:
	var result = []
	var regex = RegEx.new()
	regex.compile("<sym-auto>(.*?)</sym-auto>")
	for regex_match in regex.search_all(raw_str):
		var res_val = regex_match.get_string(1)
		result.append(res_val)
	return result

func save_json(data: Array, path: String):
	# Zapewnij istnienie folderu data/
	var dir = DirAccess.open("res://")
	if not dir.dir_exists("data"):
		dir.make_dir("data")
		
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()
	else:
		print("Błąd zapisu pliku: " + path)
