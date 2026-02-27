---
name: mochi-flashcard
description: >
  Creates language flashcards in Mochi Cards via API. Use this skill whenever
  the user wants to add, save, or create a flashcard for a Dutch or Spanish word,
  phrase, verb, noun, adjective, or adverb. Triggers on inputs like "add X to Mochi",
  "create a card for X", "save X as a flashcard", or any time the user provides a
  foreign word/phrase and wants it stored. Always use this skill — don't just explain
  what to do, actually call the API.
---

# Mochi Flashcard Skill

Creates a properly formatted flashcard in the correct Mochi deck by identifying
the language, part of speech, selecting the matching template, filling all fields,
and calling the Mochi API.

---

## Step-by-Step Workflow

1. **Identify the language** — Dutch or Spanish. Infer from the word itself unless the user specifies. If ambiguous, ask.
2. **Identify the part of speech** — noun, verb, adjective, adverb, or phrase. Multi-word expressions and idioms always use Phrase.
3. **Select deck + template** (see tables below)
4. **Fill all fields** using your language knowledge — generate example sentences, meanings, conjugations, etc.
5. **Call the API** — `POST https://app.mochi.cards/api/cards/`
6. **Confirm** — tell the user the term, language, POS, and template used

---

## Decks

| Language | Deck ID     |
|----------|-------------|
| Dutch    | `MaeuxpaI`  |
| Spanish  | `owBjlj85`  |

---

## Templates

### Noun — `uh7fGAtd`

| Field ID    | Name               | Notes                                              |
|-------------|--------------------|----------------------------------------------------|
| `name`      | term               | Bare noun, no article                              |
| `rA0wy2RL`  | article            | Dutch: `de` or `het`; Spanish: `el/la/los/las`    |
| `TSHL8aOb`  | plural             | Plural form                                        |
| `1iHjVUoo`  | meaning            | English meaning                                    |
| `0yO6Y7QH`  | example            | Example sentence in target language                |
| `pkaTR5m8`  | example_translation| English translation of example                    |
| `aWoCM4WS`  | sound              | **Omit** — auto-generated                         |

### Verb — `qxBa2NFW`

| Field ID    | Name               | Notes                                                                              |
|-------------|--------------------|------------------------------------------------------------------------------------|
| `name`      | term               | Infinitive form                                                                    |
| `bDevs3Y7`  | verb_property      | Dutch: `transitive`, `separable`, `reflexive`; Spanish: `irregular`, `stem-changing e→ie`, `reflexive` |
| `MjwjyOCM`  | past               | Dutch: imperfectum; Spanish: preterite 1st person singular                        |
| `3TDAQZqa`  | pp                 | Past participle                                                                    |
| `K1PS5Xdk`  | example            | Example sentence in target language                                                |
| `i0XPY85v`  | example_translation| English translation of example                                                    |

### Adjective — `7hgcdBHk`

| Field ID    | Name               | Notes                                      |
|-------------|--------------------|--------------------------------------------|
| `name`      | term               | Base form                                  |
| `BL4ubtt4`  | comparative        | Omit if no comparative form exists         |
| `HBozSMzW`  | superlative        | Omit if no superlative form exists         |
| `eZUFCOjv`  | example            | Example sentence in target language        |
| `oAFAB6oN`  | meaning            | English meaning                            |
| `6qB6N45g`  | example_translation| English translation of example            |

### Adverb — `I7PrBcFB`

| Field ID    | Name               | Notes                                      |
|-------------|--------------------|--------------------------------------------|
| `name`      | term               | The adverb                                 |
| `CBvhyf08`  | example            | Example sentence in target language        |
| `F5kLaSV0`  | meaning            | English meaning                            |
| `ypwmtpFG`  | example_translation| English translation of example            |

### Phrase — `9eGY8JoA`

