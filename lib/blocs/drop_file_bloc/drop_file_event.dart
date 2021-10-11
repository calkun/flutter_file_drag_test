part of 'drop_file_bloc.dart';

@immutable
abstract class DropFileEvent {}

class DropFileEventGetFile extends DropFileEvent {
  final DropzoneViewController dropzoneViewController;
  final dynamic value;

  DropFileEventGetFile({
    required this.dropzoneViewController,
    required this.value,
  });
}
