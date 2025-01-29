import 'package:hive/hive.dart';

part 'image_prediction.g.dart';

@HiveType(typeId: 0)
class ImagePrediction {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String prediction;

  @HiveField(2)
  final String category;

  ImagePrediction({
    required this.imagePath,
    required this.prediction,
    required this.category,
  });
}

