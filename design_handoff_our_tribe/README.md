# Handoff : Our Tribe

## Overview
**Our Tribe** est une app mobile (iOS-first) de gestion des tâches domestiques pour toute une famille/tribu, avec une couche de gamification légère (points, classement, récompenses). Ce bundle documente la refonte visuelle « Calme + esprit tribu » : une direction sobre et adulte (typo Figtree, filets 1px, un seul accent vert, motif de fond discret « liens »), volontairement éloignée des tropes d'UI génératives (pas de Fredoka, pas de dégradés pastel, pas de glassmorphism, pas d'emoji — remplacés par des pictos SVG maison).

Le parcours couvert : onboarding pré-connexion complet, puis l'app connectée (Accueil, Semaine, Récap/Classement, Détail d'une tâche, Création de tâche, Profil, sous-écrans Réglages).

## About the Design Files
Les fichiers de ce bundle sont des **références de design réalisées en HTML/React (via Babel in-browser)** — des prototypes qui montrent l'apparence et le comportement voulus, **pas du code de production à copier tel quel**. La tâche est de **recréer ces designs dans l'environnement du codebase cible** (React Native, SwiftUI, Flutter, React web, etc.) en suivant ses patterns et sa librairie de composants établis. Si aucun environnement n'existe encore, choisir le framework le plus adapté (app mobile → React Native ou SwiftUI recommandés) et y implémenter les designs.

