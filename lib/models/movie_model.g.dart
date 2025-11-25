// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 1;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as String,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      releaseDate: fields[3] as String,
      rating: fields[4] as double,
      genre: fields[5] as String,
      description: fields[6] as String,
      duration: fields[7] as String,
      director: fields[8] as String,
      cast: fields[9] as String,
      language: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.genre)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.director)
      ..writeByte(9)
      ..write(obj.cast)
      ..writeByte(10)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
