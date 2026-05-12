import 'package:flutter/material.dart';

import '../All_Widget/write_review_bottom_sheet.dart';

class RatingReviewsWithPhotoPage extends StatelessWidget {
  const RatingReviewsWithPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF9F9F9),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '8 reviews',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                      if (value == false) {
                        Navigator.pushReplacementNamed(context, '/rating-reviews');
                      }
                    },
                    activeColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Text(
                    'With photo',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _ReviewCardWithPhotos(
            name: 'Kim Shine',
            date: 'August 13, 2019',
            rating: 5,
            review:
                "I loved this dress so much as soon as I tried it on I knew I had to buy it in another color. I am 5'3 about 155lbs and I carry all my weight in my upper body. When I put it on I felt like it thinned me out and I got so many compliments.",
            photos: [

              'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=200',
              'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?w=200',
            ],
            avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
          ),
          const _ReviewCardWithPhotos(
            name: 'Matilda Brown',
            date: 'August 14, 2019',
            rating: 5,
            review:
                "I loved this dress so much as soon as I tried it on I knew I had to buy it in another color. I am 5'3 about 155lbs and I carry all my weight in my upper body. When I put it on I felt like it thinned me out and I got so many compliments.",
            photos: [
              'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=200',
              
            ],
            avatarUrl: 'https://randomuser.me/api/portraits/women/90.jpg',
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          WriteReviewBottomSheet.show(context);
        },
        backgroundColor: const Color(0xFFDB3022),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        icon: const Icon(Icons.edit, color: Colors.white, size: 18),
        label: const Text(
          'Write a review',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ReviewCardWithPhotos extends StatelessWidget {
  final String name;
  final String date;
  final int rating;
  final String review;
  final List<String> photos;
  final String avatarUrl;

  const _ReviewCardWithPhotos({
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
    required this.photos,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          padding: const EdgeInsets.all(24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                review,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              if (photos.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 104,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          photos[index],
                          width: 104,
                          height: 104,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Helpful',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.thumb_up,
                    size: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ),
      ],
    );
  }
}
