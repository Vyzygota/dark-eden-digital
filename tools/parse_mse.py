import os
import json
import re

RAW_DATA_PATH = "raw_data"
OUTPUT_FILE = "data/cards_db.json"

def parse_resources(raw_str):
    mapping = {
        "1": "Blue_Gold",
        "2": "Blue_Food",
        "3": "Blue_Materials",
        "4": "Blue_Fuel",
        "6": "Red_Gold",
        "7": "Red_Food",
        "8": "Red_Materials",
        "9": "Red_Fuel"
    }
    result = []
    # Match <sym-auto>X</sym-auto>
    matches = re.findall(r'<sym-auto>(.*?)</sym-auto>', raw_str)
    for m in matches:
        if m in mapping:
            result.append(mapping[m])
        else:
            result.append(f"Unknown_{m}")
    return result

def finalize_card(card, key, value):
    if not key or not value:
        return
    
    if key == "Name":
        card["name"] = value
    elif key == "Resources":
        card["resources"] = parse_resources(value)
    elif key == "Action":
        card["action"] = value
    elif key == "Image":
        card["image"] = value
    elif key == "Affiliation":
        card["affiliation"] = value
    elif key == "Air":
        card["air"] = True if value == "Yes" else False
    elif key == "Sea":
        card["sea"] = True if value == "Yes" else False
    elif key == "Land":
        card["land"] = True if value == "Yes" else False
    elif key == "CV":
        try:
            card["cv"] = int(value)
        except:
            card["cv"] = value
    elif key == "CV1":
        try:
            card["cv1"] = int(value)
        except:
            card["cv1"] = value
    elif key == "Autor":
        card["author"] = value
    else:
        card[key.lower()] = value

def parse_set_file(filepath, category):
    cards = []
    current_card = None
    in_card = False
    current_key = ""
    current_value = ""

    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line_str = line.rstrip('\n')
            
            if line_str == "card:":
                if current_card is not None:
                    finalize_card(current_card, current_key, current_value)
                    cards.append(current_card)
                current_card = {"category": category}
                in_card = True
                current_key = ""
                current_value = ""
                continue
                
            if not in_card:
                continue
                
            if line_str.startswith("\t\t"):
                text = line_str[2:].strip()
                if text:
                    if current_value:
                        current_value += " " + text
                    else:
                        current_value = text
            elif line_str.startswith("\t"):
                if current_key:
                    finalize_card(current_card, current_key, current_value)
                    
                content = line_str[1:]
                colon_idx = content.find(":")
                if colon_idx != -1:
                    current_key = content[:colon_idx].strip()
                    current_value = content[colon_idx+1:].strip()
                else:
                    current_key = ""
                    current_value = ""

    if current_card is not None:
        finalize_card(current_card, current_key, current_value)
        cards.append(current_card)
        
    return cards

def main():
    print("Rozpoczynam ekstrakcję danych MSE (Python)...")
    all_cards = []
    
    if not os.path.exists(RAW_DATA_PATH):
        print(f"Folder {RAW_DATA_PATH} nie istnieje.")
        return
        
    for folder_name in os.listdir(RAW_DATA_PATH):
        folder_path = os.path.join(RAW_DATA_PATH, folder_name)
        if os.path.isdir(folder_path) and not folder_name.startswith('.'):
            set_file_path = os.path.join(folder_path, "set.txt")
            if os.path.exists(set_file_path):
                category = folder_name
                print(f"Parsowanie {category}...")
                set_cards = parse_set_file(set_file_path, category)
                all_cards.extend(set_cards)

    if not os.path.exists("data"):
        os.makedirs("data")

    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        json.dump(all_cards, f, ensure_ascii=False, indent=4)
        
    print(f"Ekstrakcja zakończona. Wygenerowano {len(all_cards)} kart do {OUTPUT_FILE}.")

if __name__ == "__main__":
    main()
