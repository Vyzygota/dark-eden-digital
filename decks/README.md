# Talie testowe

Ten folder zawiera testowe talie do weryfikacji mechaniki Dark Eden Digital.

## Jak dodać talię

1. Skopiuj `TEMPLATE.json` → `<twoja-talia>.json`
2. Wypełnij pola — nazwy kart muszą dokładnie zgadzać się z polem `name` w [`../data/cards_db.json`](../data/cards_db.json)
3. Sprawdź wymagania w [README głównym](../README.md#zadania-dla-twórcy-talii)
4. Wyślij Pull Request

## Talie w tym folderze

| Plik | Frakcja | Autor | Status |
|------|---------|-------|--------|
| *(brak — czekamy na T.1)* | | | |

## Weryfikacja

Nazwa karty musi istnieć w `data/cards_db.json`. Przykład weryfikacji:

```bash
# Linux / macOS
node -e "
  const db = require('../data/cards_db.json');
  const deck = require('./moja-talia.json');
  const names = db.map(c => c.name);
  deck.cards.forEach(c => {
    if (!names.includes(c.name)) console.log('BRAK:', c.name);
  });
  console.log('Sprawdzono', deck.cards.length, 'kart');
"
```
