import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

part 'wardrobe_page.g.dart';

@HiveType(typeId: 0)
class ImagePrediction {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String prediction;

  @HiveField(2)
  final String category;

  ImagePrediction(
      {required this.imagePath,
      required this.prediction,
      required this.category});
}

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  int _selectedWardrobeTabIndex = 0;
  final ImagePicker _picker = ImagePicker();
  late Box<ImagePrediction> _imageBox;

  static const List<String> tabs = [
    "Tümü",
    "Elbise",
    "Gömlek",
    "Ceket",
    "Etek",
    "Şort",
    "Pantolon",
    "Çanta",
    "Güneş gözlüğü",
    "Şapka",
    "Ayakkabı"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _imageBox = await Hive.openBox<ImagePrediction>('image_predictions');
      setState(() {});
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final prediction = await _uploadImage(imageFile);

      final newPrediction = ImagePrediction(
        imagePath: imageFile.path,
        prediction: prediction,
        category: prediction,
      );

      _imageBox.add(newPrediction);
      setState(() {});
    } else {
      print('Resim seçilmedi.');
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      final uri =
          Uri.parse('http://172.20.10.3:5000/predict'); // Flask API endpoint
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> json = jsonDecode(responseData);

        // İlk tahmini döndür (birden fazla tahmin varsa sadece ilkini alıyoruz)
        if (json['predictions'] != null && json['predictions'] is List) {
          return (json['predictions'] as List).first.toString();
        } else {
          return 'Bilinmeyen';
        }
      } else {
        return 'Hata: ${response.statusCode}';
      }
    } catch (e) {
      return 'Hata: $e';
    }
  }

// Tahmin sonucunu kategoriyle eşleştiren yardımcı fonksiyon
  String _mapPredictionToCategory(String prediction) {
    prediction = prediction.toLowerCase();
    if (prediction.contains("elbise")) {
      return "Elbise";
    } else if (prediction.contains("gömlek")) {
      return "Gömlek";
    } else if (prediction.contains("ceket")) {
      return "Ceket";
    } else if (prediction.contains("şort")) {
      return "Şort";
    } else if (prediction.contains("pantolon")) {
      return "Pantolon";
    } else if (prediction.contains("etek")) {
      return "Etek";
    } else if (prediction.contains("çanta")) {
      return "Çanta";
    } else if (prediction.contains("güneş gözlüğü")) {
      return "Güneş gözlüğü";
    } else if (prediction.contains("şapka")) {
      return "Şapka";
    } else if (prediction.contains("ayakkabı")) {
      return "Ayakkabı";
    }
    return "Tümü"; // Varsayılan kategori
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Dolabım',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(185, 3, 43, 0.729),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 24,
                      color: Color.fromRGBO(185, 3, 43, 0.729),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTabBar(),
                const SizedBox(height: 16),
                _buildImageList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(185, 3, 43, 0.729),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Galeri',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(185, 3, 43, 0.729),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Kamera',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedWardrobeTabIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: _selectedWardrobeTabIndex == index
                    ? Color.fromRGBO(185, 3, 43, 0.729).withOpacity(0.4)
                    : Color.fromRGBO(185, 3, 43, 0.729),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: _selectedWardrobeTabIndex == index
                        ? Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6)
                        : Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageList() {
    if (_imageBox.isEmpty) {
      return Text('Henüz resim eklenmedi.');
    }

    // Seçili sekmeye göre filtreleme
    final allImages = _imageBox.values.toList();
    final filteredImages = _selectedWardrobeTabIndex == 0
        ? allImages
        : allImages
            .where((imagePrediction) =>
                imagePrediction.prediction.toLowerCase() ==
                tabs[_selectedWardrobeTabIndex].toLowerCase())
            .toList();

    if (filteredImages.isEmpty) {
      return Text('Bu kategoriye ait resim yok.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredImages.length,
      itemBuilder: (context, index) {
        final imagePrediction = filteredImages[index];

        // Orijinal indeksi bulmak için
        final originalIndex =
            _imageBox.values.toList().indexOf(imagePrediction);

        return Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(
                  File(imagePrediction.imagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteImage(originalIndex);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Kategori: ${imagePrediction.prediction}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  void _deleteImage(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Silme Onayı"),
        content: Text("Bu resmi silmek istediğinizden emin misiniz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // İptal
            child: Text("Hayır"),
          ),
          TextButton(
            onPressed: () {
              _imageBox.deleteAt(index);
              setState(() {});
              Navigator.of(context).pop(); // Onay
            },
            child: Text("Evet"),
          ),
        ],
      ),
    );
  }
}