Le rendu « téléphone » (bezel, encoche, barre d'état 9:41) vient d'un composant de maquette `ios-frame.jsx` : c'est de l'échafaudage de présentation, **à ignorer** — sur device réel, ces éléments sont fournis par l'OS.

## Fidelity
**High-fidelity (hifi).** Couleurs, typographie, espacements, rayons et interactions sont définitifs. À recréer au pixel près avec les composants du codebase. Les valeurs exactes sont listées dans « Design Tokens ».

## Design Tokens

### Couleurs — neutres & surfaces
- Fond app : `#FBFAF6`
- Fond « bureau » (hors device) : `#EDEAE3`
- Surface (cartes) : `#FFFFFF`
- Surface secondaire (état « fait ») : `#FAF8F3`
- Encre principale : `#22201C`
- Encre secondaire : `#7A7468`
- Encre tertiaire / légendes : `#A9A395`
- Filet / bordure : `#ECE7DC`
- Filet clair (séparateurs internes) : `#F3EFE8`

### Couleur d'accent (thémable via Tweaks)
- Accent par défaut (vert profond) : `#2F6D4E`
- Accent doux (dérivé) : `color-mix(in oklab, var(--accent) 12%, #fff)`
- Alternatives proposées dans le panneau Tweaks : `#B4654A`, `#4F6D97`, `#9C7C43`

### Points / gamification (ocre chaud)
- Ocre : `#9C7C43`
- Ocre doux (fond des pastilles de points) : `#F5F0E6`
- Glyphe de points : **jeton hexagonal** rempli (voir Assets), jamais une étoile.

### Moments de la journée (teintes douces des pastilles de section)
- Matin — `--sun` `#B5843A` / `--sun-soft` `#F6E7C9`
- Après-midi — `--sky` `#5B80A0` / `--sky-soft` `#DDE9F1`
- Soir — `--dusk` `#8270A8` / `--dusk-soft` `#E9E1F2`

### Couleurs des membres (signature de la tribu — chaque personne = une couleur)
- Léa — `#C25A38` / soft `#F7E3DA`
- Papa — `#3E6AA6` / soft `#E0E9F4`
- Maman — `#2E8461` / soft `#DCEDE4`
- Tom — `#6C57A6` / soft `#E8E2F3`
Ces couleurs sont posées en variables CSS `--m-<id>` / `--m-<id>-soft` sur le conteneur racine et pilotées par l'état applicatif (le « chef » peut les changer dans le Profil).

### Typographie
- Famille unique : **Figtree** (Google Fonts), poids 400/500/600/700/800.
- Titres d'écran : 24–26px / 700 / letter-spacing -0.02em / line-height ~1.1
- Wordmark « Our Tribe » (accueil onboarding) : 30px / 800 / -0.02em
- Salutation accueil : 26px / 700 / -0.02em
- Titre de section : 15px / 700 / -0.01em
- Nom de tâche : 15px / 600 / -0.01em
- Méta (heure, récurrence) : 12px / 600 / couleur encre tertiaire
- Kicker / label majuscule : 11–12px / 700–800 / uppercase / letter-spacing .5–.6px
- Chiffres de points : 14–15px / 700

### Rayons
- Cartes de tâche / listes : 15px (thémable 8–20 via Tweak « Arrondi des cartes »)
- Cartes de progression / panels : 18px
- Pastilles d'icône / boutons ronds carrés : 8–14px
- Boutons pleine largeur : 14px
- Onboarding (logo hexagonal) : clip-path polygone, pas de border-radius

### Ombres
Quasi nulles — la direction repose sur des **filets 1px** (`1px solid var(--line)`), pas des ombres portées. Ombre résiduelle très légère seulement sur le pouce du segmented control : `0 1px 2px rgba(35,28,18,.05)`.

### Motif de fond signature
Tuile SVG 48×48 répétée sur le fond de l'app : deux chevrons (haut + bas) reliant 5 petits nœuds — évoque des « liens » entre personnes. Tracé `stroke #7a6a4d` à `stroke-opacity .06`, nœuds `fill #7a6a4d` à `fill-opacity .07`. Désactivable (classe `no-motif` sur `<html>`, pilotée par le Tweak « Motif de fond »).

## Screens / Views

### 1. Onboarding (pré-connexion) — `Our Tribe - Onboarding.html`
Machine à états simple : pile d'écrans (`stack`) avec `go(step)` / `back()`. Étapes : `welcome → signup → choose → (create → invite) | (join) → done`, plus `signin` depuis welcome.

- **welcome** : logo hexagonal monogramme « OT » (78×78, fond accent, clip-path hexagone), wordmark « Our Tribe », tagline « Les tâches de la maison, toute la tribu au même endroit. », cluster de 4 avatars superposés (marge négative -14px, bordure 3px couleur fond). Boutons : « Créer mon compte » (primaire) + lien « J'ai déjà un compte ».
- **signup** : champs Prénom / E-mail / Mot de passe (`.cf-input`), note en bas avec picto cœur. Bouton « Continuer » désactivé tant que prénom+email vides.
- **signin** : E-mail + Mot de passe, lien « Mot de passe oublié ? ». Bouton « Se connecter ».
- **choose** : deux grandes cartes de choix (`.ob-choice`) — « Créer une tribu » (accentuée, picto users) / « Rejoindre avec un code » (picto clé, pastille bleu-ciel).
- **create** : nom de la tribu + 6 pastilles de couleur (`.pf-swatch`, palette membre). Bouton « Créer la tribu ».
- **invite** : badge « Tribu créée », carte code d'invitation `4KP-92Q` (fond accent-doux, 38px/800/letter-spacing 5px), boutons Copier / Partager, note.
- **join** : 6 cases de code (`.ob-cbox` 46×56), lien « Coller », et quand les 6 sont remplies, carte « La tribu Dubois · 4 membres » avec check. Bouton « Rejoindre la tribu ».
- **done** : logo hexagonal avec check, « C'est parti, {prénom} », tagline. Bouton « Entrer dans Our Tribe » → navigue vers `Our Tribe.html`.

Boutons primaires (`.dt-btn`) : pleine largeur, 52px, fond accent, texte blanc 16px/700, picto flèche à droite ; état désactivé = fond `--line`, texte `--ink-3`.

### 2. Accueil — `tribe/hifi-home.jsx`
- **En-tête** : à gauche, rangée wordmark (`.brand` : monogramme hexagonal « OT » 22px accent + « OUR TRIBE » 12px/800/uppercase/letter-spacing .14em/encre tertiaire) au-dessus de la salutation « Salut la tribu » (26px/700). À droite : avatar membre (carré 40px, couleur membre), bouton cloche (avec pastille de notif accent), pastille de points (fond ocre-doux, jeton hexagonal + total animé).
- **Carte progression** (masquable via Tweak) : « X sur N tâches faites » + message d'encouragement (couleur accent) ; encart « +points » (fond accent-doux) ; barre plate 6px (piste `--line-2`, remplissage accent, transition width .5s).
- **Sections par moment** (`Ce matin`, `Cet après-midi`, `Ce soir`) : en-tête = pastille d'icône teintée (26px, fond `--line-2`, icône couleur du moment) + titre + compteur `n/total` à droite.
- **Cartes de tâche** (`.tcard`) : case à cocher carrée 24px (bordure 1.5px `#DAD3C4` ; cochée = fond accent + check blanc, animation « pop » .32s cubic-bezier(.34,1.5,.5,1)) ; nom + méta (heure via picto horloge, récurrence via picto répétition) ; à droite, éventuelle vignette photo 40px (placeholder rayé) et pastille de points (jeton hexagonal + chiffre). État « fait » : fond `--surface-2`, nom barré (couleur tertiaire), pastille de points grisée.
- **Barre d'onglets** (`.tabs`) : plate, filet supérieur 1px, 5 items — Accueil / Semaine / bouton central « + » (FAB carré 46px accent) / Famille / Profil. Item actif = couleur accent.
- **Confetti** : à la complétion de toutes les tâches, burst 1.1s (tons neutralisés).

### 3. Semaine — `hifi-week.jsx` (partagé, stylé par le CSS tribe)
- Sélecteur de semaine, bande de 7 jours (`.daystrip`) avec jour actif surligné (accent), résumé du jour, et **timeline** verticale (`.tl`) : rail 1.5px, points d'étape, ligne « maintenant » en accent avec halo. Tâches affichées le long de la timeline avec les mêmes `.tcard`.

### 4. Récap / Classement — `tribe/hifi-recap.jsx`
- En-tête « La tribu Dubois » + switcher de semaine (`.wk`).
- Segmented control Résumé / Tâches (`.seg`, pouce coulissant .24s).
- **Résumé** : carte « Total de la tribu » (grand nombre animé + delta « vs sem. passée » en vert) ; panel « Cette semaine, par personne » = barres verticales pleines aux **couleurs membres** (hauteur animée .6s) surmontées du score et d'un avatar rond ; **« Le clan cette semaine »** = classement (`.lead-row`), le membre courant surligné dans sa couleur, avatar rond plein couleur membre + initiale blanche, pastille de points (jeton hexagonal) teintée ; carte **récompense** « Objectif tribu · sortie ciné » (fond accent-doux, barre de progression accent, sous-texte « X / 100 pts »).

### 5. Détail d'une tâche — `hifi-detail.jsx` (partagé)
- Barre d'actions (Retour / Modifier), bandeau photo (ou bannière teintée couleur membre avec picto), titre 24px + pastille de points, chips (heure, récurrence), description, carte assigné (avatar rond couleur membre), activité, et **bouton d'action collant** en bas (« Marquer comme fait » accent / « Fait ! Annuler » en état terminé, fond surface + filet).

### 6. Créer une tâche — `tribe/hifi-create.jsx`
- En-tête (Annuler / titre), champs : nom (`.cf-input`), description (textarea), **sélecteur de personne** (rangée de cartes avatar `.cf-person`), **stepper de points** (− / pastille ocre avec jeton hexagonal / +, 1→9), **chips de récurrence** (`.cf-chip` : une fois / tous les jours / …), ajout de **photos** (bouton pointillé accent + placeholders rayés). Bouton « Créer la tâche » (désactivé si nom vide).

### 7. Profil — `tribe/hifi-profile.jsx`
- Carte utilisateur (avatar rond couleur, nom, mail, bouton Éditer). Section **« La tribu Dubois »** : liste des membres (avatar + nom, « · chef » pour Léa), chaque membre ouvre une palette de pastilles pour changer sa couleur (le chef seulement) ; hint « En tant que chef de tribu, touche une pastille… ». Carte **code d'invitation** (fond accent-doux, code `4KP-92Q`, bouton Partager). Liste de réglages (`.pf-list` : Récompenses, Récurrences & rappels…). Bouton Déconnexion, numéro de version.

### 8. Sous-écrans Réglages — `tribe/hifi-settings.jsx`
- **Récompenses** : solde de points tribu + liste de récompenses (`.rw-card` : picto cadeau dans pastille accent-doux, nom, tag « Tribu/Léa/… », barre de progression couleur membre, sous-texte). Récompenses : « Sortie ciné en tribu » (100), « Léa choisit le repas » (40), « Soirée jeux » (70), « 1h de jeu bonus » (30).
- **Récurrences & rappels** : interrupteurs (`.sw`, 46×27, pouce coulissant), lignes de réglage avec pastille d'icône, séparateurs, note.

## Interactions & Behavior
- **Navigation app** : état `tab` (`home | week | pts | profile`) + overlays `creating`, `setting` (`rewards|reminders`), `detail` ({source, id}). Le « + » central ouvre la création ; taper une tâche ouvre son détail (en gardant la source pour le retour et le bon toggle).
- **Onboarding** : pile `stack`, `go`/`back`, validations de formulaire (boutons désactivés tant que champs requis vides ; code = 6 caractères). Le bouton final et la connexion appellent `enterApp()` → `window.location.href = 'Our Tribe.html'`.
- **Cocher une tâche** : toggle `done`, animation « pop » sur la case, mise à jour des compteurs et du total de points (compteur animé `useCountUp`), confetti si tout est fait.
- **Changer la couleur d'un membre** (profil) : met à jour l'état `memberColors`, re-pose les variables CSS `--m-*` sur la racine (`buildColorVars`), propagé partout instantanément.
- **Tweaks** (panneau optionnel, `tweaks-panel.jsx`) : accent (4 choix), arrondi des cartes (8–20px), motif de fond (on/off → classe `no-motif`), carte de progression (on/off).
- **Transitions** : barres/anneaux en `.5–.6s cubic-bezier(.4,0,.2,1)` ; case « pop » `.32s cubic-bezier(.34,1.5,.5,1)` ; pouce du segmented `.24s`. Respecter `prefers-reduced-motion` côté prod.

## State Management
- `tab`, `creating`, `setting`, `detail` — navigation.
- `homeTasks`, `weekTasks` — listes de tâches (id, name, pts, time, rep, done, assignee, photo…). Fournies par `window.TASKS0` / `window.WK_TASKS` dans les prototypes → à remplacer par la vraie source de données.
- `memberColors` — map id→hex, pilote les variables CSS de couleur membre.
- Onboarding : `stack`, `firstName`, `email`, `pwd`, `famName`, `famColor`, `code[6]`.
- Données à brancher en prod : auth (signup/signin), création/adhésion de tribu (code d'invitation), CRUD tâches, récurrences & rappels (notifications), récompenses.

## Assets
- **Police** : Figtree via Google Fonts (`https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800`).
- **Icônes** : toutes en SVG inline maison (stroke, 1.7–2.1px), définies dans les objets `HIcon` (app) et `OB` (onboarding) en tête des fichiers JSX — cloche, check, horloge, répétition, soleil, nuage, maison, calendrier, users, user, plus, cadeau, chevrons, flèche, clé, cœur, copier, partager. À porter vers la librairie d'icônes du codebase (ou exporter en SVG).
- **Glyphe de points** : jeton hexagonal rempli — `HIcon.star` = `<path d="M12 2.4 20 7v10l-8 4.6L4 17V7Z"/>` (fill currentColor).
- **Monogramme « OT »** : hexagone en `clip-path:polygon(25% 3%,75% 3%,100% 50%,75% 97%,25% 97%,0 50%)` + texte « OT ».
- **Motif de fond** : SVG data-URI inline dans `.app` (voir `tribe/hi-fi-t.css`).
- **Photos de tâche** : placeholders rayés (`repeating-linear-gradient`) — à remplacer par de vraies images uploadées.
- Aucune image bitmap externe ; aucun asset de marque tiers.

## Files
Structure du bundle (exécutable tel quel en ouvrant les `.html`) :
- `Our Tribe.html` — app connectée (point d'entrée principal).
- `Our Tribe - Onboarding.html` — parcours d'onboarding.
- `tribe/hi-fi-t.css` — **feuille de style de la direction** (tous les tokens et composants).
- `tribe/hifi-home.jsx` — Accueil (+ définit l'objet global `HIcon`, réutilisé par les autres écrans).
- `tribe/hifi-recap.jsx` — Récap / Classement.
- `tribe/hifi-create.jsx` — Création de tâche.
- `tribe/hifi-profile.jsx` — Profil.
- `tribe/hifi-settings.jsx` — Sous-écrans Réglages.
- `tribe/hifi-onboarding.jsx` — Onboarding.
- `hifi-week.jsx`, `hifi-detail.jsx`, `hifi-tasks.jsx` — écrans partagés (style-agnostiques, rendus par le CSS tribe).
- `ios-frame.jsx` — bezel de maquette **(présentation uniquement — à ignorer en prod)**.
- `tweaks-panel.jsx` — panneau de réglages de démo **(outil de prototype — pas une fonctionnalité produit)**.

### Notes d'implémentation
- Les composants React partagent un scope global (chaque `<script type="text/babel">` s'exécute en portée globale). En particulier `HIcon` est défini dans `hifi-home.jsx` et utilisé partout. Dans un vrai codebase, en faire un module d'icônes importable.
- `buildColorVars`, `useCountUp`, `TabBar`, `IOSDevice`, `useTweaks` et les composants `Tweak*` sont des helpers de prototype — remplacer par les équivalents du codebase (thème, hooks d'animation, navigation, composant d'icônes).
- La direction est pensée **mobile-first, portrait**. Cibles tactiles ≥ 44px respectées.
