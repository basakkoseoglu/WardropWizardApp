import 'package:flutter/material.dart';
import 'package:ww_app/auth/auth_service.dart';
import 'package:ww_app/components/bottom_nav_bar.dart';
import 'package:ww_app/pages/favorite_page.dart';
import 'package:ww_app/pages/looks_page.dart';
import 'package:ww_app/pages/search_page.dart';
import 'package:ww_app/pages/wardrobe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Çıkış yapma fonksiyonu
  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  // Alt navigasyon çubuğu için seçili index
  int _selectedIndex = 0;

  // Alt menüdeki sekmeye tıklanınca seçilen index'i güncelleyen fonksiyon
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Sayfaların listesi (her bir sayfa alt menüdeki seçime bağlı olarak gösterilecek)
  final List<Widget> _pages = [
    const LooksPage(), // LooksPage
    const WardrobePage(), // WardrobePage
    const SearchPage(), // SearchPage
    const FavoritePage(), // FavoritePage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0, // Gölgeyi kaldırır
        centerTitle: true, // Logoyu merkeze alır
        title: Image.asset(
          'assets/logoo.png', // Logo dosyasının yolu
          height: 100, // Logo boyutu
        ),
        actions: [
          IconButton(
            onPressed: logout, // Çıkış yapma fonksiyonu
            icon: Icon(Icons.logout),
            iconSize: 32.0,
            color:
                Theme.of(context).colorScheme.primary, // Tema rengini alıyoruz
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) =>
            navigateBottomBar(index), // Alt navigasyon sekmesi değiştiğinde
      ),
      body: _pages[_selectedIndex], // Seçilen sayfa gösteriliyor
    );
  }
}
