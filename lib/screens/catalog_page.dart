import 'package:ecommerce_app/app_routes.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  final String title;

  const CatalogPage({
    super.key,
    required this.title,
  });

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<String> _chips = const ['T-shirts', 'Crop tops', 'Sleeveless', 'Shirts'];
  String _selectedSort = 'Popular';

  final List<_CatalogItem> _items = const [
    _CatalogItem(
      brand: 'LIME',
      name: 'Shirt',
      price: 32,
      oldPrice: 40,
      rating: 5,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=1200&auto=format&fit=crop',
      isNew: true,
    ),
    _CatalogItem(
      brand: 'Mango',
      name: 'Longsleeve Violeta',
      price: 46,
      oldPrice: 52,
      rating: 4,
      imageUrl: 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?q=80&w=1200&auto=format&fit=crop',
      isNew: false,
    ),
    _CatalogItem(
      brand: 'Olivier',
      name: 'T-shirt',
      price: 28,
      oldPrice: 35,
      rating: 5,
      imageUrl: 'https://images.unsplash.com/photo-1484515991647-c5760fcecfc7?q=80&w=1200&auto=format&fit=crop',
      isNew: false,
    ),
  ];

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
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, index) => Chip(
                label: Text(_chips[index]),
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                backgroundColor: Colors.black,
                side: BorderSide.none,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _chips.length,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.filters),
                    child: const Row(
                      children: [
                        Icon(Icons.filter_list, size: 18),
                        SizedBox(width: 6),
                        Text('Filters', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: _openSortSheet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.swap_vert, size: 18),
                        const SizedBox(width: 6),
                        Text('Price: $_selectedSort', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.view_agenda_outlined, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (_, index) => _CatalogTile(
                item: _items[index],
                onTap: () => _openProductDetails(_items[index]),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemCount: _items.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openSortSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _SortBottomSheet(currentSort: _selectedSort),
    );
    if (selected != null) {
      setState(() => _selectedSort = selected);
    }
  }

  void _openProductDetails(_CatalogItem item) {
    Navigator.pushNamed(
      context,
      AppRoutes.productDetails,
      arguments: {
        'name': item.name,
        'brand': item.brand,
        'price': item.price,
        'oldPrice': item.oldPrice,
        'rating': item.rating,
        'imageUrl': item.imageUrl,
      },
    );
  }
}

class _SortBottomSheet extends StatelessWidget {
  final String currentSort;

  const _SortBottomSheet({required this.currentSort});

  @override
  Widget build(BuildContext context) {
    const sorts = ['Popular', 'Newest', 'Customer review', 'Price: lowest to high', 'Price: highest to low'];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Sort by', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            ...sorts.map(
              (sort) {
                final isSelected = sort == currentSort;
                return ListTile(
                  tileColor: isSelected ? const Color(0xFFDB3022) : Colors.transparent,
                  title: Text(
                    sort,
                    style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 14),
                  ),
                  onTap: () => Navigator.pop(context, sort),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CatalogTile extends StatelessWidget {
  final _CatalogItem item;
  final VoidCallback onTap;

  const _CatalogTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 116,
        child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              width: 104,
              height: 116,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.brand, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                const SizedBox(height: 4),
                Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < item.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('\$${item.oldPrice}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black38)),
                    const SizedBox(width: 8),
                    Text('\$${item.price}', style: const TextStyle(color: Color(0xFFDB3022), fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: Colors.black38),
        ],
      ),
      ),
    );
  }
}

class _CatalogItem {
  final String brand;
  final String name;
  final int price;
  final int oldPrice;
  final int rating;
  final String imageUrl;
  final bool isNew;

  const _CatalogItem({
    required this.brand,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.imageUrl,
    required this.isNew,
  });
}
