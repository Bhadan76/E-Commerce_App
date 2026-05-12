import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _isGridView = false;
  String _selectedCategory = 'Summer';

  final List<Map<String, dynamic>> _mockFavorites = [
    {
      'image':
          'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=300',
      'brand': 'LIME',
      'title': 'Shirt',
      'color': 'Blue',
      'size': 'L',
      'price': 32,
      'rating': 5,
      'reviews': 10,
      'isSoldOut': false,
      'discount': null,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1727516299214-c4d54704b045?q=80&w=736&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'brand': 'Zara',
      'title': 'Jacket',
      'color': 'Black',
      'size': 'S',
      'price': 46,
      'rating': 0,
      'reviews': 0,
      'isSoldOut': false,
      'discount': '-20%',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300',
      'brand': 'Oliver',
      'title': 'Shirt',
      'color': 'Gray',
      'size': 'L',
      'price': 52,
      'rating': 4,
      'reviews': 3,
      'isSoldOut': true,
      'discount': null,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=300',
      'brand': 'Oliver',
      'title': 'T-Shirt',
      'color': 'Black',
      'size': 'S',
      'price': 39,
      'oldPrice': 55,
      'rating': 5,
      'reviews': 5,
      'isSoldOut': false,
      'discount': '-30%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF9F9F9),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip('Summer'),
                        _buildCategoryChip('T-Shirts'),
                        _buildCategoryChip('Shirts'),
                        _buildCategoryChip('Pants'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.filter_list, size: 24),
                          const SizedBox(width: 8),
                          const Text('Filters', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.swap_vert, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Price: lowest to high',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isGridView = !_isGridView;
                          });
                        },
                        icon: Icon(
                          _isGridView ? Icons.view_list : Icons.view_module,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _isGridView
                ? SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.55,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildGridItem(_mockFavorites[index]),
                      childCount: _mockFavorites.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildListItem(_mockFavorites[index]),
                      childCount: _mockFavorites.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars(int rating, int reviews) {
    return Row(
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: 14,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviews)',
          style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget _buildListItem(Map<String, dynamic> item) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.network(
                  item['image'],
                  width: 104,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['brand'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Color: ',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            item['color'],
                            style: const TextStyle(fontSize: 11),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Size: ',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            item['size'],
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${item['price']}\$',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (item['oldPrice'] != null) ...[
                                const SizedBox(width: 4),
                                Text(
                                  '${item['oldPrice']}\$',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          _buildRatingStars(item['rating'], item['reviews']),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (item['isSoldOut'])
          Positioned(
            bottom: 6,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white.withOpacity(0.9),
              child: const Text(
                'Sorry, this item is currently sold out',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ),
          ),
        if (!item['isSoldOut'])
          Positioned(
            bottom: 4,
            right: -8,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFDB3022),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33DB3022),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        if (item['discount'] != null)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDB3022),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item['discount'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['image'],
                    height: 184,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                if (item['discount'] != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB3022),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item['discount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRatingStars(item['rating'], item['reviews']),
            const SizedBox(height: 4),
            Text(
              item['brand'],
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item['title'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Color: ',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Text(item['color'], style: const TextStyle(fontSize: 11)),
                const SizedBox(width: 16),
                Text(
                  'Size: ',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Text(item['size'], style: const TextStyle(fontSize: 11)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${item['price']}\$',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item['oldPrice'] != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    '${item['oldPrice']}\$',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
            if (item['isSoldOut'])
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Sorry, this item is currently sold out',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
        if (!item['isSoldOut'])
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFDB3022),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33DB3022),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
      ],
    );
  }
}
