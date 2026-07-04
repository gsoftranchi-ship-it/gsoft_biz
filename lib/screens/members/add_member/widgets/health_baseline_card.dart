import 'package:flutter/material.dart';

import '../controllers/member_form_controller.dart';

class HealthBaselineCard extends StatelessWidget {
  const HealthBaselineCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    VoidCallback? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      onChanged: (_) {
        if (onChanged != null) {
          onChanged();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Health Baseline",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _numberField(
                    controller: controller.heightController,
                    label: "Height (cm)",
                    icon: Icons.height,
                    onChanged: controller.calculateBMI,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _numberField(
                    controller: controller.weightController,
                    label: "Weight (kg)",
                    icon: Icons.monitor_weight,
                    onChanged: controller.calculateBMI,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("BMI"),
                      trailing: Text(
                        controller.bmi.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text("Category"),
                      trailing: Text(controller.bmiCategory),
                    ),

                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text("Remark"),
                      subtitle: Text(controller.bmiRemark),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _numberField(
                    controller: controller.chestController,
                    label: "Chest",
                    icon: Icons.straighten,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _numberField(
                    controller: controller.waistController,
                    label: "Waist",
                    icon: Icons.straighten,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: _numberField(
                    controller: controller.hipController,
                    label: "Hip",
                    icon: Icons.straighten,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _numberField(
                    controller: controller.calfController,
                    label: "Calf",
                    icon: Icons.straighten,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: _numberField(
                    controller: controller.leftArmController,
                    label: "Left Arm",
                    icon: Icons.fitness_center,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _numberField(
                    controller: controller.rightArmController,
                    label: "Right Arm",
                    icon: Icons.fitness_center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: _numberField(
                    controller: controller.leftThighController,
                    label: "Left Thigh",
                    icon: Icons.accessibility_new,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _numberField(
                    controller: controller.rightThighController,
                    label: "Right Thigh",
                    icon: Icons.accessibility_new,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _numberField(
              controller: controller.bloodPressureController,
              label: "Blood Pressure",
              icon: Icons.monitor_heart,
            ),

            const SizedBox(height: 16),

            _numberField(
              controller: controller.sugarController,
              label: "Sugar Level",
              icon: Icons.bloodtype,
            ),

            const SizedBox(height: 16),

            _numberField(
              controller: controller.heartRateController,
              label: "Heart Rate",
              icon: Icons.favorite_border,
            ),
          ],
        ),
      ),
    );
  }
}