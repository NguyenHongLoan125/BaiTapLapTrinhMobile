import 'package:btvn_01/models/book.dart';
import 'package:btvn_01/models/student.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController studentNameController = TextEditingController();

  List<Book> books = [
    Book(title: 'Sách 01'),
    Book(title: 'Sách 02'),
    Book(title: 'Sách 03'),
    Book(title: 'Sách 04'),
    Book(title: 'Sách 05'),
    Book(title: 'Sách 06'),
  ];

  List<Student> students = [
    Student(name: "Nguyen Van A"),
    Student(name: "Nguyen Van B"),
    Student(name: "Nguyen Van C"),
  ];

  Student? selectedStudent;

  void selectStudent(String name) {
    setState(() {
      selectedStudent = students.firstWhere(
            (student) => student.name == name,
        orElse: () => Student(name: name),
      );

      // Nếu sinh viên chưa có danh sách `selectedBooks`, khởi tạo nó với trạng thái mặc định
      if (selectedStudent!.selectedBooks.isEmpty) {
        for (var book in books) {
          selectedStudent!.selectedBooks[book.title] = false;
        }
      }

      // Cập nhật danh sách sách nhưng giữ trạng thái
      books = books.map((book) =>
          Book(title: book.title, isSelected: selectedStudent!.selectedBooks[book.title] ?? false)
      ).toList();
    });
  }

  void borrowBook(Book book) {
    if (selectedStudent != null) {
      setState(() {
        selectedStudent!.borrowedBooks.add(book);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Hệ thống\nQuản Lý Thư Viện",textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sinh viên:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: studentNameController, // Thêm controller
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // Đổi màu nền
                      foregroundColor: Colors.white, // Đổi màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bo góc
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Điều chỉnh kích thước
                    ),

                    onPressed: () {
                      setState(() {
                        selectedStudent = students.firstWhere(
                              (student) => student.name == studentNameController.text,
                          orElse: () => Student(name: studentNameController.text),
                        );
                      });
                    },
                    child: Text('Thay đổi', style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh sách sách',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: selectedStudent == null || selectedStudent!.borrowedBooks.isEmpty
                        ? Center(child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Bạn chưa mượn quyển sách nào",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  "Nhấm 'Thêm' để bắt đầu hành trình đọc sách",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                        ))
                        : ListView.builder(
                      itemCount: selectedStudent!.borrowedBooks.length,
                      itemBuilder: (context, index) {
                        var book = selectedStudent!.borrowedBooks[index]; // Lấy đúng sách từ danh sách borrowedBooks
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          title: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: selectedStudent!.selectedBooks[book.title] ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedStudent!.selectedBooks[book.title] = value!;
                                      if (value!) {
                                        selectedStudent!.borrowedBooks.add(book);
                                      } else {
                                        selectedStudent!.borrowedBooks.removeWhere((b) => b.title == book.title);
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: 8),
                                Text(
                                  book.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedStudent != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return AlertDialog(
                              title: Text("Chọn sách để mượn"),
                              content: Container(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: books.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      title: Text(books[index].title),
                                      value: selectedStudent!.selectedBooks[books[index].title] ?? false,
                                      onChanged: (bool? value) {
                                        setStateDialog(() {
                                          selectedStudent!.selectedBooks[books[index].title] = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Hủy"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      // Không xóa toàn bộ danh sách trước, mà chỉ cập nhật sách được chọn
                                      selectedStudent!.borrowedBooks = books.where((book) => selectedStudent!.selectedBooks[book.title] ?? false).toList();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Xác nhận"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bo góc
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Điều chỉnh kích thước
                ),
                child: Text(
                  'Thêm',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Sách'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Sinh viên'),
        ],
      ),
    );
  }
}


