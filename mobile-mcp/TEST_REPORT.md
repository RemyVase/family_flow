# Rapport de test E2E — Our Tribe (mobile-mcp)

**Date** : 6 juillet 2026 · **Device** : simulateur iPhone 16e (iOS 26.2) · **Build** : flavor `dev`, debug
**Backend** : émulateurs Firebase locaux (Auth :9099, Firestore :8080) avec les `firestore.rules` du repo **actives**
**Outillage** : serveur MCP [mobile-next/mobile-mcp](https://github.com/mobile-next/mobile-mcp) piloté en JSON-RPC (stdio)

> Résultat global : **le parcours complet fonctionne de bout en bout** (inscription → création de tribu →
> tâches → points → 2ᵉ compte → jonction par code → départ → reconnexion), avec **2 crashs** et une
> **sortie de tribu qui échoue à mi-chemin** — détail dans [BUGS.md](BUGS.md).

---

## Mise en place

| # | Action | Résultat |
|---|--------|----------|
| 1 | `claude mcp add mobile -- npx -y @mobilenext/mobile-mcp@latest` | Serveur installé et connecté (`claude mcp list` ✔). Les tools n'étant pas chargeables à chaud dans la session en cours, le serveur a été piloté directement en JSON-RPC stdio (même serveur, mêmes tools : `mobile_list_apps`, `mobile_click_on_screen_at_coordinates`, `mobile_type_keys`, `mobile_list_elements_on_screen`, …). |
| 2 | Lancement de l'app sur le backend dev réel | ❌ Signup impossible : `CONFIGURATION_NOT_FOUND` — **Firebase Authentication n'est pas activé sur `our-tribe-dev`** (voir BUGS.md · BLOCKER-1). Vérifié via l'API REST identitytoolkit. |
| 3 | Bascule sur les émulateurs Firebase locaux | Installation d'OpenJDK (requis par l'émulateur Firestore), ajout de la section `emulators` dans `firebase.json`, hook `--dart-define=USE_FIREBASE_EMULATORS=true` dans `lib/firebase/firebase_bootstrap.dart` (inactif hors test). Les **rules du repo sont appliquées par l'émulateur** → elles sont donc testées en réel. |
| 4 | Relance : `flutter run --flavor dev -t lib/main_dev.dart --dart-define=USE_FIREBASE_EMULATORS=true` | App opérationnelle sur les émulateurs. |

## Parcours testé, point par point

### Onboarding — compte 1 (Fable)
| # | Action (via mobile-mcp) | Constat | Screenshot |
|---|---|---|---|
| 1 | Lancement app | Écran Welcome conforme | `01_welcome.png` |
| 2 | Tap « Créer mon compte » | Formulaire signup (prénom / e-mail / mot de passe), bouton désactivé tant que le formulaire est incomplet | `02_signup_empty.png` |
| 3 | Saisie `Fable` / `fable.test@ourtribe.be` / `fable123` | Champs remplis, mot de passe masqué | `03_signup_filled.png` |
| 4 | (Backend réel) Continuer | ❌ « Une erreur est survenue » — cause : Auth non activé sur le projet dev | `04_after_signup.png` |
| 5 | (Émulateurs) Continuer | ✅ Compte créé, **redirection automatique par le guard** vers « Ta tribu » | `05_choose_tribe.png` |
| 6 | Tap « Créer une tribu », saisie « La tribu Fable », choix couleur bleue | Sélection visuelle de la pastille OK | `06_create_tribe_filled.png` |
| 7 | Tap « Créer la tribu » | ✅ Batch Firestore (tribu + invite + membre fondateur) **accepté par les security rules**. Code d'invitation réel généré : `3PP-DCU` | `07_invite_code.png` |
| 8 | Tap « Copier » | Feedback « Copié ! », code dans le presse-papiers | `08_invite_copied.png` |
| 9 | Continuer → écran final | « C'est parti, Fable » (prénom réel depuis Firestore) | `09_done.png` |
| 10 | « Entrer dans Our Tribe » | Home vide : « 0 sur 0 tâches faites », 0 point | `10_home_empty.png` |

