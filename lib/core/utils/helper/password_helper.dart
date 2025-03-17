class PasswordHelper {
  static double getPasswordStrength(String password) {
    RegExp numReg = RegExp(r".*[0-9].*");
    RegExp letterReg = RegExp(r".*[A-Za-z].*");
    String pass = password.trim();
    if (pass.isEmpty) return 0;
    if (pass.length < 8) return 1/4;
    if (pass.length < 10) return 2/4;
    if (!letterReg.hasMatch(pass) || !numReg.hasMatch(pass)) {
      return 3/4;
    } else {
      return 1;
    }
  }
}