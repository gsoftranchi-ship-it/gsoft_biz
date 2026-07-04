import 'package:flutter/material.dart';

class DailyMealPlanCard extends StatelessWidget {
  const DailyMealPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Meal Plan",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _meal("Breakfast", "Oats + Milk + Banana"),
            _meal("Lunch", "Rice + Dal + Chicken"),
            _meal("Evening", "Protein Shake"),
            _meal("Dinner", "Chapati + Paneer + Salad"),
          ],
        ),
      ),
    );
  }

  Widget _meal(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.restaurant),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}