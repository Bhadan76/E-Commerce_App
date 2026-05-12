import 'package:flutter/material.dart';

class BrandFilterPage extends StatefulWidget {
  const BrandFilterPage({super.key});

  @override
  State<BrandFilterPage> createState() => _BrandFilterPageState();
}

class _BrandFilterPageState extends State<BrandFilterPage> {
  String _query = '';
  final Set<String> _selectedBrands = {'adidas Originals', 'Jack & Jones', 's.Oliver'};

  final List<String> _brands = const [
    'adidas',
    'adidas Originals',
    'Blend',
    'Boutique Moschino',
    'Champion',
    'Diesel',
    'Jack & Jones',
    'Naf Naf',
    'Red Valentino',
    's.Oliver',
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _brands
        .where((brand) => brand.toLowerCase().contains(_query.toLowerCase()))
        .toList();

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
          'Brand',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, index) {
                final brand = filtered[index];
                final selected = _selectedBrands.contains(brand);
                return ListTile(
                  title: Text(
                    brand,
                    style: TextStyle(
                      color: selected ? const Color(0xFFDB3022) : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Checkbox(
                    value: selected,
                    activeColor: const Color(0xFFDB3022),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (_) => setState(() {
                      if (selected) {
                        _selectedBrands.remove(brand);
                      } else {
                        _selectedBrands.add(brand);
                      }
                    }),
                  ),
                  onTap: () => setState(() {
                    if (selected) {
                      _selectedBrands.remove(brand);
                    } else {
                      _selectedBrands.add(brand);
                    }
                  }),
                );
              },
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
                onPressed: () => Navigator.pop(context, _selectedBrands.toList()),
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
}
