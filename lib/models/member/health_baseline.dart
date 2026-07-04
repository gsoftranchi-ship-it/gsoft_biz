class HealthBaseline {
  final double heightCm;
  final double weightKg;

  final double bmi;
  final String bmiCategory;

  final double chest;
  final double waist;
  final double hip;

  final double leftArm;
  final double rightArm;

  final double leftThigh;
  final double rightThigh;

  final double calf;

  final String bloodPressure;
  final String sugar;
  final String heartRate;

  const HealthBaseline({
    required this.heightCm,
    required this.weightKg,
    required this.bmi,
    required this.bmiCategory,
    required this.chest,
    required this.waist,
    required this.hip,
    required this.leftArm,
    required this.rightArm,
    required this.leftThigh,
    required this.rightThigh,
    required this.calf,
    required this.bloodPressure,
    required this.sugar,
    required this.heartRate,
  });

  factory HealthBaseline.fromMap(Map<String, dynamic> map) {
    return HealthBaseline(
      heightCm: (map['heightCm'] ?? 0).toDouble(),
      weightKg: (map['weightKg'] ?? 0).toDouble(),
      bmi: (map['bmi'] ?? 0).toDouble(),
      bmiCategory: map['bmiCategory'] ?? '',
      chest: (map['chest'] ?? 0).toDouble(),
      waist: (map['waist'] ?? 0).toDouble(),
      hip: (map['hip'] ?? 0).toDouble(),
      leftArm: (map['leftArm'] ?? 0).toDouble(),
      rightArm: (map['rightArm'] ?? 0).toDouble(),
      leftThigh: (map['leftThigh'] ?? 0).toDouble(),
      rightThigh: (map['rightThigh'] ?? 0).toDouble(),
      calf: (map['calf'] ?? 0).toDouble(),
      bloodPressure: map['bloodPressure'] ?? '',
      sugar: map['sugar'] ?? '',
      heartRate: map['heartRate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'heightCm': heightCm,
      'weightKg': weightKg,
      'bmi': bmi,
      'bmiCategory': bmiCategory,
      'chest': chest,
      'waist': waist,
      'hip': hip,
      'leftArm': leftArm,
      'rightArm': rightArm,
      'leftThigh': leftThigh,
      'rightThigh': rightThigh,
      'calf': calf,
      'bloodPressure': bloodPressure,
      'sugar': sugar,
      'heartRate': heartRate,
    };
  }

  HealthBaseline copyWith({
    double? heightCm,
    double? weightKg,
    double? bmi,
    String? bmiCategory,
    double? chest,
    double? waist,
    double? hip,
    double? leftArm,
    double? rightArm,
    double? leftThigh,
    double? rightThigh,
    double? calf,
    String? bloodPressure,
    String? sugar,
    String? heartRate,
  }) {
    return HealthBaseline(
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      bmi: bmi ?? this.bmi,
      bmiCategory: bmiCategory ?? this.bmiCategory,
      chest: chest ?? this.chest,
      waist: waist ?? this.waist,
      hip: hip ?? this.hip,
      leftArm: leftArm ?? this.leftArm,
      rightArm: rightArm ?? this.rightArm,
      leftThigh: leftThigh ?? this.leftThigh,
      rightThigh: rightThigh ?? this.rightThigh,
      calf: calf ?? this.calf,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      sugar: sugar ?? this.sugar,
      heartRate: heartRate ?? this.heartRate,
    );
  }
}