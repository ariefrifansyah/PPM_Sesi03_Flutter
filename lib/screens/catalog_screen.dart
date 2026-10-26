import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

const Color kDarkNavy = Color(0xFF131B4D);
const Color kRoyalBlue = Color(0xFF1F38C5);
const Color kSoftBlue = Color(0xFF7892FF);
const Color kPaleBlue = Color(0xFFADD5FF);

class BookCatalogScreen extends StatefulWidget {
  const BookCatalogScreen({super.key});

  @override
  State<BookCatalogScreen> createState() => _BookCatalogScreenState();
}

class _BookCatalogScreenState extends State<BookCatalogScreen> {
  int selectedCategoryIndex = 0;
  String searchQuery = '';
  final List<String> categories = ['Semua', 'Pemrograman', 'Kecerdasan Buatan', 'Jaringan', 'Desain'];

  final List<Book> featuredBooks = [
    Book(id: 'f1', title: 'Deep Learning with Python', author: 'Francois Chollet', price: 250000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9781617294433-L.jpg', category: 'Kecerdasan Buatan'),
    Book(id: 'f2', title: 'Flutter Advanced UI', author: 'Nugraha', price: 185000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9781484255575-L.jpg', category: 'Pemrograman'),
    Book(id: 'f3', title: 'Mastering OpenCV', author: 'M. Arief', price: 210000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780132350884-L.jpg', category: 'Kecerdasan Buatan'),
    Book(id: 'f4', title: 'Network Security', author: 'Yulhan W.', price: 190000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780201633610-L.jpg', category: 'Jaringan'),
  ];

  final List<Book> allBooks = [
    Book(id: 'b1', title: 'Flutter for Beginners', author: 'John Doe', price: 150000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9781484255575-M.jpg', category: 'Pemrograman'),
    Book(id: 'b2', title: 'Machine Learning Models', author: 'Jane Smith', price: 200000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9781617294433-M.jpg', category: 'Kecerdasan Buatan'),
    Book(id: 'b3', title: 'Cisco Packet Tracer Guide', author: 'Yulhan W.', price: 120000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780201633610-L.jpg', category: 'Jaringan'),
    Book(id: 'b4', title: 'Clean Architecture', author: 'Robert C. Martin', price: 175000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780134494166-L.jpg', category: 'Pemrograman'),
    Book(id: 'b5', title: 'Data Science with Pandas', author: 'Alex Tech', price: 145000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9781491957660-L.jpg', category: 'Kecerdasan Buatan'),
    Book(id: 'b6', title: 'Linux System Admin', author: 'Tux Master', price: 160000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780131480049-L.jpg', category: 'Jaringan'),
    Book(id: 'b7', title: 'UI/UX Masterclass', author: 'Sarah Design', price: 195000, imageUrl: 'https://covers.openlibrary.org/b/isbn/9780321965516-L.jpg', category: 'Desain'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    List<Book> filteredBooks = allBooks.where((book) {
      bool matchCategory = selectedCategoryIndex == 0 || book.category == categories[selectedCategoryIndex];
      bool matchSearch = book.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                         book.author.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: isDark ? kDarkNavy : Colors.white,
        title: Text(
          'NusaBookstore',
          style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.white : kDarkNavy, letterSpacing: -0.5),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: isDark ? kPaleBlue : kDarkNavy),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: isDark ? Colors.white : kDarkNavy),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.totalItems == 0) return const SizedBox.shrink();
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                      child: Text(
                        '${cart.totalItems}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari buku pemrograman, AI, atau modul...',
                  hintStyle: TextStyle(color: isDark ? Colors.grey.shade400 : kRoyalBlue.withOpacity(0.6)),
                  prefixIcon: Icon(Icons.search, color: isDark ? kPaleBlue : kRoyalBlue),
                  filled: true,
                  fillColor: isDark ? kDarkNavy.withOpacity(0.5) : kPaleBlue.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? kRoyalBlue : (isDark ? kDarkNavy : Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? kRoyalBlue : (isDark ? kSoftBlue.withOpacity(0.3) : kPaleBlue),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : (isDark ? kPaleBlue : kDarkNavy),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            if (searchQuery.isEmpty && selectedCategoryIndex == 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rekomendasi Utama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : kDarkNavy)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecommendedScreen(featuredBooks: featuredBooks),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('Lihat Semua', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kRoyalBlue)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredBooks.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final book = featuredBooks[index];
                    return Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: isDark ? kDarkNavy : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: kRoyalBlue.withOpacity(isDark ? 0.1 : 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                book.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.book, size: 50, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(currencyFormatter.format(book.price), style: const TextStyle(color: kRoyalBlue, fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                selectedCategoryIndex == 0 ? 'Semua Buku' : 'Buku ${categories[selectedCategoryIndex]}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : kDarkNavy),
              ),
            ),
            const SizedBox(height: 16),
            filteredBooks.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text('Buku tidak ditemukan.', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: isDark ? kDarkNavy : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? kSoftBlue.withOpacity(0.2) : kPaleBlue.withOpacity(0.5)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.network(
                                  book.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.book, size: 50, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(book.author, style: TextStyle(color: Colors.grey.shade500, fontSize: 11), maxLines: 1),
                                  const SizedBox(height: 8),
                                  Text(currencyFormatter.format(book.price), style: const TextStyle(color: kRoyalBlue, fontWeight: FontWeight.w900, fontSize: 14)),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kRoyalBlue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                      ),
                                      onPressed: () {
                                        context.read<CartProvider>().addItem(book);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${book.title} masuk keranjang!'),
                                            backgroundColor: kDarkNavy,
                                            behavior: SnackBarBehavior.floating,
                                            duration: const Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      child: const Text('Tambah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class RecommendedScreen extends StatelessWidget {
  final List<Book> featuredBooks;

  const RecommendedScreen({super.key, required this.featuredBooks});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: isDark ? kDarkNavy : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : kDarkNavy),
        title: Text(
          'Rekomendasi Utama',
          style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : kDarkNavy),
        ),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.58,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: featuredBooks.length,
        itemBuilder: (context, index) {
          final book = featuredBooks[index];
          return Container(
            decoration: BoxDecoration(
              color: isDark ? kDarkNavy : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? kSoftBlue.withOpacity(0.2) : kPaleBlue.withOpacity(0.5)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      book.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.book, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(book.author, style: TextStyle(color: Colors.grey.shade500, fontSize: 11), maxLines: 1),
                      const SizedBox(height: 8),
                      Text(currencyFormatter.format(book.price), style: const TextStyle(color: kRoyalBlue, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kRoyalBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () {
                            context.read<CartProvider>().addItem(book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${book.title} masuk keranjang!'),
                                backgroundColor: kDarkNavy,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text('Tambah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}