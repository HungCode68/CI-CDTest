import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _horizontalHeight = 270;

  final List<Map<String, dynamic>> horizontalHotels = [
    {
      'name': 'Silver Hotel & SPA',
      'location': 'Green street, Central district',
      'price': '\$120',
      'image': 'https://via.placeholder.com/400x250',
      'rating': 4.5,
      'reviews': '36 Reviews'
    },
    {
      'name': 'Bring Hotel',
      'location': 'Main street',
      'price': '\$90',
      'image': 'https://via.placeholder.com/400x250',
      'rating': 4.0,
      'reviews': '24 Reviews'
    },
  ];

  final List<Map<String, dynamic>> verticalHotels = [
    {
      'name': 'Villa biển Phú Quốc',
      'location': 'Phú Quốc, Việt Nam',
      'price': '2.000.000 VNĐ / đêm',
      'image': 'https://www.coolhome.com.vn/wp-content/uploads/2024/03/thue-villa-phu-quoc.jpg',
    },
    {
      'name': 'Khách sạn Hà Nội Center',
      'location': 'Hà Nội, Việt Nam',
      'price': '1.200.000 VNĐ / đêm',
      'image': 'https://booking.muongthanh.com/images/hotels/rooms/original/superior_twin_1711697296.jpg',
    },
    {
      'name': 'Resort Đà Lạt Mộng Mơ',
      'location': 'Đà Lạt, Việt Nam',
      'price': '1.800.000 VNĐ / đêm',
      'image': 'https://bazantravel.com/cdn/medias/uploads/31/31025-resort-doi-mong-mo-da-lat.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      setState(() {
        _horizontalHeight = (270 - offset).clamp(60, 270);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Khách sạn & Villa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Thanh tìm kiếm
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm khách sạn, villa...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),

          // Danh sách ngang có hiệu ứng thu nhỏ khi cuộn
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _horizontalHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: horizontalHotels.length,
                itemBuilder: (context, index) {
                  final hotel = horizontalHotels[index];
                  return Container(
                    width: 220,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                              child: Image.network(
                                hotel['image'],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  hotel['price'],
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hotel['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(hotel['location'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text('${hotel['rating']}', style: const TextStyle(fontSize: 12)),
                                  const SizedBox(width: 8),
                                  Text(hotel['reviews'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  const Spacer(),
                                  const Icon(Icons.bookmark_border, color: Colors.grey)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Danh sách dọc
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: verticalHotels.length,
                  (context, index) {
                final hotel = verticalHotels[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Chọn: ${hotel['name']}')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(hotel['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hotel['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(hotel['location'], style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 8),
                              Text(hotel['price'], style: const TextStyle(color: Colors.blue)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Đặt chỗ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
