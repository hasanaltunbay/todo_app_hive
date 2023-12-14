// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoItemAdapter extends TypeAdapter<ToDoItem> {
  @override
  final int typeId = 1;

  @override
  ToDoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] == null ? false : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
