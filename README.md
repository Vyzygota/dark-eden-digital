# Dark Eden Digital 🃏

> Cyfrowa implementacja karcianki **Dark Eden** (Warzone 1996) w silniku Unity 6.4 (6000.4 LTS).

[![Unity](https://img.shields.io/badge/Unity-6000.4.x_LTS-black?logo=unity)](https://unity.com)
[![CardHouse](https://img.shields.io/badge/CardHouse-1.0.4-blue)]()
[![Status](https://img.shields.io/badge/Stan-W_budowie-yellow)]()

---

## Co to jest?

Wierna cyfrowa adaptacja klasycznej karcianki CCG **Dark Eden** wydanej przez Target Games w 1996 roku jako część uniwersum Warzone. Projekt odtwarza oryginalną mechanikę 6-fazowej tury, ekonomię zasobów i system walki.

Projekt przeszedł **migrację z Godot 4 → Unity 6000.4 LTS** (maj 2026). Obecna implementacja używa pakietu [CardHouse](https://assetstore.unity.com/packages/tools/card-game-framework-cardhouse-249311) jako frameworka zarządzania kartami.

---

## Stan prac — czerwiec 2026

### Gotowe
- Silnik renderowania kart (bake pipeline: off-screen camera → RenderTexture → Sprite)
- Prefab karty z dynamicznym dopasowaniem tła, ramki i grafiki per kategoria
- Baza **402 kart** w `data/cards_db.json` z pełnymi statystykami
- Ładowanie kart JSON → ręka gracza z animowanym wachlarzem (SplayLayout)
- GameManager z kompletną strukturą **6 faz tury**
- Model gracza: strefy (Ręka, Talia, Odrzucone, Anihilowane, Osada, Pogranicze, Oddział)
- Dobieranie kart do limitu z automatycznym przetasowaniem stosu odrzuconych
- System zasobów (szkielet) i system walki (szkielet)

### W budowie
- `ResourceSystem.ExecuteBalancing` — automatyczne podliczanie ikon zasobów w fazie 3
- Walidacja kosztu zagrywania kart (ekonomia złota)
- UI fazy walki — wskazywanie atakujących i obrońców
- Inicjalizacja talii gracza (łączenie CardGroup z konkretnymi kartami)

### Planowane
- Ekran zwycięstwa (warunek: 50 PZ)
- Tryb hot-seat (2 gracze)
- Animacje, dźwięki, efekty

---

## Baza kart

| Kategoria | Liczba | Opis |
|-----------|-------:|------|
| Intrygi (DE) | 166 | Karty akcji i zdarzeń |
| Wojownicy (DE) | 63 | Jednostki bojowe |
| Miejsca (DE) | 55 | Tereny i budynki (poziome) |
| Wojownicy (GE) | 38 | Jednostki bojowe |
| Intrygi (GE) | 37 | Karty akcji i zdarzeń |
| Przywódcy (DE) | 18 | Karty dowódców (poziome) |
| Udoskonalenia (GE) | 14 | Ulepszenia (poziome) |
| Przywódcy (GE) | 11 | Karty dowódców (poziome) |
| **Razem** | **402** | |

Pełna baza z atrybutami: [`data/cards_db.json`](data/cards_db.json)

---

## Mechanika tury (skrót)

```
Tura gracza (6 kroków):
  1. Dobieranie    — dobierz do 7 kart w ręce
  2. Akcje         — zagraj karty, aktywuj zdolności
  3. Bilansowanie  — automatyczne zliczanie ikon zasobów z Miejsc
  4. Atak          — wyznacz Oddział do ataku; porównaj WB z obrońcami
  5. Najazd        — atak na Osadę (warunek: brak obrońców)
  6. Odrzucanie    — odrzuć 1 kartę z ręki
```

**Warunek zwycięstwa:** 50 Punktów Zwycięstwa (PZ)  
**Limit ręki:** 7 kart | **Złoto na start:** 5 żetonów | **Karty odrzucone na start:** 3

---

## Zadania dla Twórcy Talii

Potrzebujemy testowych talii do weryfikacji mechaniki przed implementacją fazy walki.

### Kiedy talie są potrzebne
Przed ukończeniem `ResourceSystem.ExecuteBalancing` (Faza budowy: Q3 2026).  
Talie będą używane do testów manualnych i automatycznych.

### Format pliku

Utwórz plik `decks/<nazwa-talii>.json` wg szablonu [`decks/TEMPLATE.json`](decks/TEMPLATE.json):

```json
{
  "name": "Nazwa talii",
  "faction": "DE",
  "author": "Twoje imię lub nick",
  "notes": "Opcjonalny komentarz — styl gry, zamysł talii",
  "cards": [
    { "name": "Dokładna nazwa karty z cards_db.json", "count": 1 }
  ]
}
```

### Wymagania dla talii testowej

| Parametr | Wartość |
|----------|---------|
| Liczba kart | 40 |
| Przywódcy | dokładnie 1 |
| Wojownicy | 8–12 |
| Miejsca lub Udoskonalenia | 10–15 |
| Intrygi | pozostałe |

Karty muszą istnieć w `data/cards_db.json` — pole `name` jako klucz.

### Lista otwartych zadań

- [ ] **T.1** — Talia testowa frakcji DE (40 kart, zbalansowana)
- [ ] **T.2** — Talia testowa frakcji GE (40 kart, odpowiednik T.1)
- [ ] **T.3** — Talia agresywna DE — nacisk na Wojowników i Atak (test CombatSystem)
- [ ] **T.4** — Talia kontrolna DE — nacisk na Intrygi `AtAnyTime` (test PlayWindow)
- [ ] **T.5** — Talia ekonomiczna — maksymalna liczba Miejsc (test ResourceBalancing)

---

## Zadania dla Recenzentów

### Recenzja zasad (nie wymaga Unity)

Źródło prawdy: [`instrukcja-do-gry-dark-eden.pdf`](instrukcja-do-gry-dark-eden.pdf)

- [ ] **R.1** — Zweryfikuj 6 faz tury vs. instrukcja — czy kolejność i nazwy się zgadzają?
- [ ] **R.2** — Sprawdź taktyki walki `Land / Sea / Air` — czy wszystkie jednostki mają poprawnie przypisane flagi?
- [ ] **R.3** — Przejrzyj `PlayWindow` kart Intrygi w JSON:
  - `AtAnyTime` — „zagraj w dowolnym momencie"
  - `DuringCombat` — „zagraj podczas walki"
  - `DuringRaid` — „zagraj podczas najazdu"
  - `ActionPhase` — „zagraj podczas Akcji"
  - Wskaż karty z niejasnym lub brakującym `action` wymagające ręcznego oskryptowania
- [ ] **R.4** — Zweryfikuj `PostPlay` kart: `Discard / Attach / Annihilate` — czy wartości w JSON są poprawne?
- [ ] **R.5** — Lista kart DE/GE, których grafiki wymagają priorytetowego dodania

### Testy rozgrywki (po implementacji fazy walki)

- [ ] **Rv.1** — Testowa rozgrywka 5 tur — zaraportuj błędy w Issues
- [ ] **Rv.2** — Czy można zagrać jakąkolwiek kartę z talii T.1 w pierwszej turze przy 5 złota na start?
- [ ] **Rv.3** — Warunek zwycięstwa 50 PZ — czy jest osiągalny w rozsądnej liczbie tur (< 20)?
- [ ] **Rv.4** — Czy mechanika `Pogranicze` (obrona) vs. `Oddział` (atak) jest czytelna dla nowego gracza?

---

## Uruchomienie (deweloperzy)

**Wymagania:** Unity Hub + Unity 6000.4.x LTS

1. Otwórz projekt z folderu `DarkEdenDigital/` w Unity Hub
2. Aktywna scena: `Assets/DarkEden/Scenes/Board.unity`
3. Play Mode → ręka z 5 kartami pojawi się na dole ekranu

Projekt lokalny (nie publiczny) — dostęp przez zaproszenie.

---

## Zasoby

| Zasób | Link |
|-------|------|
| Instrukcja do gry (PDF) | [`instrukcja-do-gry-dark-eden.pdf`](instrukcja-do-gry-dark-eden.pdf) |
| Baza kart (JSON) | [`data/cards_db.json`](data/cards_db.json) |
| Szablon talii | [`decks/TEMPLATE.json`](decks/TEMPLATE.json) |
