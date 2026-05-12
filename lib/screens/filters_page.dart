import 'package:flutter/material.dart';
import 'package:ecommerce_app/app_routes.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  RangeValues _priceRange = const RangeValues(30, 80);
  String _selectedColor = 'Red';
  final Set<String> _selectedSizes = {'S', 'M'};
  final Set<String> _selectedCategory = {'All'};
  String _selectedBrandSummary = 'adidas Originals, Jack & Jones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFF9F9F9),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Price range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_priceRange.start.round()}'),
              Text('\$${_priceRange.end.round()}'),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 200,
            activeColor: const Color(0xFFDB3022),
            onChanged: (values) => setState(() => _priceRange = values),
          ),
          const SizedBox(height: 14),
          const Text('Colors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            children: ['Black', 'Red', 'Beige', 'Blue', 'White']
                .map((color) => _buildColorDot(color))
                .toList(),
          ),
          const SizedBox(height: 18),
          const Text('Sizes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['XS', 'S', 'M', 'L', 'XL']
                .map((size) => _buildSelectableChip(size, _selectedSizes))
                .toList(),
          ),
          const SizedBox(height: 18),
          const Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Women', 'Men', 'Boys', 'Girls']
                .map((item) => _buildSelectableChip(item, _selectedCategory))
                .toList(),
          ),
          const SizedBox(height: 18),
          InkWell(
            onTap: _openBrandFilter,
            child: Container(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Brand', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                  Flexible(
                    child: Text(
                      _selectedBrandSummary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.black45),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black38),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 6, 16, 14),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  minimumSize: const Size.fromHeight(44),
                ),
                child: const Text('Discard', style: TextStyle(color: Colors.black87)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDB3022),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  minimumSize: const Size.fromHeight(44),
                ),
                child: const Text('Apply', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(String colorName) {
    final Map<String, Color> colors = {
      'Black': Colors.black,
      'Red': const Color(0xFFDB3022),
      'Beige': const Color(0xFFD8C5A1),
      'Blue': const Color(0xFF3F51B5),
      'White': Colors.white,
    };
    final selected = _selectedColor == colorName;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = colorName),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors[colorName],
          border: Border.all(
            color: selected ? const Color(0xFFDB3022) : Colors.black12,
            width: selected ? 2 : 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableChip(String label, Set<String> selectedSet) {
    final isSelected = selectedSet.contains(label);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFFDB3022),
      backgroundColor: Colors.white,
      side: BorderSide(color: isSelected ? const Color(0xFFDB3022) : Colors.black12),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 12),
      onSelected: (_) {
        setState(() {
          if (selectedSet == _selectedCategory) {
            selectedSet
              ..clear()
              ..add(label);
          } else if (isSelected) {
            selectedSet.remove(label);
          } else {
            selectedSet.add(label);
          }
        });
      },
    );
  }

  Future<void> _openBrandFilter() async {
    final selected = await Navigator.pushNamed(context, AppRoutes.brandFilter);
    if (selected is List && selected.isNotEmpty) {
      setState(() {
        final labels = selected.cast<String>();
        _selectedBrandSummary = labels.join(', ');
      });
    }
  }
}