### Tâches
| # | Action | Constat | Screenshot |
|---|---|---|---|
| 11 | FAB « + » → saisie « Sortir les poubelles » | Formulaire complet ; « Pour qui » présélectionné sur **Moi** | `11_task_create.png` |
| 12 | Points 2→3, récurrence « Tous les jours » | ✅ Le chip « À tour de rôle » apparaît uniquement quand la tâche devient récurrente | `12_task_create_daily.png` |
| 13 | « Créer la tâche » | ✅ Tâche persistée et streamée sur le Home (« Ce soir 0/1 », 19:00, Tous les jours, · Fable, 3 pts) | `13_home_one_task.png` |
| 14 | Nouvelle tâche « Nourrir le chat » en « À répartir » | Hint contextuel affiché, section « Pour qui » masquée, section « Quand » OK | `14_task_unassigned_form.png` |
| 15 | Création | ✅ Bannière ocre « 1 tâche à répartir » sur le Home ; la tâche n'apparaît pas dans « Ce soir » | `15_home_banner.png` |
| 16 | Tap bannière → écran « À répartir » | Carte avec avatars des membres | `16_unassigned_screen.png` |
| 17 | Tap avatar F | ✅ Attribution instantanée → état vide « Tout est réparti » | `17_unassigned_empty.png` |
| 18 | Retour Home | Les 2 tâches dans « Ce soir » (0/2), bannière disparue | `18_home_two_tasks.png` |
| 19 | Coche « Sortir les poubelles » | ✅ « 1 sur 2 », **+3 POINTS**, pill header → 3 (compteur hebdo membre crédité côté Firestore) | `19_task_done_points.png` |
| 20 | Tap carte → détail « Nourrir le chat » | Détail réel (heure, points, « Attribuée à Fable · toi », couleur du membre) | `20_task_detail.png` |
| 21 | « Marquer comme fait » depuis le détail | ✅ Bouton passe à « Fait ! Annuler », état propagé | `21_task_detail_done.png` |
| 22 | Retour Home | « 2 sur 2 — Tout est fait », +5 points, pill 5 | `22_home_all_done.png` |

### Onglets Semaine / Famille
| # | Action | Constat | Screenshot |
|---|---|---|---|
| 23 | Onglet Semaine | ✅ « Semaine 28 · juillet », « Lundi 6 » (vraie date), timeline triée par heure, **marqueur MAINTENANT 23:19 correctement placé** après la dernière tâche passée | `23_week.png` |
| 24 | Sélection « Jeudi 9 » | Jour sélectionné, marqueur MAINTENANT masqué hors aujourd'hui ✅ (même liste de tâches chaque jour : limitation connue, pas de modèle de date) | `24_week_other_day.png` |
| 25 | Onglet Famille · Résumé | ✅ « La tribu Fable », total 5 points réels, barres par personne, classement « 1 · Fable · toi · 5 » | `25_family_recap.png` |
| 26 | Segment Tâches + filtres | ✅ Compteurs corrects (Toutes 2 / À faire 0 / Faites 2), groupement « Faites » | `26_family_tasks.png` |

### Profil & réglages
| # | Action | Constat | Screenshot |
|---|---|---|---|
| 27 | Onglet Profil | ✅ Tout réel : nom, e-mail, « LA TRIBU FABLE », Membres · 1, rôle « chef », code `3PP-DCU` | `27_profile.png` |
| 28 | Tap pastille couleur | Palette 8 couleurs, couleur courante cochée | `28_profile_palette.png` |
| 29 | Choix bleu | ✅ Couleur appliquée **instantanément partout** (avatar, pastille) et persistée | `29_profile_color_changed.png` |
| 30 | « Éditer » → Modifier le profil | ⚠️ Aucune pastille « Ma couleur » sélectionnée (bug palette, voir BUGS.md) | `30_profile_edit.png`, `31_edit_color_state.png` |
| 31 | Renommage « Fable 5 » + Enregistrer | ✅ Nom mis à jour partout (carte user, liste membres) | `32_profile_renamed.png` |
| 32 | Écran Notifications | UI complète (interrupteur maître, rappels, récapitulatifs) — préférences **locales uniquement, non persistées** | `33_notifications.png` |
| 33 | Écran Récurrences | Début de semaine + report automatique — local uniquement | `34_recurrences.png` |
| 34 | Écran Récompenses | 💥 **CRASH « Bad state: No element »** sous la 1ʳᵉ carte (données mock qui référencent des membres inexistants) — BUG-1 | `35_rewards.png` |
| 35 | « Quitter la tribu » (chef seul) | ✅ Wording correct « Supprimer la tribu ? Tu es le dernier membre… » → Annulé | `36_profile_bottom.png`, `37_leave_sheet_solo.png` |
| 36 | « Se déconnecter » | ✅ Retour Welcome via le guard | `38_after_logout.png` |

