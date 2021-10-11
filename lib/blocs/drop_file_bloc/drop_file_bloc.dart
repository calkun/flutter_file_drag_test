import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:meta/meta.dart';

part 'drop_file_event.dart';
part 'drop_file_state.dart';

class DropFileBloc extends Bloc<DropFileEvent, DropFileState> {
  DropFileBloc() : super(DropFileInitial()) {
    on<DropFileEventGetFile>((event, emit) async {
      var bytes = await event.dropzoneViewController.getFileData(event.value);
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxCols);
        print(excel.tables[table]!.maxRows);
        for (var row in excel.tables[table]!.rows) {
          print("$row");
        }
      }
    });
  }
}
