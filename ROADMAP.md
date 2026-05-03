# Dark Eden Digital – Główny Plan (Roadmapa)

### FAZA 0: Przygotowanie środowiska pracy (Preludium techniczne)
*Zanim dotkniemy logiki gry, budujemy i konfigurujemy nasz "warsztat", abyśmy mogli płynnie współpracować.*
- [x] **0.1**: Pobranie i instalacja Godot Engine (wersja 4.x) oraz założenie projektu "Dark Eden Digital".
- [x] **0.2**: Uruchomienie Google Antigravity na folderze projektu i instalacja wtyczki Godot Tools.
- [x] **0.3**: Skonfigurowanie Godota, aby używał Antigravity jako domyślnego, zewnętrznego edytora skryptów.
- [x] **0.4**: Zapisanie zasad projektu (`.cursorrules`), aby sztuczna inteligencja od początku znała strukturę (GDScript, typowanie, węzły Control).

### FAZA 1: Fundamenty Danych (Baza i Zasoby)
*Przygotowujemy "paliwo" dla naszej gry – surowe statystyki i grafiki.*
- [x] **1.1**: Zautomatyzowana ekstrakcja bazy kart – wyciągnięcie danych z plików MSE (z uwzględnieniem kosztów i przychodów, np. Blue_Gold, Red_Food) i zapisanie ich w pliku `data/cards_db.json`.
- [ ] **1.2**: Zgromadzenie wyciętych grafik (artów) dla kart testowych oraz podstawowych piktogramów w docelowej strukturze folderów projektu (np. `res://assets/images/`).

### FAZA 2: Reprezentacja Wizualna (Karty w silniku)
*Uczymy silnik czytać nasze dane i nadajemy im fizyczny kształt na ekranie.*
- [ ] **2.1**: Założenie przejrzystej struktury folderów w Godocie (osobne foldery na `Scenes`, `Scripts`, `Resources`, `Assets`).
- [ ] **2.2**: Zbudowanie UI (Interfejsu Użytkownika) pojedynczej Karty z klocków Godota (węzły `Control` – tło, miejsce na obrazek, pola tekstowe, układ ikon).
- [ ] **2.3**: Dokończenie importera – skrypt, który weźmie nasz `cards_db.json` i automatycznie utworzy gotowe zasoby (`Resources`) dla konkretnych kart w oparciu o szablon UI z kroku 2.2.

### FAZA 3: Przestrzeń Gry (Stół i Interfejs)
*Tworzymy "fizyczną" przestrzeń, w której karty będą funkcjonować.*
- [ ] **3.1**: Zaprojektowanie głównego ekranu gry z podziałem na strefy: Ręka, Talia, Odrzutowisko, Osada/Kraina.
- [ ] **3.2**: Zaprogramowanie logiki interakcji myszką: najechanie (powiększenie karty) oraz Drag & Drop (przeciągnij i upuść na stół).

### FAZA 4: Serce Gry (Maszyna Stanów i Zasady)
*Piszemy zasady Dark Eden, zmuszając grę do pilnowania instrukcji.*
- [ ] **4.1**: Wdrożenie `GameManager` – głównej maszyny stanów pilnującej 6 kroków tury (Dobieranie -> Akcje -> Bilansowanie -> Atak -> Najazd -> Odrzucanie).
- [ ] **4.2**: System Ekonomii: Walidacja kosztów zagrywania (Czy mam odpowiednią frakcję? Czy mam wymagane Miejsca/Zasoby?).
- [ ] **4.3**: Zautomatyzowanie Fazy Bilansowania (matematyczne podliczanie plusów i minusów ikon zasobów z kart w Osadzie).
- [ ] **4.4**: Moduł Walki: interfejs wyznaczania atakujących, obrońców i porównywania Wartości Bojowych (WB).

### FAZA 5: Umiejętności Specjalne i Szlify (Polish)
*Sprawiamy, że gra ożywa i obsługuje skomplikowane wyjątki.*
- [ ] **5.1**: Podpięcie sparametryzowanych zdolności kart z bazy JSON pod faktyczne wydarzenia w grze.
- [ ] **5.2**: Ręczne oskryptowanie unikalnych, "wyłamujących się" z zasad kart (Custom Scripts).
- [ ] **5.3**: "Sok" z gry (Game Juice): animacje tasowania, wstrząsy ekranu przy ataku, efekty dźwiękowe.
- [ ] **5.4**: Implementacja podstawowego trybu wieloosobowego (Hot-seat lub proste P2P).
