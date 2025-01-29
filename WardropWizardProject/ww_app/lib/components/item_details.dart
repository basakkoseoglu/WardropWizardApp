import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  final String imageUrl;

  const ItemDetailsPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resim Detayları'),
        backgroundColor: const Color.fromRGBO(185, 3, 43, 0.729),
      ),
      body: Column(
        children: [
          // Resmi görüntüle
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                );
              },
            ),
          ),
          // Detayları düzenleme seçenekleri
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Kategori Değiştir"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Kategori değiştirme işlemleri
                  },
                ),
                ListTile(
                  title: const Text("Etiket Ekle"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Etiket ekleme işlemleri
                  },
                ),
                ListTile(
                  title: const Text("Sil"),
                  trailing: const Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    // Silme işlemi için uyarı
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Silme Onayı"),
                        content: const Text("Bu resmi silmek istediğinize emin misiniz?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("İptal"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Silme işlemini burada başlatabilirsiniz
                            },
                            child: const Text("Sil", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}