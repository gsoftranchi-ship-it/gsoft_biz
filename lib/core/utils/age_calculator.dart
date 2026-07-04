class AgeCalculator {
  AgeCalculator._();

  /// Calculate age from Date of Birth
  static int calculateAge(DateTime dateOfBirth) {
    final today = DateTime.now();

    int age = today.year - dateOfBirth.year;

    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month &&
            today.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  /// Estimate Date of Birth from Age
  ///
  /// Returns January 1st of the estimated birth year.
  static DateTime estimateDateOfBirth(int age) {
    final today = DateTime.now();

    return DateTime(
      today.year - age,
      1,
      1,
    );
  }

  /// Synchronize DOB -> Age
  static int ageFromDob(DateTime? dob) {
    if (dob == null) {
      return 0;
    }

    return calculateAge(dob);
  }

  /// Synchronize Age -> DOB
  static DateTime? dobFromAge(int? age) {
    if (age == null || age <= 0) {
      return null;
    }

    return estimateDateOfBirth(age);
  }

  /// Format Age
  static String formatAge(int age) {
    if (age <= 0) {
      return '';
    }

    return '$age Years';
  }

  /// Validate DOB
  static bool isValidDob(DateTime? dob) {
    if (dob == null) {
      return false;
    }

    final today = DateTime.now();

    return dob.isBefore(today);
  }

  /// Validate Age
  static bool isValidAge(int age) {
    return age > 0 && age <= 120;
  }
}