### Multi-comptes — compte 2 (Remy) & jonction par code
| # | Action | Constat | Screenshot |
|---|---|---|---|
| 37 | Signup `Remy` / `remy.test@ourtribe.be` | ✅ → « Ta tribu » | `39_choose_second.png` |
| 38 | « Rejoindre avec un code », frappe `3PPDCU` au clavier | 💥 **BUG saisie** : les caractères se répartissent mal dans les cases (« 3 / PP / _ / DC / _ / _ ») — BUG-2 | `40_join_code_entered.png` |
| 39 | « Coller depuis le presse-papiers » | ✅ Lookup Firestore réel → carte « La tribu Fable · 1 membres » + bouton activé. ⚠️ Mais les cases n'affichent toujours pas le code (état visuel ≠ état contrôleur) + « 1 membre**s** » (accord) | `41_join_pasted.png` |
| 40 | « Rejoindre la tribu » | ✅ **Jonction acceptée par les security rules** (preuve `joinCode`) → « C'est parti, Remy » | `42_joined_done.png` |
| 41 | Home Remy | ✅ Voit les 2 tâches de la tribu avec leurs états ; couleur membre auto-attribuée (bleu clair) | `43_home_remy.png` |
| 42 | Profil Remy | ✅ Membres · 2 (« Fable 5 · chef », « Remy · moi »), copie « simple membre », pastille éditable seulement sur sa propre ligne | `44_profile_remy.png` |
| 43 | « Quitter la tribu » (membre simple) | Wording membre correct « Quitter La tribu Fable ? » | `45_leave_sheet_member.png` |
| 44 | Confirmer « Quitter » | 💥 **CRASH « Bad state: No element »** + **sortie incomplète** : le member doc est supprimé mais la mise à jour du compteur d'invitation est refusée par les rules (Remy n'est plus membre) → `tribeId` jamais nettoyé → **état zombie** — BUG-3 (le plus sérieux) | `46_after_leave.png`, `47_relaunch_after_leave.png`, `48_zombie_profile_crash.png` |
| 45 | Réparation manuelle du doc `users/{remy}` via l'API de l'émulateur | ✅ L'app **réagit en live** : redirection immédiate vers « Ta tribu » (streams + guard réactifs) | `49_after_repair.png` |
| 46 | Chevron retour depuis « Ta tribu » | ⚠️ Welcome s'affiche alors que l'utilisateur est connecté (guard non rejoué sur pop ? à vérifier) — de plus **aucun bouton de déconnexion** sur cet écran | `50_choose_back_attempt.png` |

### Reconnexion
| # | Action | Constat | Screenshot |
|---|---|---|---|
| 47 | Réinstallation de l'app | La session Firebase survit à la désinstallation (trousseau iOS) → retour direct sur « Ta tribu », guard OK au démarrage | `51_fresh_welcome.png` |
| 48 | `simctl keychain reset` + « J'ai déjà un compte » avec **mauvais mot de passe** | ✅ Erreur localisée « E-mail ou mot de passe incorrect. » | `52_signin_wrong_password.png` |
| 49 | Connexion `fable.test@ourtribe.be` / bon mot de passe | ✅ Retour direct sur le Home de « La tribu Fable » avec toutes ses données | `53_signin_success_home.png` |

## Verdict fonctionnel

**Validé en réel (émulateurs + security rules actives)** : inscription, guard d'authentification (toutes les
redirections), création de tribu atomique, génération + copie du code d'invitation, création de tâches
(assignée / à répartir / récurrente), attribution, toggle avec crédit des points du membre, streams temps
réel sur les 4 onglets, changement de couleur, renommage, jonction d'une tribu par code (avec preuve
vérifiée par les rules), rôles chef/membre, wording des sheets de départ, déconnexion, reconnexion,
erreurs d'authentification localisées.

**Cassé ou incomplet** : voir [BUGS.md](BUGS.md) — 2 crashs (Récompenses, sortie de tribu), la sortie de
tribu qui laisse un état incohérent, la saisie clavier du code d'invitation, et quelques restes de mock.

---

## Session 2 (07/07) — Notifications push (FCM)

Implémentation puis test live de la couche notifications (permission, token FCM, préférences persistées).

| # | Action | Constat | Screenshot |
|---|---|---|---|
| 50 | Rebuild avec `firebase_messaging`, relance sur émulateurs | OK | — |
| 51 | Profil → Notifications → toggle « Autoriser les notifications » | ✅ Le **prompt système iOS** s'affiche (« Autorisez-vous "Our Tribe Dev"… ») — déclenché seulement quand la permission n'a jamais été demandée | `54_notifications_permission.png` |
| 52 | « Autoriser » puis « Enregistrer » | ✅ `users/{uid}/settings/notifications` écrit dans Firestore **via les security rules** (bloc `settings` owner-only), avec les 8 préférences ; retour auto au Profil. ⚠️ Premier tap « Enregistrer » resté sans effet juste après la fermeture du dialog système (à surveiller, non reproduit ensuite) | `55_notifications_saved.png` |
| 53 | Vérification `fcmTokens` sur le doc user | ⚠️ Absent **sur simulateur** : pas de token APNS → `getToken()` échoue proprement → aucun enregistrement (comportement prévu ; la logique token+rotation+détachement est couverte par 7 tests unitaires). À valider sur un vrai appareil avec la capability Push Notifications | — |
