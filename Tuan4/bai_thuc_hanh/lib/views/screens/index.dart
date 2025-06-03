import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 70,
            left: 20,
            right: 20,
            bottom: 8
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/flowers.jpg',height: 233,width: 216,),
              SizedBox(height: 30,),
              Text('Jetpack Compose', style:TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text('Jetpack Compose is a modern UI toolkit for building native '
                  ' applications using a declarative programming approach.',
                textAlign: TextAlign.center,
                //style: ,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52.23,
                child: ElevatedButton(
                    onPressed: () {
                   
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                        "I'm ready",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
