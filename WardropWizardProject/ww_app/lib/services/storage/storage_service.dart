import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ww_app/pages/wardrobe_page.dart';

class StorageService with ChangeNotifier {
  late Box<ImagePrediction> _imageBox;

  List<ImagePrediction> _images = [];
  bool _isLoading = false;

  List<ImagePrediction> get images => _images;
  bool get isLoading => _isLoading;

  /*
   * Hive Kutusunu Başlat
   */
  Future<void> initializeHive() async {
    try {
      _imageBox = await Hive.openBox<ImagePrediction>('image_predictions');
      await fetchImages(); // fetchImages çağrısı burada
    } catch (e) {
      print('Hive başlatılırken hata: $e');
    }
  }

  /*
   * RESİMLERİ OKUMA
   */
  Future<void> fetchImages() async {
    if (!_imageBox.isOpen) {
      print("Hive kutusu başlatılmadığı için resimler getirilemiyor.");
      return;
    }

    _isLoading = true;
    _images = _imageBox.values.toList();
    _isLoading = false;
    notifyListeners();
  }

  /*
   * RESİMLERİ EKLEME
   */
  Future<void> saveImage(String className, String filePath) async {
    final newImage = ImagePrediction(
      imagePath: filePath,
      prediction: className,
      category: className,
    );

    final key = await _imageBox.add(newImage);

    _images.add(newImage);
    print("Yeni resim eklendi: $key");
    notifyListeners();
  }

  /*
   * RESİMLERİ SİLME
   */
  Future<void> deleteImage(String filePath) async {
    try {
      final entry = _imageBox.values.firstWhere(
        (image) => image.imagePath == filePath,
        orElse: () => throw Exception("Resim bulunamadı."),
      );

      final key = _imageBox.keyAt(_imageBox.values.toList().indexOf(entry));
      await _imageBox.delete(key);

      _images.removeWhere((image) => image.imagePath == filePath);
      notifyListeners();
    } catch (e) {
      print("Resim silinirken hata oluştu: $e");
    }
  }

  /*
   * RESİM YÜKLEME (Galeriden seçip kaydetme)
   */
  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('Resim seçilmedi.');
      return;
    }

    try {
      final File file = File(pickedFile.path);

      // Uygulama dizinine kopyala
      final directory = await getApplicationDocumentsDirectory();
      final String className = 'default';
      final String folderPath = '${directory.path}/images/$className/';
      final Directory classDirectory = Directory(folderPath);

      if (!classDirectory.existsSync()) {
        classDirectory.createSync(recursive: true);
      }

      final String newFilePath =
          '$folderPath${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File savedFile = await file.copy(newFilePath);

      await saveImage(className, savedFile.path);
    } catch (e) {
      print('Resim yükleme sırasında hata oluştu: $e');
    }
  }
}
