# Dark Eden Digital – Główny Plan (Roadmapa)

Witamy w repozytorium **Dark Eden Digital**!
Ten dokument to szczegółowa mapa drogowa rozwoju projektu. Będzie on aktualizowany o daty wykonania zadań oraz szacunki czasowe dla nadchodzących etapów, aby cały zespół miał jasny pogląd na postępy.

### FAZA 0: Przygotowanie środowiska pracy (Preludium techniczne)
*Zanim dotkniemy logiki gry, budujemy i konfigurujemy nasz "warsztat", abyśmy mogli płynnie współpracować.*
- [x] **0.1**: Pobranie i instalacja Godot Engine (wersja 4.x) oraz założenie projektu "Dark Eden Digital". *(Wykonano: 03.05.2026)*
- [x] **0.2**: Uruchomienie Google Antigravity na folderze projektu i instalacja wtyczki Godot Tools. *(Wykonano: 03.05.2026)*
- [x] **0.3**: Skonfigurowanie Godota, aby używał Antigravity jako domyślnego, zewnętrznego edytora skryptów. *(Wykonano: 03.05.2026)*
- [x] **0.4**: Zapisanie zasad projektu (`.cursorrules`), aby sztuczna inteligencja od początku znała strukturę (GDScript, typowanie, węzły Control). *(Wykonano: 03.05.2026)*

### FAZA 1: Fundamenty Danych (Baza i Zasoby)
*Przygotowujemy "paliwo" dla naszej gry – surowe statystyki i grafiki.*
- [x] **1.1**: Zautomatyzowana ekstrakcja bazy kart – wyciągnięcie danych z plików MSE i zapisanie ich w pliku `data/cards_db.json`. *(Wykonano: 03.05.2026)*
- [x] **1.2**: Zgromadzenie wyciętych grafik (artów) dla kart testowych, dopisanie rozszerzeń `.png` i powiązanie ich w parserze. *(Wykonano: 03.05.2026)*

### FAZA 2: Reprezentacja Wizualna (Karty w silniku)
*Uczymy silnik czytać nasze dane i nadajemy im fizyczny kształt na ekranie.*
- [x] **2.1**: Założenie przejrzystej struktury folderów w Godocie (osobne foldery na `Scenes`, `Scripts`, `Resources`, `Assets`). *(Wykonano: 03.05.2026)*
- [x] **2.2**: Zbudowanie UI (Interfejsu Użytkownika) pojedynczej Karty z klocków Godota (węzły `Control`). *(Wykonano: 03.05.2026)*
- [ ] **2.3**: Dokończenie importera – skrypt, który weźmie nasz `cards_db.json` i automatycznie utworzy gotowe zasoby (`Resources`) dla konkretnych kart w oparciu o szablon z kroku 2.2. *[Szacowany czas: ~2-4 godziny]*

### 👥 FAZA R: Współpraca i Zespół (Zadania dla Recenzenta / Game Designera)
*Prace projektowe, które mogą toczyć się równolegle, by gra była gotowa do testów na czas.*
- [ ] **R.1**: **Zbudowanie pierwszych testowych talii do gry.** Zadanie polega na wybraniu zestawu kart (na podstawie bazy JSON z Fazy 1.1), które stworzą zbalansowane talie początkowe. 
  > ⏳ **Oś czasu:** *[Szacowany czas na opracowanie: ~1-3 dni].* Talie te będą krytycznie potrzebne najpóźniej przed rozpoczęciem **Fazy 4** (Serce Gry i Maszyna Stanów).

### FAZA 3: Przestrzeń Gry (Stół i Interfejs)
*Tworzymy "fizyczną" przestrzeń, w której karty będą funkcjonować.*
- [ ] **3.1**: Zaprojektowanie głównego ekranu gry z podziałem na strefy: Ręka, Talia, Odrzutowisko, Osada/Kraina. *[Szacowany czas: ~1-2 dni]*
- [ ] **3.2**: Zaprogramowanie logiki interakcji myszką: najechanie (powiększenie karty) oraz Drag & Drop (przeciągnij i upuść na stół). *[Szacowany czas: ~1-2 dni]*

### FAZA 4: Serce Gry (Maszyna Stanów i Zasady)
*Piszemy zasady Dark Eden, zmuszając grę do pilnowania instrukcji.*
- [ ] **4.1**: Wdrożenie `GameManager` – głównej maszyny stanów pilnującej 6 kroków tury (Dobieranie -> Akcje -> Bilansowanie -> Atak -> Najazd -> Odrzucanie). *[Szacowany czas: ~2-3 dni]*
- [ ] **4.2**: System Ekonomii: Walidacja kosztów zagrywania. *[Szacowany czas: ~1 dzień]*
- [ ] **4.3**: Zautomatyzowanie Fazy Bilansowania (matematyczne podliczanie ikon zasobów). *[Szacowany czas: ~1 dzień]*
- [ ] **4.4**: Moduł Walki: interfejs wyznaczania atakujących, obrońców i porównywania Wartości Bojowych (WB). *[Szacowany czas: ~2 dni]*

### FAZA 5: Umiejętności Specjalne i Szlify (Polish)
*Sprawiamy, że gra ożywa i obsługuje skomplikowane wyjątki.*
- [ ] **5.1**: Podpięcie sparametryzowanych zdolności kart z bazy JSON pod wydarzenia w grze. *[Szacowany czas: ~3-5 dni]*
- [ ] **5.2**: Ręczne oskryptowanie unikalnych, "wyłamujących się" z zasad kart (Custom Scripts). *[Szacowany czas: praca ciągła]*
- [ ] **5.3**: "Sok" z gry (Game Juice): animacje, dźwięki, efekty cząsteczkowe. *[Szacowany czas: ~2-3 dni]*
- [ ] **5.4**: Implementacja podstawowego trybu wieloosobowego (Hot-seat lub proste P2P). *[Szacowany czas: do ustalenia w przyszłości]*
