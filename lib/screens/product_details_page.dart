import 'package:ecommerce_app/All_Widget/ProductCard_widget.dart';
import 'package:ecommerce_app/app_routes.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    final name = widget.product['name'] as String? ?? 'Short dress';
    final brand = widget.product['brand'] as String? ?? 'H&M';
    final image = widget.product['imageUrl'] as String? ?? '';
    final price = widget.product['price'] as int? ?? 19;
    final rating = widget.product['rating'] as int? ?? 4;

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
        title: Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            image,
            height: 320,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: _selectorChip('Size', _selectedSize, _openSelectSizeSheet)),
                    const SizedBox(width: 8),
                    Expanded(child: _selectorChip('Color', 'Black', () {})),
                    const SizedBox(width: 8),
                    const Icon(Icons.favorite_border, color: Colors.black45),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        brand,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(name, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.ratingReviews,
                  ),
                  child: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '(10)',
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDB3022),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text('ADD TO CART', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Shipping info'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Support'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('You can also like this'),
                  subtitle: const Text('12 items'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 278,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ProductCard(
                        image: 'https://69fe251d8e04e8c956a64892.imgix.net/plant.jpg?auto=format&fit=fill&w=384',
                        brand: 'Plant',
                        title: 'Plant',
                        price: '15\$',
                        rating: 5,
                        isNew: true,
                      ),
                      ProductCard(
                        image: 'https://69fe251d8e04e8c956a64892.imgix.net/sneakers.jpg?auto=format&fit=fill&w=384',
                        brand: 'Nike',
                        title: 'Sneakers',
                        price: '22\$',
                        rating: 4,
                        isNew: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectorChip(String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text('$label: $value'),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }

  Future<void> _openSelectSizeSheet() async {
    final size = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ProductSelectSizeSheet(currentSize: _selectedSize),
    );
    if (size != null) {
      setState(() => _selectedSize = size);
    }
  }
}

class _ProductSelectSizeSheet extends StatefulWidget {
  final String currentSize;

  const _ProductSelectSizeSheet({required this.currentSize});

  @override
  State<_ProductSelectSizeSheet> createState() => _ProductSelectSizeSheetState();
}

class _ProductSelectSizeSheetState extends State<_ProductSelectSizeSheet> {
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.currentSize;
  }

  @override
  Widget build(BuildContext context) {
    const sizes = ['XS', 'S', 'M', 'L', 'XL'];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select size',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: sizes.map((size) {
                final selected = _selectedSize == size;
                return ChoiceChip(
                  label: Text(size),
                  selected: selected,
                  selectedColor: const Color(0xFFDB3022),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: selected ? const Color(0xFFDB3022) : Colors.black12),
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                  onSelected: (_) => setState(() => _selectedSize = size),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selectedSize),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDB3022),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('APPLY', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
