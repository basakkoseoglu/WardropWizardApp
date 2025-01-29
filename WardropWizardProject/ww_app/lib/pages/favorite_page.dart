import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Kıyafet Yıkama ve Bakım Rehberi',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCategoryCard(
              context,
              title: "Pamuklu",
              icon: Icons.local_laundry_service,
              details: "40°C'de makinede yıkanabilir.",
            ),
            _buildCategoryCard(
              context,
              title: "İpek",
              icon: Icons.local_laundry_service,
              details: "Elde yıkama programını tercih edin.",
            ),
            _buildCategoryCard(
              context,
              title: "Sentetik",
              icon: Icons.local_laundry_service,
              details: "30°C, hassas programda yıkayın.",
            ),
            _buildCategoryCard(
              context,
              title: "Koyu Renkler",
              icon: Icons.local_laundry_service,
              details: "30°C, uygun deterjanla yıkayın.",
            ),
            _buildCategoryCard(
              context,
              title: "Beyaz Renkler",
              icon: Icons.local_laundry_service,
              details: "60°C, uygun deterjanla yıkayın.",
            ),
            _buildCategoryCard(
              context,
              title: "Yünlü",
              icon: Icons.local_laundry_service,
              details: "30°C'de makinede yıkanabilir.",
            ),
            _buildCategoryCard(
              context,
              title: "Elde Yıkama",
              icon: Icons.local_laundry_service,
              details: "40°C'de makinede yıkanabilir.",
            ),
            _buildCategoryCard(
              context,
              title: "Gömlek",
              icon: Icons.checkroom,
              details: "Hassas program, düşük sıcaklık (30-40°C).",
            ),
            _buildCategoryCard(
              context,
              title: "Kot Pantolon",
              icon: Icons.checkroom,
              details: "Koyu renkler programında, düşük sıcaklık.",
            ),
            _buildCategoryCard(
              context,
              title: "Saten Kıyafetler",
              icon: Icons.checkroom,
              details: "Hassas program, düşük sıcaklık (30-40°C).",
            ),
            _buildCategoryCard(
              context,
              title: "Mont",
              icon: Icons.checkroom,
              details: "Kuru temizleme önerilir.",
            ),
            _buildCategoryCard(
              context,
              title: "Keten Kıyafetler",
              icon: Icons.checkroom,
              details: "Sentetik programda yıkaması önerilir.",
            ),
            _buildCategoryCard(
              context,
              title: "Özel Gün Elbiseleri",
              icon: Icons.checkroom,
              details: "Kuru temizleme önerilir.",
            ),
            _buildCategoryCard(
              context,
              title: "Ayakkabı",
              icon: Icons.checkroom,
              details: "Orta ısıda yıkanması önerilir.",
            ),
            _buildPufNoktalariCard(
              context,
              title: "Deterjan Seçimi",
              icon: Icons.cleaning_services,
              details: "Kıyafet türüne uygun deterjan kullanın.",
            ),
            _buildPufNoktalariCard(
              context,
              title: "Yıkama Sıcaklığı",
              icon: Icons.thermostat,
              details:
                  "Yüksek sıcaklık kumaşları yıpratabilir, soğuk su tercih edin.",
            ),
            _buildPufNoktalariCard(
              context,
              title: "Kuruma Yöntemi",
              icon: Icons.wb_sunny,
              details: "Mümkünse kıyafetleri doğal ortamda kurutun.",
            ),
            _buildPufNoktalariCard(
              context,
              title: "Kıyafetleri Ters Çevirme",
              icon: Icons.flip,
              details:
                  "Çizilmelere ve renk solmalarına karşı kıyafetleri ters çevirin.",
            ),
            _buildPufNoktalariCard(
              context,
              title: "Ütüleme",
              icon: Icons.iron,
              details:
                  "Kıyafetler soğuduktan sonra ütü yapın ve uygun ısıda ütüleyin.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context,
      {required String title,
      required IconData icon,
      required String details}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    details,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPufNoktalariCard(BuildContext context,
      {required String title,
      required IconData icon,
      required String details}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 216, 76, 76),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    details,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
