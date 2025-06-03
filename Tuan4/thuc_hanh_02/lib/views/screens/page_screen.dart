import 'package:flutter/material.dart';
import 'package:thuc_hanh_02/model/page_model.dart';
import 'package:thuc_hanh_02/views/screens/splash_screen.dart';

class PageScreen extends StatefulWidget {
  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<PageModel> pages = [
    PageModel(
      imagePath: 'assets/anh1.jpg',
      title: 'Easy Time Management',
      description: 'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first ',
    ),
    PageModel(
      imagePath: 'assets/anh2.jpg',
      title: 'Increase Work Effectiveness',
      description: 'Time management and the determination of more important tasks will give your job statistics better and always improve',
    ),
    PageModel(
      imagePath: 'assets/anh3.jpg',
      title: 'Reminder Notification',
      description: 'The advantage of this application is that it also provides reminders for you so you don''t forget to keep doing your assignments well and according to the time you have set',
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => SplashScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemCount: pages.length,
        itemBuilder: (_, index) {
          final page = pages[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      pages.length,
                          (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == currentPage ? Colors.blue : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => SplashScreen()));
                    },
                    child: const Text("Skip", style: TextStyle(color: Colors.blue),),
                  )
                ],
              ),
              const SizedBox(height: 150),
              Image.asset(
                  page.imagePath,
                  height: 250
              ),
              const SizedBox(height: 30),
              Text(
                  page.title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    page.description,
                    textAlign: TextAlign.center
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF007BFF),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ),
                      ),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007BFF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          index == pages.length - 1 ? 'Get Started' : 'Next',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
