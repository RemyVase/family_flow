// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Our Tribe';

  @override
  String get welcomeTagline =>
      'Les tâches de la maison,\ntoute la tribu au même endroit.';

  @override
  String get createAccountButton => 'Créer mon compte';

  @override
  String get alreadyHaveAccount => 'J\'ai déjà un compte';

  @override
  String get signupTitle => 'Créer un compte';

  @override
  String get signupSubtitle => 'On commence par toi.';

  @override
  String get firstNameLabel => 'Ton prénom';

  @override
  String get firstNamePlaceholder => 'Ex. Léa';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailPlaceholder => 'lea@ourtribe.be';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordPlaceholder => 'Choisis un mot de passe';

  @override
  String get passwordDotsPlaceholder => '••••••••';

  @override
  String get signupNote =>
      'Ton prénom s\'affichera sur tes tâches et dans le classement de la tribu.';

  @override
  String get continueButton => 'Continuer';

  @override
  String get signinTitle => 'Bon retour';

  @override
  String get signinSubtitle => 'Connecte-toi à ton compte.';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get signinButton => 'Se connecter';

  @override
  String get chooseTitle => 'Ta tribu';

  @override
  String get chooseSubtitle =>
      'Rejoins la tribu de quelqu\'un, ou crée la tienne.';

  @override
  String get createTribeChoice => 'Créer une tribu';

  @override
  String get createTribeChoiceDetail => 'Je démarre et j\'invite les autres';

  @override
  String get joinChoice => 'Rejoindre avec un code';

  @override
  String get joinChoiceDetail => 'On m\'a partagé un code d\'invitation';

  @override
  String get createTribeTitle => 'Nouvelle tribu';

  @override
  String get createTribeSubtitle => 'Donne-lui un nom et une couleur.';

  @override
  String get tribeNameLabel => 'Nom de la tribu';

  @override
  String get tribeNamePlaceholder => 'Ex. La tribu Dubois';

  @override
  String get tribeColorLabel => 'Couleur de la tribu';

  @override
  String get createTribeButton => 'Créer la tribu';

  @override
  String get tribeCreatedBadge => 'Tribu créée';

  @override
  String get inviteTitle => 'Invite ta tribu';

  @override
  String get inviteSubtitle =>
      'Partage ce code. Chacun l\'entre après son inscription.';

  @override
  String get inviteCodeLabel => 'Code d\'invitation';

  @override
  String get copyButton => 'Copier';

  @override
  String get shareButton => 'Partager';

  @override
  String get inviteNote =>
      'Tu pourras toujours retrouver ce code dans ton profil.';

  @override
  String get joinTitle => 'Rejoindre';

  @override
  String get joinSubtitle => 'Entre le code que ta tribu t\'a partagé.';

  @override
  String membersCount(int count) {
    return '$count membres';
  }

  @override
  String get joinTribeButton => 'Rejoindre la tribu';

  @override
  String doneTitle(String name) {
    return 'C\'est parti, $name';
  }

  @override
  String get doneTagline =>
      'Ta tribu est prête.\nÀ vous de jouer, une tâche à la fois.';

  @override
  String get enterAppButton => 'Entrer dans Our Tribe';

  @override
  String get greeting => 'Salut la tribu';

  @override
  String tasksDoneCount(int done, int total) {
    return '$done sur $total tâches faites';
  }

  @override
  String get progressMessageStart => 'En route, on y va';

  @override
  String get progressMessageKeepGoing => 'Belle lancée, continue';

  @override
  String progressMessageAlmost(int count) {
    return 'Plus que $count, tu gères';
  }

  @override
  String get progressMessageAllDone => 'Tout est fait — la tribu assure';

  @override
  String get pointsLabel => 'points';

  @override
  String plusPoints(int points) {
    return '+$points';
  }

  @override
  String get sectionMorning => 'Ce matin';

  @override
  String get sectionAfternoon => 'Cet après-midi';

  @override
  String get sectionEvening => 'Ce soir';

  @override
  String sectionCount(int done, int total) {
    return '$done/$total';
  }

  @override
  String get tabHome => 'Accueil';

  @override
  String get tabWeek => 'Semaine';

  @override
  String get tabFamily => 'Famille';

  @override
  String get tabProfile => 'Profil';

  @override
  String weekKicker(int week, String month) {
    return 'Semaine $week · $month';
  }

  @override
  String daySummary(int count, int done) {
    return '$count tâches · $done faites';
  }

  @override
  String pointsSuffix(int points) {
    return '$points pts';
  }

  @override
  String get nowLabel => 'maintenant';

  @override
  String recapWeekShort(int week) {
    return 'Sem. $week';
  }

  @override
  String get segmentSummary => 'Résumé';

  @override
  String get segmentTasks => 'Tâches';

  @override
  String get tribeTotal => 'Total de la tribu';

  @override
  String get vsLastWeek => 'vs sem. passée';

  @override
  String get perPersonTitle => 'Cette semaine, par personne';

  @override
  String get clanTitle => 'Le clan cette semaine';

  @override
  String get clanNote => 'juste pour le fun';

  @override
  String get youSuffix => 'toi';

  @override
  String get chiefSuffix => 'chef';

  @override
  String memberTasksDone(int count) {
    return '$count tâches faites';
  }

  @override
  String tribeGoal(String name) {
    return 'Objectif tribu · $name';
  }

  @override
  String rewardProgress(int points, int goal, int remaining) {
    return '$points / $goal pts — plus que $remaining !';
  }

  @override
  String get filterAll => 'Toutes';

  @override
  String get filterTodo => 'À faire';

  @override
  String get filterDone => 'Faites';

  @override
  String get filterRecurring => 'Récurrentes';

  @override
  String get groupTodo => 'À faire';

  @override
  String get groupDone => 'Faites';

  @override
  String get emptyListMessage => 'Rien ici pour l\'instant';

  @override
  String get editButton => 'Modifier';

  @override
  String todayAt(String time) {
    return 'Aujourd\'hui · $time';
  }

  @override
  String get todayLabel => 'Aujourd\'hui';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get defaultTaskDescription =>
      'Tâche récurrente de la maison. Ajoute des détails ou une photo pour aider la personne qui s\'en occupe.';

  @override
  String get assignedTo => 'Attribuée à';

  @override
  String get changeAction => 'changer';

  @override
  String get activityLabel => 'Activité';

  @override
  String activityLastWeek(String name, int points) {
    return 'Fait la semaine dernière par $name · +$points';
  }

  @override
  String get markDoneButton => 'Marquer comme fait';

  @override
  String get undoDoneButton => 'Fait ! Annuler';

  @override
  String get attributionLabel => 'Attribution';

  @override
  String get assignPersonChip => 'Une personne';

  @override
  String get assignRotateChip => 'À tour de rôle';

  @override
  String get assignUnassignedChip => 'À répartir';

  @override
  String get assignUnassignedHint =>
      'La tâche ira dans « À répartir », chacun pourra la prendre.';

  @override
  String get assignRotateHint =>
      'À chaque fois, la tribu choisit qui s\'en occupe.';

  @override
  String get rotateBadge => 'À tour de rôle';

  @override
  String unassignedBannerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches à répartir',
      one: '1 tâche à répartir',
    );
    return '$_temp0';
  }

  @override
  String get unassignedBannerSubtitle =>
      'Personne n\'est encore assigné · appuie pour répartir';

  @override
  String get unassignedTitle => 'À répartir';

  @override
  String get unassignedSubtitle =>
      'Ces tâches n\'ont pas encore de responsable. Choisis qui s\'en occupe.';

  @override
  String get unassignedEmptyTitle => 'Tout est réparti';

  @override
  String get unassignedEmptyDetail => 'Chaque tâche a son responsable.';

  @override
  String get assignToLabel => 'Attribuer à';

  @override
  String get rotateWhoLabel => 'Qui s\'en occupe cette fois ?';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get newTaskTitle => 'Nouvelle tâche';

  @override
  String get taskNameLabel => 'Nom de la tâche';

  @override
  String get taskNamePlaceholder => 'Ex. Sortir les poubelles';

  @override
  String get optionalSuffix => 'optionnel';

  @override
  String get descriptionPlaceholder => 'Ajoute des précisions…';

  @override
  String get forWhoLabel => 'Pour qui';

  @override
  String get meLabel => 'Moi';

  @override
  String get pointsSectionLabel => 'Points';

  @override
  String get pointsHint => 'Récompense en points';

  @override
  String get recurrenceLabel => 'Récurrence';

  @override
  String get recurrenceOnce => 'Une fois';

  @override
  String get recurrenceDaily => 'Tous les jours';

  @override
  String get recurrenceTwiceDaily => '2×/jour';

  @override
  String get recurrenceThriceDaily => '3×/jour';

  @override
  String get recurrenceWeekly => '1×/semaine';

  @override
  String get whenLabel => 'Quand';

  @override
  String get momentMorning => 'Matin';

  @override
  String get momentAfternoon => 'Après-midi';

  @override
  String get momentEvening => 'Soir';

  @override
  String momentChip(String label, String time) {
    return '$label · $time';
  }

  @override
  String get photosLabel => 'Photos';

  @override
  String get addPhotoButton => 'Ajouter';

  @override
  String get createTaskButton => 'Créer la tâche';

  @override
  String get myAccountKicker => 'Mon compte';

  @override
  String get profileTitle => 'Profil';

  @override
  String get editProfileButton => 'Éditer';

  @override
  String membersLabel(int count) {
    return 'Membres · $count';
  }

  @override
  String get manageAction => 'Gérer';

  @override
  String get chiefMembersHint =>
      'Touche une pastille pour changer la couleur · glisse une ligne pour retirer un membre';

  @override
  String get memberColorHint =>
      'Touche ta pastille pour changer ta couleur — elle s\'applique partout';

  @override
  String get meSuffix => 'moi';

  @override
  String removeMemberQuestion(String name) {
    return 'Retirer $name de la tribu ?';
  }

  @override
  String get removeAction => 'Retirer';

  @override
  String get leaveTribeButton => 'Quitter la tribu';

  @override
  String get leaveChiefWarning =>
      'Tu es le chef de la tribu. Avant de partir, choisis qui prend le relais.';

  @override
  String get newChiefTitle => 'Nouveau chef de tribu';

  @override
  String get nameAndLeaveButton => 'Nommer & quitter';

  @override
  String leaveTribeQuestion(String name) {
    return 'Quitter $name ?';
  }

  @override
  String get leaveTribeDetail =>
      'Tu ne verras plus ses tâches et ton score sera retiré du classement.';

  @override
  String get deleteTribeQuestion => 'Supprimer la tribu ?';

  @override
  String get deleteTribeDetail =>
      'Tu es le dernier membre. Quitter supprimera définitivement la tribu et ses tâches.';

  @override
  String get deleteAction => 'Supprimer';

  @override
  String get leaveAction => 'Quitter';

  @override
  String get editProfileTitle => 'Modifier le profil';

  @override
  String get editProfileSubtitle =>
      'Ton nom et ta couleur apparaissent partout dans la tribu.';

  @override
  String get changePhotoButton => 'Changer la photo';

  @override
  String get firstNameSimpleLabel => 'Prénom';

  @override
  String get myColorLabel => 'Ma couleur';

  @override
  String get securityLabel => 'Sécurité';

  @override
  String get changePasswordLabel => 'Changer le mot de passe';

  @override
  String get settingsLabel => 'Paramètres';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get notificationsEnabled => 'Activées';

  @override
  String get remindersEntryLabel => 'Récurrences';

  @override
  String get rewardsEntryLabel => 'Récompenses';

  @override
  String rewardsEntryDetail(int count) {
    return '$count objectifs';
  }

  @override
  String get helpLabel => 'Aide';

  @override
  String get logoutButton => 'Se déconnecter';

  @override
  String versionLabel(String version) {
    return 'Our Tribe · v$version';
  }

  @override
  String get rewardsTitle => 'Récompenses';

  @override
  String get rewardsSubtitle =>
      'Des objectifs à débloquer avec les points. Zéro pression, que du fun.';

  @override
  String get weeklyPotLabel => 'Cagnotte de la semaine';

  @override
  String get tribePointsLabel => 'points tribu';

  @override
  String goalsLabel(int count) {
    return 'Objectifs · $count';
  }

  @override
  String get tribeKind => 'Tribu';

  @override
  String get unlockedLabel => 'Débloqué !';

  @override
  String rewardCardProgress(int points, int goal, int remaining) {
    return '$points / $goal pts · plus que $remaining';
  }

  @override
  String get addRewardButton => 'Ajouter une récompense';

  @override
  String get doneButton => 'Terminé';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Choisis ce que la tribu reçoit, et quand.';

  @override
  String get allowNotificationsLabel => 'Autoriser les notifications';

  @override
  String get notificationsOnDetail => 'Activées sur cet appareil';

  @override
  String get notificationsOffDetail => 'Tout est en pause';

  @override
  String get taskRemindersSection => 'Rappels de tâches';

  @override
  String get tribeLifeSection => 'Vie de la tribu';

  @override
  String get pointsRewardsLabel => 'Points & récompenses';

  @override
  String get pointsRewardsDetail => 'Quand un objectif est débloqué';

  @override
  String get doNotDisturbSection => 'Ne pas déranger';

  @override
  String get quietNightLabel => 'Nuit calme';

  @override
  String get quietNightDetail => 'Aucune notif de 21:00 à 7:00';

  @override
  String get remindersTitle => 'Récurrences';

  @override
  String get remindersSubtitle =>
      'Comment les tâches répétitives et les points se renouvellent.';

  @override
  String get recurrencesNote =>
      'Les rappels et notifications se règlent dans « Notifications ».';

  @override
  String get remindTasksLabel => 'Rappeler les tâches';

  @override
  String get remindTasksDetail => 'Une notif avant l\'heure prévue';

  @override
  String get leadTimeLabel => 'Prévenir avant';

  @override
  String get leadOnTime => 'À l\'heure';

  @override
  String get leadFifteenMinutes => '15 min';

  @override
  String get leadThirtyMinutes => '30 min';

  @override
  String get leadOneHour => '1 h';

  @override
  String get summariesSection => 'Récapitulatifs';

  @override
  String get morningSummaryLabel => 'Résumé du matin';

  @override
  String get morningSummaryDetail => 'Les tâches du jour à 8:00';

  @override
  String get eveningReminderLabel => 'Rappel du soir';

  @override
  String get eveningReminderDetail => 'Ce qu\'il reste à faire à 19:00';

  @override
  String get overdueLabel => 'Tâches en retard';

  @override
  String get overdueDetail => 'Prévenir si une tâche est oubliée';

  @override
  String get recurrencesSection => 'Récurrences';

  @override
  String get weekStartLabel => 'Début de semaine';

  @override
  String get weekStartDetail => 'Jour où les points hebdo repartent à zéro';

  @override
  String get mondayLabel => 'Lundi';

  @override
  String get saturdayLabel => 'Samedi';

  @override
  String get sundayLabel => 'Dimanche';

  @override
  String get autoCarryLabel => 'Reporter automatiquement';

  @override
  String get autoCarryDetail => 'Une tâche non faite passe au lendemain';

  @override
  String get remindersNote =>
      'Chaque tâche peut aussi avoir ses propres rappels, réglés à sa création.';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get copiedButton => 'Copié !';

  @override
  String inviteShareMessage(String code) {
    return 'Rejoins notre tribu sur Our Tribe avec le code $code !';
  }

  @override
  String get pasteFromClipboard => 'Coller depuis le presse-papiers';

  @override
  String get joinCodeNotFound =>
      'Aucune tribu ne correspond à ce code. Vérifie-le et réessaie.';

  @override
  String get authErrorEmailInUse => 'Un compte existe déjà avec cet e-mail.';

  @override
  String get authErrorInvalidEmail => 'Cette adresse e-mail n\'est pas valide.';

  @override
  String get authErrorWeakPassword =>
      'Le mot de passe est trop court (6 caractères minimum).';

  @override
  String get authErrorInvalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get authErrorNetwork =>
      'Pas de connexion. Vérifie ton réseau et réessaie.';

  @override
  String get authErrorUnknown =>
      'Une erreur est survenue. Réessaie dans un instant.';
}
