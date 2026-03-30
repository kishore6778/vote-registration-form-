import 'package:flutter/material.dart';
import 'dart:ui';                          // NEW — needed for ImageFilter.blur

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(          // gradient background — makes glass visible
          gradient: LinearGradient(
            colors: [Color(0xFF833AB4), Color(0xFFE1306C), Color(0xFFFD1D1D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              "🎂 Our Bakery",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CakeCard(
              cakeName: "Chocolate Cake",
              price: "₹350",
              imageUrl: "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=300",
            ),
            CakeCard(
              cakeName: "Vanilla Cake",
              price: "₹280",
              imageUrl: "https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=300",
            ),
            CakeCard(
              cakeName: "Strawberry Cake",
              price: "₹320",
              imageUrl: "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=300",
            ),
          ],
        ),
      ),
    );
  }
}

class CakeCard extends StatelessWidget {
  final String cakeName;
  final String price;
  final String imageUrl;

  CakeCard({required this.cakeName, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 120,
      child: ClipRRect(                           // clips the blur inside rounded corners
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(                    // NEW — creates the blur effect
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),   // blur intensity
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),           // semi-transparent white
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),          // glassy border
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cakeName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,         // white text on glass
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.white70,        // slightly faded white
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



 



          
        
        
      



    
  
 