| Field ID    | Name        | Notes                          |
|-------------|-------------|--------------------------------|
| `name`      | phrase      | The full phrase as-is          |
| `WbF4DbMJ`  | translation | English translation            |

---

## API Call

```text
POST https://app.mochi.cards/api/cards/
Authorization: Basic <base64(:<api-key>)>
Content-Type: application/json
```

**Payload shape:**

```json
{
  "deck-id": "<deck-id>",
  "content": "",
  "template-id": "<template-id>",
  "fields": {
    "name": { "id": "name", "value": "..." },
    "<field-id>": { "id": "<field-id>", "value": "..." }
  }
}
```

- Always include `"content": ""` at the top level
- All values are plain strings
- Omit fields that don't apply (e.g. `aWoCM4WS`, or comparative when none exists)
- `name` must never be empty

---

## Rules

- Meanings and translations are always in **English**
- Generate natural, learner-appropriate example sentences
- For Dutch nouns: always determine `de` or `het` — if genuinely uncertain, use best judgment and append `(uncertain)` to the article value
- For multi-word expressions and idioms: always use **Phrase** template regardless of internal POS
- After API call: confirm with term, language, part of speech, and template name

---

## Examples

### Example 1 — Dutch Noun

**Input:** `hond`

**Reasoning:** Dutch (recognizable Dutch word), noun → template `uh7fGAtd`, deck `MaeuxpaI`

**API call:**

```json
POST https://app.mochi.cards/api/cards/
{
  "deck-id": "MaeuxpaI",
  "content": "",
  "template-id": "uh7fGAtd",
  "fields": {
    "name":       { "id": "name",      "value": "hond" },
    "rA0wy2RL":   { "id": "rA0wy2RL",  "value": "de" },
    "TSHL8aOb":   { "id": "TSHL8aOb",  "value": "honden" },
    "1iHjVUoo":   { "id": "1iHjVUoo",  "value": "dog" },
    "0yO6Y7QH":   { "id": "0yO6Y7QH",  "value": "De hond loopt in het park." },
    "pkaTR5m8":   { "id": "pkaTR5m8",  "value": "The dog is walking in the park." }
  }
}
```

**Confirmation:** ✅ Card created — *hond* (Dutch, Noun, Noun template)

---

### Example 2 — Spanish Verb

**Input:** `hablar`

**Reasoning:** Spanish, verb → template `qxBa2NFW`, deck `owBjlj85`

**API call:**

```json
POST https://app.mochi.cards/api/cards/
{
  "deck-id": "owBjlj85",
  "content": "",
  "template-id": "qxBa2NFW",
  "fields": {
    "name":      { "id": "name",      "value": "hablar" },
    "bDevs3Y7":  { "id": "bDevs3Y7", "value": "regular, transitive" },
    "MjwjyOCM":  { "id": "MjwjyOCM", "value": "hablé" },
    "3TDAQZqa":  { "id": "3TDAQZqa", "value": "hablado" },
    "K1PS5Xdk":  { "id": "K1PS5Xdk", "value": "Ella habla español muy bien." },
    "i0XPY85v":  { "id": "i0XPY85v", "value": "She speaks Spanish very well." }
  }
}
```

**Confirmation:** ✅ Card created — *hablar* (Spanish, Verb, Verb template)

---

### Example 3 — Dutch Phrase

**Input:** `het maakt niet uit`

**Reasoning:** Dutch, multi-word idiomatic expression → template `9eGY8JoA`, deck `MaeuxpaI`

**API call:**

```json
POST https://app.mochi.cards/api/cards/
{
  "deck-id": "MaeuxpaI",
  "content": "",
  "template-id": "9eGY8JoA",
  "fields": {
    "name":     { "id": "name",     "value": "het maakt niet uit" },
    "WbF4DbMJ": { "id": "WbF4DbMJ","value": "it doesn't matter" }
  }
}
```

**Confirmation:** ✅ Card created — *het maakt niet uit* (Dutch, Phrase, Phrase template)
