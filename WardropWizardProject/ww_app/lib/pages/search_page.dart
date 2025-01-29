import 'package:flutter/material.dart';
import 'package:ww_app/components/search_list_view.dart';
import 'package:ww_app/components/top_container.dart';
import 'package:ww_app/components/search_list_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleCategoryChange(int value) {
    setState(() {
      selectedValue = value;
      tabController.animateTo(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            // Üst Başlık ve Arama Çubuğu
            const TopContainer(
              title: 'Trendler',
              // searchBarTitle: 'Kendinize en uygun kombini bulunuz..',
            ),

            // Kategori Butonları
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => handleCategoryChange(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: selectedValue == 0
                            ? Colors.pink.shade100
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Kadın Trendleri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              selectedValue == 0 ? Colors.pink : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => handleCategoryChange(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: selectedValue == 1
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Erkek Trendleri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              selectedValue == 1 ? Colors.blue : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Ürünlerin TabBarView içinde Gösterimi
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  ProductDisplayWidget(isKadin: true), // Kadın Ürünleri
                  ProductDisplayWidget(isKadin: false), // Erkek Ürünleri
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
