// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_prediction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagePredictionAdapter extends TypeAdapter<ImagePrediction> {
  @override
  final int typeId = 0;

  @override
  ImagePrediction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagePrediction(
      imagePath: fields[0] as String,
      prediction: fields[1] as String,
      category: fields[2] as String, 
    );
  }

  @override
  void write(BinaryWriter writer, ImagePrediction obj) {
    writer
      ..writeByte(3) 
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.prediction)
      ..writeByte(2) 
      ..write(obj.category); 
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagePredictionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
