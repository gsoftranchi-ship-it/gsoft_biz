class BMICalculator {
  BMICalculator._();

  /// Calculates BMI using:
  /// Weight (kg) / Height² (m)
  static double calculate({
    required double heightCm,
    required double weightKg,
  }) {
    if (heightCm <= 0 || weightKg <= 0) {
      return 0;
    }

    final heightMeter = heightCm / 100;

    final bmi =
        weightKg / (heightMeter * heightMeter);

    return double.parse(
      bmi.toStringAsFixed(1),
    );
  }

  /// Returns BMI Category
  static String category(double bmi) {
    if (bmi <= 0) {
      return '';
    }

    if (bmi < 18.5) {
      return 'Underweight';
    }

    if (bmi < 25) {
      return 'Normal';
    }

    if (bmi < 30) {
      return 'Overweight';
    }

    if (bmi < 35) {
      return 'Obese Class I';
    }

    if (bmi < 40) {
      return 'Obese Class II';
    }

    return 'Obese Class III';
  }

  /// Health Remark
  static String remark(double bmi) {
    if (bmi <= 0) {
      return '';
    }

    if (bmi < 18.5) {
      return 'Increase healthy calorie intake.';
    }

    if (bmi < 25) {
      return 'Healthy weight. Keep maintaining it.';
    }

    if (bmi < 30) {
      return 'Focus on fat loss and regular exercise.';
    }

    if (bmi < 35) {
      return 'Medical guidance is recommended.';
    }

    if (bmi < 40) {
      return 'High health risk. Immediate lifestyle changes advised.';
    }

    return 'Critical obesity. Consult a healthcare professional.';
  }

  /// Ideal Weight Range (WHO Approximation)
  static String idealWeightRange(double heightCm) {
    if (heightCm <= 0) {
      return '';
    }

    final meter = heightCm / 100;

    final min =
        18.5 * meter * meter;

    final max =
        24.9 * meter * meter;

    return '${min.toStringAsFixed(1)} - ${max.toStringAsFixed(1)} kg';
  }

  /// Weight Difference from Ideal Maximum
  static double weightToLose({
    required double heightCm,
    required double currentWeight,
  }) {
    if (heightCm <= 0 || currentWeight <= 0) {
      return 0;
    }

    final meter = heightCm / 100;

    final idealMax =
        24.9 * meter * meter;

    final difference =
        currentWeight - idealMax;

    if (difference <= 0) {
      return 0;
    }

    return double.parse(
      difference.toStringAsFixed(1),
    );
  }

  /// Weight Needed to Reach Minimum Healthy BMI
  static double weightToGain({
    required double heightCm,
    required double currentWeight,
  }) {
    if (heightCm <= 0 || currentWeight <= 0) {
      return 0;
    }

    final meter = heightCm / 100;

    final idealMin =
        18.5 * meter * meter;

    final difference =
        idealMin - currentWeight;

    if (difference <= 0) {
      return 0;
    }

    return double.parse(
      difference.toStringAsFixed(1),
    );
  }
}