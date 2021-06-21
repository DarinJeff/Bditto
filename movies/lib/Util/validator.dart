class Validator {
  static bool validateName({required String name}) {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (email.isEmpty) {
      return false;
    } else if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validatePassword({required String password}) {
    if (password.isEmpty) {
      return false;
    } else if (password.length < 6) {
      return false;
    }
    return true;
  }
}
