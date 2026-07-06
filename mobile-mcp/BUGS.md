# Bugs & constats — session de test mobile-mcp du 06/07/2026

Classés par gravité. Aucun correctif appliqué (à la demande) — uniquement du diagnostic.

---

## 🔴 BUG-3 — Quitter la tribu : crash + état incohérent (le plus sérieux)

**Repro** : membre simple (Remy) → Profil → « Quitter la tribu » → « Quitter ».
**Symptômes** (`46_after_leave.png`, `48_zombie_profile_crash.png`) :
1. Red screen « Bad state: No element » immédiatement après la confirmation.
2. Après relance de l'app : l'utilisateur voit encore le Home de la tribu, et l'onglet Profil crashe.

**Cause racine (double)** :
1. **Ordre des écritures vs security rules** — `TribeService.leaveTribe()` fait :
   `removeMember(moi)` → `updateInviteMemberCount(...)` → `setTribeId(null)`.
   Or les rules n'autorisent `update` sur `invites/{code}` que pour un **membre** de la tribu — et au
   moment de cet appel, l'utilisateur vient de supprimer son propre member doc. L'update est refusé
   (`permission-denied`), l'exception interrompt `leaveTribe`, et `setTribeId(null)` **n'est jamais exécuté**.
   Résultat : member doc supprimé mais `users/{uid}.tribeId` encore renseigné → **état zombie**
   (l'app croit à une tribu dont l'utilisateur n'est plus membre).
   *Piste* : mettre à jour le compteur **avant** de supprimer le membre (ou tolérer l'échec de cette
   écriture best-effort), et faire `setTribeId(null)` en priorité.
2. **Crash UI** — pendant la sortie, le stream `members` émet une liste sans l'utilisateur courant ;
   `LeaveTribeSheet`/`ProfileView` (encore montés) relisent `TribeService.currentMember`, qui fait un
   `firstWhere((m) => m.isCurrentUser)` sans garde → `Bad state: No element`.
   *Piste* : `currentMember` nullable (ou getter `currentMemberOrNull`) + les vues du shell doivent
   tolérer un frame sans membre courant (le gate `AppShell.isReady` ne protège pas les sheets).

## 🔴 BUG-1 — Écran Récompenses : crash « Bad state: No element »

**Repro** : Profil → Récompenses. **Screenshot** : `35_rewards.png`.
**Symptôme** : la cagnotte et la 1ʳᵉ carte s'affichent, puis red screen sous « Sortie ciné en tribu ».
**Cause** : `MockRewards.rewards` contient des objectifs **personnels** liés aux ids mock (`lea`, `tom`…) ;
les cartes appellent `TribeService.memberById(id)` qui fait un `firstWhere` sans `orElse` — ces membres
n'existent pas dans une vraie tribu → crash. L'écran ne marchait qu'avec `MockMembers`, supprimés lors
du branchement backend.
**Note** : les montants (« Cagnotte 84 points tribu », « 84/100 pts ») sont eux aussi des mocks alors que
le vrai total tribu est 5.

## 🟠 BUG-2 — Cases du code d'invitation : saisie clavier cassée + collage non affiché

**Repro** : Rejoindre avec un code → taper `3PPDCU` au clavier. **Screenshots** : `40_join_code_entered.png`, `41_join_pasted.png`.
**Symptômes** :
1. La frappe se répartit mal : « 3 / PP / _ / DC / _ / _ » (des cases avec 2 caractères, d'autres vides).
   L'auto-avance de `JoinCodeBoxes` se désynchronise quand plusieurs caractères arrivent d'affilée.
2. « Coller depuis le presse-papiers » met bien à jour le **contrôleur** (le lookup trouve la tribu, le
   bouton s'active) mais **pas l'affichage des cases** : les `TextEditingController`s locaux des boxes ne
   sont pas resynchronisés depuis l'état du contrôleur.
**Impact** : la jonction reste possible (via le collage), mais l'UX de saisie est cassée.

## 🟠 BLOCKER-1 — Backend dev : Firebase Auth non activé + rules non déployées

Pas un bug du code, mais bloquant pour utiliser l'app hors émulateurs :
1. `our-tribe-dev` renvoie `CONFIGURATION_NOT_FOUND` sur l'API signUp → **Firebase Authentication
   n'a jamais été activé** sur le projet (console → Authentication → Get started → Email/Password).
   L'app affiche seulement « Une erreur est survenue » (`04_after_signup.png`).
2. Les `firestore.rules` du repo ne sont pas déployées (`firebase deploy --only firestore:rules` à faire
   sur dev et prod — le déploiement a été refusé par le mode de permissions pendant la session).
**Suggestion** : mapper `operation-not-allowed` / `configuration-not-found` sur un message dédié
(« L'inscription n'est pas encore ouverte ») plutôt que le message générique.

## 🟡 BUG-4 — « Ma couleur » (Modifier le profil) : aucune pastille sélectionnée

**Repro** : Profil → Éditer. **Screenshots** : `30_profile_edit.png` (rien de coché) vs `31_edit_color_state.png` (coché après tap).
**Cause** : l'écran affiche `AppColors.tribePalette`, mais la couleur du membre peut venir de
`AppColors.memberPalette` (attribution auto au join, palette de la liste des membres). Les deux palettes
n'ont pas les mêmes valeurs → `isSelected` ne matche jamais. Harmoniser les palettes ou comparer
autrement.

## 🟡 BUG-5 — Guard non rejoué au retour (pop) depuis « Ta tribu »

**Repro** : connecté sans tribu, écran « Ta tribu » → chevron retour. **Screenshot** : `50_choose_back_attempt.png`.
**Symptôme** : l'écran Welcome (réservé aux déconnectés) s'affiche. Au redémarrage de l'app, le guard
redirige correctement — l'incohérence n'existe que dans la session. À vérifier : comportement du
`redirect` GoRouter sur `pop()`.
**Corollaire UX** : un utilisateur connecté **sans tribu n'a aucun bouton de déconnexion** (il n'existe
que dans le Profil, inaccessible sans tribu).

## 🟢 Mineurs / restes de mock

| # | Constat | Où |
|---|---|---|
| M1 | « 0 sur 1 tâche**s** faite**s** », « 1 membre**s** » — accords ICU à revoir (le pluriel semble piloté par le mauvais nombre ou des formes `one` manquantes) | Home, carte tribu trouvée |
| M2 | « ↑ 12 VS SEM. PASSÉE » codé en dur (`RecapController.deltaVsLastWeek`) | Famille · Résumé |
| M3 | Activité du détail de tâche : « Fait la semaine dernière par X · +2 » = texte démo, faux pour une tâche créée à l'instant | Détail tâche |
| M4 | Description par défaut du détail = texte générique même sans description saisie (choix design à confirmer) | Détail tâche |
| M5 | Préférences Notifications / Récurrences non persistées (état local remis à zéro à chaque ouverture) | Réglages |
| M6 | Home vide (0 tâche) : aucun état vide/CTA « ajoute ta première tâche » | Home |
| M7 | Semaine : pastilles de compte identiques chaque jour, « Sem. 28 ‹ › » inerte — en attente du modèle de planification par date | Semaine |
| M8 | E-mail modifiable dans « Modifier le profil » mais jamais sauvegardé (pas de `updateEmail`) | Profil |

## État des données de test (émulateurs)

- Comptes : `fable.test@ourtribe.be` / `fable123` (chef) · `remy.test@ourtribe.be` / `remy123`
- Tribu « La tribu Fable », code `3PP-DCU`, 2 tâches — **données volatiles** : tout disparaît à l'arrêt
  des émulateurs (`firebase emulators:start --only auth,firestore` pour les relancer).

---

## Session 2 (07/07) — constats notifications

| # | Constat | Détail |
|---|---|---|
| N1 | Premier « Enregistrer » sans effet après le dialog de permission | Juste après la fermeture du prompt système iOS, le tap sur Enregistrer n'a pas déclenché la sauvegarde (bouton resté inactif). Non reproduit à la réouverture de l'écran. À re-tester manuellement. |
| N2 | Pas de token FCM sur simulateur | `getToken()` échoue sans APNS (simulateur) — silencieusement géré. Sur device réel, il faut la capability **Push Notifications** dans Xcode (Signing & Capabilities) + un APNs key dans la console Firebase. |
