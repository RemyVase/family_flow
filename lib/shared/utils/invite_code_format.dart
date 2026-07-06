/// Displays a 6-character invite code as "ABC-DEF"; anything else is
/// returned as-is (e.g. while the code has not arrived yet).
String formatInviteCode(String code) =>
    code.length == 6 ? '${code.substring(0, 3)}-${code.substring(3)}' : code;
