# Setup de test local (mobile-mcp + émulateurs Firebase)

Comment rejouer la session de test de bout en bout.

## 1. mobile-mcp

```bash
claude mcp add mobile -- npx -y @mobilenext/mobile-mcp@latest
```

Installé dans la config projet (`~/.claude.json`). Les tools (`mobile_list_apps`,
`mobile_click_on_screen_at_coordinates`, `mobile_type_keys`, `mobile_list_elements_on_screen`,
`mobile_save_screenshot`, …) sont disponibles dans toute nouvelle session Claude Code.
Ils lisent l'arbre d'accessibilité du simulateur : les labels français des widgets Flutter remontent
avec leurs coordonnées logiques, ce qui permet de taper/saisir précisément.

## 2. Émulateurs Firebase

Prérequis : Java (installé via `brew install openjdk`) pour l'émulateur Firestore.

```bash
firebase emulators:start --only auth,firestore
```

Config dans `firebase.json` (ajoutée pendant la session) :

```json
"emulators": {
  "auth":      { "port": 9099 },
  "firestore": { "port": 8080 },
  "functions": { "port": 5001 },
  "ui":        { "enabled": false }
}
```

Points importants :
- L'émulateur Firestore **applique les `firestore.rules` du repo** → les rules sont testées en réel
  (création de tribu en batch, preuve `joinCode`, suppressions).
- Le port `functions` est déclaré mais il n'existe **pas encore de codebase functions** : il faudra
  `firebase init functions` (dossier `functions/` + entrée `"functions"` top-level dans `firebase.json`)
  avant de pouvoir émuler des Cloud Functions.
- Données volatiles : tout est perdu à l'arrêt (utiliser `--export-on-exit` pour persister au besoin).

## 3. Lancer l'app sur les émulateurs

Hook ajouté dans `lib/firebase/firebase_bootstrap.dart`, inactif par défaut :

```bash
flutter run --flavor dev -t lib/main_dev.dart --dart-define=USE_FIREBASE_EMULATORS=true
```

Ou depuis VS Code : configuration **« Our Tribe (dev · simulateur + émulateurs Firebase) »**
(`.vscode/launch.json`), qui cible le simulateur iPhone 16e.

## 4. Captures d'écran

`xcrun simctl io <device> screenshot fichier.png` (ou le tool `mobile_save_screenshot`).
Toutes les captures de la session sont dans [`screenshots/`](screenshots/), numérotées dans
l'ordre du parcours décrit dans [TEST_REPORT.md](TEST_REPORT.md).
