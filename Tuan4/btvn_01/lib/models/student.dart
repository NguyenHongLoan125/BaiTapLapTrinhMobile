import 'package:btvn_01/models/book.dart';
class Student {
  String name;
  List<Book> borrowedBooks;
  Map<String, bool> selectedBooks;

  Student({required this.name, List<Book>? borrowedBooks})
      : borrowedBooks = borrowedBooks ?? [],
        selectedBooks = {};
}