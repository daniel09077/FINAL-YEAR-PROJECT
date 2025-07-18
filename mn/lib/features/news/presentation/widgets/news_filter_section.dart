import 'package:flutter/material.dart';

class NewsFilterSection extends StatelessWidget {
  final int allCount;
  final int adminCount;
  final int facultyCount;
  final int studentBodyCount;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const NewsFilterSection({
    super.key,
    required this.allCount,
    required this.adminCount,
    required this.facultyCount,
    required this.studentBodyCount,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Filter by:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildChip('All', allCount, context),
            _buildChip('Administration', adminCount, context),
            _buildChip('Faculty', facultyCount, context),
            _buildChip('Student Body', studentBodyCount, context),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(String label, int count, BuildContext context) {
    final isSelected = selectedCategory == label;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Text('($count)', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onCategorySelected(label),
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
    );
  }
}
