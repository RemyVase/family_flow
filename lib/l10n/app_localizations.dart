import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'Our Tribe'**
  String get appName;

  /// No description provided for @welcomeTagline.
  ///
  /// In fr, this message translates to:
  /// **'Les tâches de la maison,\ntoute la tribu au même endroit.'**
  String get welcomeTagline;

  /// No description provided for @createAccountButton.
  ///
  /// In fr, this message translates to:
  /// **'Créer mon compte'**
  String get createAccountButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai déjà un compte'**
  String get alreadyHaveAccount;

  /// No description provided for @signupTitle.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'On commence par toi.'**
  String get signupSubtitle;

  /// No description provided for @firstNameLabel.
  ///
  /// In fr, this message translates to:
  /// **'Ton prénom'**
  String get firstNameLabel;

  /// No description provided for @firstNamePlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Léa'**
  String get firstNamePlaceholder;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @emailPlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'lea@ourtribe.be'**
  String get emailPlaceholder;

  /// No description provided for @passwordLabel.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get passwordLabel;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Choisis un mot de passe'**
  String get passwordPlaceholder;

  /// No description provided for @passwordDotsPlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'••••••••'**
  String get passwordDotsPlaceholder;

  /// No description provided for @signupNote.
  ///
  /// In fr, this message translates to:
  /// **'Ton prénom s\'affichera sur tes tâches et dans le classement de la tribu.'**
  String get signupNote;

  /// No description provided for @continueButton.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continueButton;

  /// No description provided for @signinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Bon retour'**
  String get signinTitle;

  /// No description provided for @signinSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Connecte-toi à ton compte.'**
  String get signinSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get forgotPassword;

  /// No description provided for @signinButton.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get signinButton;

  /// No description provided for @chooseTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ta tribu'**
  String get chooseTitle;

  /// No description provided for @chooseSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Rejoins la tribu de quelqu\'un, ou crée la tienne.'**
  String get chooseSubtitle;

  /// No description provided for @createTribeChoice.
  ///
  /// In fr, this message translates to:
  /// **'Créer une tribu'**
  String get createTribeChoice;

  /// No description provided for @createTribeChoiceDetail.
  ///
  /// In fr, this message translates to:
  /// **'Je démarre et j\'invite les autres'**
  String get createTribeChoiceDetail;

  /// No description provided for @joinChoice.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre avec un code'**
  String get joinChoice;

  /// No description provided for @joinChoiceDetail.
  ///
  /// In fr, this message translates to:
  /// **'On m\'a partagé un code d\'invitation'**
  String get joinChoiceDetail;

  /// No description provided for @createTribeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle tribu'**
  String get createTribeTitle;

  /// No description provided for @createTribeSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Donne-lui un nom et une couleur.'**
  String get createTribeSubtitle;

  /// No description provided for @tribeNameLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la tribu'**
  String get tribeNameLabel;

  /// No description provided for @tribeNamePlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Ex. La tribu Dubois'**
  String get tribeNamePlaceholder;

  /// No description provided for @tribeColorLabel.
  ///
  /// In fr, this message translates to:
  /// **'Couleur de la tribu'**
  String get tribeColorLabel;

  /// No description provided for @createTribeButton.
  ///
  /// In fr, this message translates to:
  /// **'Créer la tribu'**
  String get createTribeButton;

  /// No description provided for @tribeCreatedBadge.
  ///
  /// In fr, this message translates to:
  /// **'Tribu créée'**
  String get tribeCreatedBadge;

  /// No description provided for @inviteTitle.
  ///
  /// In fr, this message translates to:
  /// **'Invite ta tribu'**
  String get inviteTitle;

  /// No description provided for @inviteSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Partage ce code. Chacun l\'entre après son inscription.'**
  String get inviteSubtitle;

  /// No description provided for @inviteCodeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Code d\'invitation'**
  String get inviteCodeLabel;

  /// No description provided for @copyButton.
  ///
  /// In fr, this message translates to:
  /// **'Copier'**
  String get copyButton;

  /// No description provided for @shareButton.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get shareButton;

  /// No description provided for @inviteNote.
  ///
  /// In fr, this message translates to:
  /// **'Tu pourras toujours retrouver ce code dans ton profil.'**
  String get inviteNote;

  /// No description provided for @joinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre'**
  String get joinTitle;

  /// No description provided for @joinSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Entre le code que ta tribu t\'a partagé.'**
  String get joinSubtitle;

  /// No description provided for @membersCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} membres'**
  String membersCount(int count);

  /// No description provided for @joinTribeButton.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre la tribu'**
  String get joinTribeButton;

  /// No description provided for @doneTitle.
  ///
  /// In fr, this message translates to:
  /// **'C\'est parti, {name}'**
  String doneTitle(String name);

  /// No description provided for @doneTagline.
  ///
  /// In fr, this message translates to:
  /// **'Ta tribu est prête.\nÀ vous de jouer, une tâche à la fois.'**
  String get doneTagline;

  /// No description provided for @enterAppButton.
  ///
  /// In fr, this message translates to:
  /// **'Entrer dans Our Tribe'**
  String get enterAppButton;

  /// No description provided for @greeting.
  ///
  /// In fr, this message translates to:
  /// **'Salut la tribu'**
  String get greeting;

  /// No description provided for @tasksDoneCount.
  ///
  /// In fr, this message translates to:
  /// **'{done} sur {total} tâches faites'**
  String tasksDoneCount(int done, int total);

  /// No description provided for @progressMessageStart.
  ///
  /// In fr, this message translates to:
  /// **'En route, on y va'**
  String get progressMessageStart;

  /// No description provided for @progressMessageKeepGoing.
  ///
  /// In fr, this message translates to:
  /// **'Belle lancée, continue'**
  String get progressMessageKeepGoing;

  /// No description provided for @progressMessageAlmost.
  ///
  /// In fr, this message translates to:
  /// **'Plus que {count}, tu gères'**
  String progressMessageAlmost(int count);

  /// No description provided for @progressMessageAllDone.
  ///
  /// In fr, this message translates to:
  /// **'Tout est fait — la tribu assure'**
  String get progressMessageAllDone;

  /// No description provided for @pointsLabel.
  ///
  /// In fr, this message translates to:
  /// **'points'**
  String get pointsLabel;

  /// No description provided for @plusPoints.
  ///
  /// In fr, this message translates to:
  /// **'+{points}'**
  String plusPoints(int points);

  /// No description provided for @sectionMorning.
  ///
  /// In fr, this message translates to:
  /// **'Ce matin'**
  String get sectionMorning;

  /// No description provided for @sectionAfternoon.
  ///
  /// In fr, this message translates to:
  /// **'Cet après-midi'**
  String get sectionAfternoon;

  /// No description provided for @sectionEvening.
  ///
  /// In fr, this message translates to:
  /// **'Ce soir'**
  String get sectionEvening;

  /// No description provided for @sectionCount.
  ///
  /// In fr, this message translates to:
  /// **'{done}/{total}'**
  String sectionCount(int done, int total);

  /// No description provided for @tabHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get tabHome;

  /// No description provided for @tabWeek.
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get tabWeek;

  /// No description provided for @tabFamily.
  ///
  /// In fr, this message translates to:
  /// **'Famille'**
  String get tabFamily;

  /// No description provided for @tabProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get tabProfile;

  /// No description provided for @weekKicker.
  ///
  /// In fr, this message translates to:
  /// **'Semaine {week} · {month}'**
  String weekKicker(int week, String month);

  /// No description provided for @daySummary.
  ///
  /// In fr, this message translates to:
  /// **'{count} tâches · {done} faites'**
  String daySummary(int count, int done);

  /// No description provided for @pointsSuffix.
  ///
  /// In fr, this message translates to:
  /// **'{points} pts'**
  String pointsSuffix(int points);

  /// No description provided for @nowLabel.
  ///
  /// In fr, this message translates to:
  /// **'maintenant'**
  String get nowLabel;

  /// No description provided for @recapWeekShort.
  ///
  /// In fr, this message translates to:
  /// **'Sem. {week}'**
  String recapWeekShort(int week);

  /// No description provided for @segmentSummary.
  ///
  /// In fr, this message translates to:
  /// **'Résumé'**
  String get segmentSummary;

  /// No description provided for @segmentTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches'**
  String get segmentTasks;

  /// No description provided for @tribeTotal.
  ///
  /// In fr, this message translates to:
  /// **'Total de la tribu'**
  String get tribeTotal;

  /// No description provided for @vsLastWeek.
  ///
  /// In fr, this message translates to:
  /// **'vs sem. passée'**
  String get vsLastWeek;

  /// No description provided for @perPersonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Cette semaine, par personne'**
  String get perPersonTitle;

  /// No description provided for @clanTitle.
  ///
  /// In fr, this message translates to:
  /// **'Le clan cette semaine'**
  String get clanTitle;

  /// No description provided for @clanNote.
  ///
  /// In fr, this message translates to:
  /// **'juste pour le fun'**
  String get clanNote;

  /// No description provided for @youSuffix.
  ///
  /// In fr, this message translates to:
  /// **'toi'**
  String get youSuffix;

  /// No description provided for @chiefSuffix.
  ///
  /// In fr, this message translates to:
  /// **'chef'**
  String get chiefSuffix;

  /// No description provided for @memberTasksDone.
  ///
  /// In fr, this message translates to:
  /// **'{count} tâches faites'**
  String memberTasksDone(int count);

  /// No description provided for @tribeGoal.
  ///
  /// In fr, this message translates to:
  /// **'Objectif tribu · {name}'**
  String tribeGoal(String name);

  /// No description provided for @rewardProgress.
  ///
  /// In fr, this message translates to:
  /// **'{points} / {goal} pts — plus que {remaining} !'**
  String rewardProgress(int points, int goal, int remaining);

  /// No description provided for @filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Toutes'**
  String get filterAll;

  /// No description provided for @filterTodo.
  ///
  /// In fr, this message translates to:
  /// **'À faire'**
  String get filterTodo;

  /// No description provided for @filterDone.
  ///
  /// In fr, this message translates to:
  /// **'Faites'**
  String get filterDone;

  /// No description provided for @filterRecurring.
  ///
  /// In fr, this message translates to:
  /// **'Récurrentes'**
  String get filterRecurring;

  /// No description provided for @groupTodo.
  ///
  /// In fr, this message translates to:
  /// **'À faire'**
  String get groupTodo;

  /// No description provided for @groupDone.
  ///
  /// In fr, this message translates to:
  /// **'Faites'**
  String get groupDone;

  /// No description provided for @emptyListMessage.
  ///
  /// In fr, this message translates to:
  /// **'Rien ici pour l\'instant'**
  String get emptyListMessage;

  /// No description provided for @editButton.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get editButton;

  /// No description provided for @todayAt.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui · {time}'**
  String todayAt(String time);

  /// No description provided for @todayLabel.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get todayLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @defaultTaskDescription.
  ///
  /// In fr, this message translates to:
  /// **'Tâche récurrente de la maison. Ajoute des détails ou une photo pour aider la personne qui s\'en occupe.'**
  String get defaultTaskDescription;

  /// No description provided for @assignedTo.
  ///
  /// In fr, this message translates to:
  /// **'Attribuée à'**
  String get assignedTo;

  /// No description provided for @changeAction.
  ///
  /// In fr, this message translates to:
  /// **'changer'**
  String get changeAction;

  /// No description provided for @activityLabel.
  ///
  /// In fr, this message translates to:
  /// **'Activité'**
  String get activityLabel;

  /// No description provided for @activityLastWeek.
  ///
  /// In fr, this message translates to:
  /// **'Fait la semaine dernière par {name} · +{points}'**
  String activityLastWeek(String name, int points);

  /// No description provided for @markDoneButton.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme fait'**
  String get markDoneButton;

  /// No description provided for @undoDoneButton.
  ///
  /// In fr, this message translates to:
  /// **'Fait ! Annuler'**
  String get undoDoneButton;

  /// No description provided for @attributionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Attribution'**
  String get attributionLabel;

  /// No description provided for @assignPersonChip.
  ///
  /// In fr, this message translates to:
  /// **'Une personne'**
  String get assignPersonChip;

  /// No description provided for @assignRotateChip.
  ///
  /// In fr, this message translates to:
  /// **'À tour de rôle'**
  String get assignRotateChip;

  /// No description provided for @assignUnassignedChip.
  ///
  /// In fr, this message translates to:
  /// **'À répartir'**
  String get assignUnassignedChip;

  /// No description provided for @assignUnassignedHint.
  ///
  /// In fr, this message translates to:
  /// **'La tâche ira dans « À répartir », chacun pourra la prendre.'**
  String get assignUnassignedHint;

  /// No description provided for @assignRotateHint.
  ///
  /// In fr, this message translates to:
  /// **'À chaque fois, la tribu choisit qui s\'en occupe.'**
  String get assignRotateHint;

  /// No description provided for @rotateBadge.
  ///
  /// In fr, this message translates to:
  /// **'À tour de rôle'**
  String get rotateBadge;

  /// No description provided for @unassignedBannerTitle.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{1 tâche à répartir} other{{count} tâches à répartir}}'**
  String unassignedBannerTitle(int count);

  /// No description provided for @unassignedBannerSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Personne n\'est encore assigné · appuie pour répartir'**
  String get unassignedBannerSubtitle;

  /// No description provided for @unassignedTitle.
  ///
  /// In fr, this message translates to:
  /// **'À répartir'**
  String get unassignedTitle;

  /// No description provided for @unassignedSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Ces tâches n\'ont pas encore de responsable. Choisis qui s\'en occupe.'**
  String get unassignedSubtitle;

  /// No description provided for @unassignedEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tout est réparti'**
  String get unassignedEmptyTitle;

  /// No description provided for @unassignedEmptyDetail.
  ///
  /// In fr, this message translates to:
  /// **'Chaque tâche a son responsable.'**
  String get unassignedEmptyDetail;

  /// No description provided for @assignToLabel.
  ///
  /// In fr, this message translates to:
  /// **'Attribuer à'**
  String get assignToLabel;

  /// No description provided for @rotateWhoLabel.
  ///
  /// In fr, this message translates to:
  /// **'Qui s\'en occupe cette fois ?'**
  String get rotateWhoLabel;

  /// No description provided for @cancelButton.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancelButton;

  /// No description provided for @newTaskTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle tâche'**
  String get newTaskTitle;

  /// No description provided for @taskNameLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la tâche'**
  String get taskNameLabel;

  /// No description provided for @taskNamePlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Sortir les poubelles'**
  String get taskNamePlaceholder;

  /// No description provided for @optionalSuffix.
  ///
  /// In fr, this message translates to:
  /// **'optionnel'**
  String get optionalSuffix;

  /// No description provided for @descriptionPlaceholder.
  ///
  /// In fr, this message translates to:
  /// **'Ajoute des précisions…'**
  String get descriptionPlaceholder;

  /// No description provided for @forWhoLabel.
  ///
  /// In fr, this message translates to:
  /// **'Pour qui'**
  String get forWhoLabel;

  /// No description provided for @meLabel.
  ///
  /// In fr, this message translates to:
  /// **'Moi'**
  String get meLabel;

  /// No description provided for @pointsSectionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Points'**
  String get pointsSectionLabel;

  /// No description provided for @pointsHint.
  ///
  /// In fr, this message translates to:
  /// **'Récompense en points'**
  String get pointsHint;

  /// No description provided for @recurrenceLabel.
  ///
  /// In fr, this message translates to:
  /// **'Récurrence'**
  String get recurrenceLabel;

  /// No description provided for @recurrenceOnce.
  ///
  /// In fr, this message translates to:
  /// **'Une fois'**
  String get recurrenceOnce;

  /// No description provided for @recurrenceDaily.
  ///
  /// In fr, this message translates to:
  /// **'Tous les jours'**
  String get recurrenceDaily;

  /// No description provided for @recurrenceTwiceDaily.
  ///
  /// In fr, this message translates to:
  /// **'2×/jour'**
  String get recurrenceTwiceDaily;

  /// No description provided for @recurrenceThriceDaily.
  ///
  /// In fr, this message translates to:
  /// **'3×/jour'**
  String get recurrenceThriceDaily;

  /// No description provided for @recurrenceWeekly.
  ///
  /// In fr, this message translates to:
  /// **'1×/semaine'**
  String get recurrenceWeekly;

  /// No description provided for @whenLabel.
  ///
  /// In fr, this message translates to:
  /// **'Quand'**
  String get whenLabel;

  /// No description provided for @momentMorning.
  ///
  /// In fr, this message translates to:
  /// **'Matin'**
  String get momentMorning;

  /// No description provided for @momentAfternoon.
  ///
  /// In fr, this message translates to:
  /// **'Après-midi'**
  String get momentAfternoon;

  /// No description provided for @momentEvening.
  ///
  /// In fr, this message translates to:
  /// **'Soir'**
  String get momentEvening;

  /// No description provided for @momentChip.
  ///
  /// In fr, this message translates to:
  /// **'{label} · {time}'**
  String momentChip(String label, String time);

  /// No description provided for @photosLabel.
  ///
  /// In fr, this message translates to:
  /// **'Photos'**
  String get photosLabel;

  /// No description provided for @addPhotoButton.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get addPhotoButton;

  /// No description provided for @createTaskButton.
  ///
  /// In fr, this message translates to:
  /// **'Créer la tâche'**
  String get createTaskButton;

  /// No description provided for @myAccountKicker.
  ///
  /// In fr, this message translates to:
  /// **'Mon compte'**
  String get myAccountKicker;

  /// No description provided for @profileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @editProfileButton.
  ///
  /// In fr, this message translates to:
  /// **'Éditer'**
  String get editProfileButton;

  /// No description provided for @membersLabel.
  ///
  /// In fr, this message translates to:
  /// **'Membres · {count}'**
  String membersLabel(int count);

  /// No description provided for @manageAction.
  ///
  /// In fr, this message translates to:
  /// **'Gérer'**
  String get manageAction;

  /// No description provided for @chiefMembersHint.
  ///
  /// In fr, this message translates to:
  /// **'Touche une pastille pour changer la couleur · glisse une ligne pour retirer un membre'**
  String get chiefMembersHint;

  /// No description provided for @memberColorHint.
  ///
  /// In fr, this message translates to:
  /// **'Touche ta pastille pour changer ta couleur — elle s\'applique partout'**
  String get memberColorHint;

  /// No description provided for @meSuffix.
  ///
  /// In fr, this message translates to:
  /// **'moi'**
  String get meSuffix;

  /// No description provided for @removeMemberQuestion.
  ///
  /// In fr, this message translates to:
  /// **'Retirer {name} de la tribu ?'**
  String removeMemberQuestion(String name);

  /// No description provided for @removeAction.
  ///
  /// In fr, this message translates to:
  /// **'Retirer'**
  String get removeAction;

  /// No description provided for @leaveTribeButton.
  ///
  /// In fr, this message translates to:
  /// **'Quitter la tribu'**
  String get leaveTribeButton;

  /// No description provided for @leaveChiefWarning.
  ///
  /// In fr, this message translates to:
  /// **'Tu es le chef de la tribu. Avant de partir, choisis qui prend le relais.'**
  String get leaveChiefWarning;

  /// No description provided for @newChiefTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau chef de tribu'**
  String get newChiefTitle;

  /// No description provided for @nameAndLeaveButton.
  ///
  /// In fr, this message translates to:
  /// **'Nommer & quitter'**
  String get nameAndLeaveButton;

  /// No description provided for @leaveTribeQuestion.
  ///
  /// In fr, this message translates to:
  /// **'Quitter {name} ?'**
  String leaveTribeQuestion(String name);

  /// No description provided for @leaveTribeDetail.
  ///
  /// In fr, this message translates to:
  /// **'Tu ne verras plus ses tâches et ton score sera retiré du classement.'**
  String get leaveTribeDetail;

  /// No description provided for @deleteTribeQuestion.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la tribu ?'**
  String get deleteTribeQuestion;

  /// No description provided for @deleteTribeDetail.
  ///
  /// In fr, this message translates to:
  /// **'Tu es le dernier membre. Quitter supprimera définitivement la tribu et ses tâches.'**
  String get deleteTribeDetail;

  /// No description provided for @deleteAction.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get deleteAction;

  /// No description provided for @leaveAction.
  ///
  /// In fr, this message translates to:
  /// **'Quitter'**
  String get leaveAction;

  /// No description provided for @editProfileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le profil'**
  String get editProfileTitle;

  /// No description provided for @editProfileSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Ton nom et ta couleur apparaissent partout dans la tribu.'**
  String get editProfileSubtitle;

  /// No description provided for @changePhotoButton.
  ///
  /// In fr, this message translates to:
  /// **'Changer la photo'**
  String get changePhotoButton;

  /// No description provided for @firstNameSimpleLabel.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get firstNameSimpleLabel;

  /// No description provided for @myColorLabel.
  ///
  /// In fr, this message translates to:
  /// **'Ma couleur'**
  String get myColorLabel;

  /// No description provided for @securityLabel.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get securityLabel;

  /// No description provided for @changePasswordLabel.
  ///
  /// In fr, this message translates to:
  /// **'Changer le mot de passe'**
  String get changePasswordLabel;

  /// No description provided for @settingsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsLabel;

  /// No description provided for @notificationsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notificationsLabel;

  /// No description provided for @notificationsEnabled.
  ///
  /// In fr, this message translates to:
  /// **'Activées'**
  String get notificationsEnabled;

  /// No description provided for @remindersEntryLabel.
  ///
  /// In fr, this message translates to:
  /// **'Récurrences'**
  String get remindersEntryLabel;

  /// No description provided for @rewardsEntryLabel.
  ///
  /// In fr, this message translates to:
  /// **'Récompenses'**
  String get rewardsEntryLabel;

  /// No description provided for @rewardsEntryDetail.
  ///
  /// In fr, this message translates to:
  /// **'{count} objectifs'**
  String rewardsEntryDetail(int count);

  /// No description provided for @helpLabel.
  ///
  /// In fr, this message translates to:
  /// **'Aide'**
  String get helpLabel;

  /// No description provided for @logoutButton.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get logoutButton;

  /// No description provided for @versionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Our Tribe · v{version}'**
  String versionLabel(String version);

  /// No description provided for @rewardsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Récompenses'**
  String get rewardsTitle;

  /// No description provided for @rewardsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Des objectifs à débloquer avec les points. Zéro pression, que du fun.'**
  String get rewardsSubtitle;

  /// No description provided for @weeklyPotLabel.
  ///
  /// In fr, this message translates to:
  /// **'Cagnotte de la semaine'**
  String get weeklyPotLabel;

  /// No description provided for @tribePointsLabel.
  ///
  /// In fr, this message translates to:
  /// **'points tribu'**
  String get tribePointsLabel;

  /// No description provided for @goalsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Objectifs · {count}'**
  String goalsLabel(int count);

  /// No description provided for @tribeKind.
  ///
  /// In fr, this message translates to:
  /// **'Tribu'**
  String get tribeKind;

  /// No description provided for @unlockedLabel.
  ///
  /// In fr, this message translates to:
  /// **'Débloqué !'**
  String get unlockedLabel;

  /// No description provided for @rewardCardProgress.
  ///
  /// In fr, this message translates to:
  /// **'{points} / {goal} pts · plus que {remaining}'**
  String rewardCardProgress(int points, int goal, int remaining);

  /// No description provided for @addRewardButton.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une récompense'**
  String get addRewardButton;

  /// No description provided for @doneButton.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get doneButton;

  /// No description provided for @notificationsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Choisis ce que la tribu reçoit, et quand.'**
  String get notificationsSubtitle;

  /// No description provided for @allowNotificationsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Autoriser les notifications'**
  String get allowNotificationsLabel;

  /// No description provided for @notificationsOnDetail.
  ///
  /// In fr, this message translates to:
  /// **'Activées sur cet appareil'**
  String get notificationsOnDetail;

  /// No description provided for @notificationsOffDetail.
  ///
  /// In fr, this message translates to:
  /// **'Tout est en pause'**
  String get notificationsOffDetail;

  /// No description provided for @taskRemindersSection.
  ///
  /// In fr, this message translates to:
  /// **'Rappels de tâches'**
  String get taskRemindersSection;

  /// No description provided for @tribeLifeSection.
  ///
  /// In fr, this message translates to:
  /// **'Vie de la tribu'**
  String get tribeLifeSection;

  /// No description provided for @pointsRewardsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Points & récompenses'**
  String get pointsRewardsLabel;

  /// No description provided for @pointsRewardsDetail.
  ///
  /// In fr, this message translates to:
  /// **'Quand un objectif est débloqué'**
  String get pointsRewardsDetail;

  /// No description provided for @doNotDisturbSection.
  ///
  /// In fr, this message translates to:
  /// **'Ne pas déranger'**
  String get doNotDisturbSection;

  /// No description provided for @quietNightLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nuit calme'**
  String get quietNightLabel;

  /// No description provided for @quietNightDetail.
  ///
  /// In fr, this message translates to:
  /// **'Aucune notif de 21:00 à 7:00'**
  String get quietNightDetail;

  /// No description provided for @remindersTitle.
  ///
  /// In fr, this message translates to:
  /// **'Récurrences'**
  String get remindersTitle;

  /// No description provided for @remindersSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Comment les tâches répétitives et les points se renouvellent.'**
  String get remindersSubtitle;

  /// No description provided for @recurrencesNote.
  ///
  /// In fr, this message translates to:
  /// **'Les rappels et notifications se règlent dans « Notifications ».'**
  String get recurrencesNote;

  /// No description provided for @remindTasksLabel.
  ///
  /// In fr, this message translates to:
  /// **'Rappeler les tâches'**
  String get remindTasksLabel;

  /// No description provided for @remindTasksDetail.
  ///
  /// In fr, this message translates to:
  /// **'Une notif avant l\'heure prévue'**
  String get remindTasksDetail;

  /// No description provided for @leadTimeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Prévenir avant'**
  String get leadTimeLabel;

  /// No description provided for @leadOnTime.
  ///
  /// In fr, this message translates to:
  /// **'À l\'heure'**
  String get leadOnTime;

  /// No description provided for @leadFifteenMinutes.
  ///
  /// In fr, this message translates to:
  /// **'15 min'**
  String get leadFifteenMinutes;

  /// No description provided for @leadThirtyMinutes.
  ///
  /// In fr, this message translates to:
  /// **'30 min'**
  String get leadThirtyMinutes;

  /// No description provided for @leadOneHour.
  ///
  /// In fr, this message translates to:
  /// **'1 h'**
  String get leadOneHour;

  /// No description provided for @summariesSection.
  ///
  /// In fr, this message translates to:
  /// **'Récapitulatifs'**
  String get summariesSection;

  /// No description provided for @morningSummaryLabel.
  ///
  /// In fr, this message translates to:
  /// **'Résumé du matin'**
  String get morningSummaryLabel;

  /// No description provided for @morningSummaryDetail.
  ///
  /// In fr, this message translates to:
  /// **'Les tâches du jour à 8:00'**
  String get morningSummaryDetail;

  /// No description provided for @eveningReminderLabel.
  ///
  /// In fr, this message translates to:
  /// **'Rappel du soir'**
  String get eveningReminderLabel;

  /// No description provided for @eveningReminderDetail.
  ///
  /// In fr, this message translates to:
  /// **'Ce qu\'il reste à faire à 19:00'**
  String get eveningReminderDetail;

  /// No description provided for @overdueLabel.
  ///
  /// In fr, this message translates to:
  /// **'Tâches en retard'**
  String get overdueLabel;

  /// No description provided for @overdueDetail.
  ///
  /// In fr, this message translates to:
  /// **'Prévenir si une tâche est oubliée'**
  String get overdueDetail;

  /// No description provided for @recurrencesSection.
  ///
  /// In fr, this message translates to:
  /// **'Récurrences'**
  String get recurrencesSection;

  /// No description provided for @weekStartLabel.
  ///
  /// In fr, this message translates to:
  /// **'Début de semaine'**
  String get weekStartLabel;

  /// No description provided for @weekStartDetail.
  ///
  /// In fr, this message translates to:
  /// **'Jour où les points hebdo repartent à zéro'**
  String get weekStartDetail;

  /// No description provided for @mondayLabel.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get mondayLabel;

  /// No description provided for @saturdayLabel.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get saturdayLabel;

  /// No description provided for @sundayLabel.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get sundayLabel;

  /// No description provided for @autoCarryLabel.
  ///
  /// In fr, this message translates to:
  /// **'Reporter automatiquement'**
  String get autoCarryLabel;

  /// No description provided for @autoCarryDetail.
  ///
  /// In fr, this message translates to:
  /// **'Une tâche non faite passe au lendemain'**
  String get autoCarryDetail;

  /// No description provided for @remindersNote.
  ///
  /// In fr, this message translates to:
  /// **'Chaque tâche peut aussi avoir ses propres rappels, réglés à sa création.'**
  String get remindersNote;

  /// No description provided for @saveButton.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get saveButton;

  /// No description provided for @copiedButton.
  ///
  /// In fr, this message translates to:
  /// **'Copié !'**
  String get copiedButton;

  /// No description provided for @inviteShareMessage.
  ///
  /// In fr, this message translates to:
  /// **'Rejoins notre tribu sur Our Tribe avec le code {code} !'**
  String inviteShareMessage(String code);

  /// No description provided for @pasteFromClipboard.
  ///
  /// In fr, this message translates to:
  /// **'Coller depuis le presse-papiers'**
  String get pasteFromClipboard;

  /// No description provided for @joinCodeNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune tribu ne correspond à ce code. Vérifie-le et réessaie.'**
  String get joinCodeNotFound;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In fr, this message translates to:
  /// **'Un compte existe déjà avec cet e-mail.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In fr, this message translates to:
  /// **'Cette adresse e-mail n\'est pas valide.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe est trop court (6 caractères minimum).'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In fr, this message translates to:
  /// **'E-mail ou mot de passe incorrect.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Pas de connexion. Vérifie ton réseau et réessaie.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessaie dans un instant.'**
  String get authErrorUnknown;

  /// No description provided for @notificationsDeniedHint.
  ///
  /// In fr, this message translates to:
  /// **'Les notifications sont refusées dans les réglages iOS. Active-les dans Réglages > Our Tribe > Notifications.'**
  String get notificationsDeniedHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
