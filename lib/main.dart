import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanDisk Membership',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'SF Pro', // Closest to Apple system font
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _showMembership = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SanDisk', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            children: [
              const Text('Membership', style: TextStyle(fontSize: 16)),
              Switch(
                value: _showMembership,
                onChanged: (value) => setState(() => _showMembership = value),
                activeColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0A), Color(0xFF1A1A1A)],
          ),
        ),
        child: Stack(
          children: [
            // ==================== REGISTRATION FORM - Premium Apple Liquid Glass ====================
            if (!_showMembership)
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0), // Stronger liquid glass blur
                    child: Container(
                      color: Colors.white.withOpacity(0.07),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                      child: Column(
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Glass Card with Apple-style depth
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildTextField('Full Name'),
                                const SizedBox(height: 16),
                                _buildTextField('Email Address'),
                                const SizedBox(height: 16),
                                _buildTextField('Password', obscureText: true),
                                const SizedBox(height: 32),

                                // Gradient Apple-style button
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF007AFF), Color(0xFF00C4FF)],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                    child: const Text(
                                      'Create Account',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? ", style: TextStyle(color: Colors.white70)),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Navigate to Login screen
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Color(0xFF007AFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // ==================== MEMBERSHIP PLANS - Vertical ListView (full space, scrollable) ====================
            if (_showMembership)
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  const Text(
                    'Choose Your Plan',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SanDisk Cloud Storage & Premium Services',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 24),

                  _buildSanDiskPlan(
                    title: 'Basic',
                    subtitle: 'For beginners & everyday use',
                    oldPrice: null,
                    newPrice: '\$5.99',
                    period: '/month',
                    billed: 'Billed for 12 months',
                    saveText: '',
                    color: Colors.grey[850]!,
                    topColor: null,
                    topText: null,
                    features: [
                      '200 GB Cloud Storage',
                      'Basic Photo & Video Backup',
                      'Access on up to 3 devices',
                      'Standard Customer Support',
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildSanDiskPlan(
                    title: 'Pro',
                    subtitle: 'For power users & creators',
                    oldPrice: '\$12.99',
                    newPrice: '\$9.99',
                    period: '/month',
                    billed: 'Billed for 12 months',
                    saveText: 'Save \$36 per year',
                    color: const Color(0xFF1F2A44),
                    topColor: null,
                    topText: null,
                    features: [
                      '2 TB Cloud Storage',
                      'Advanced Backup & Auto-Sync',
                      'Access on up to 10 devices',
                      'Priority Support',
                      'File Version History (30 days)',
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildSanDiskPlan(
                    title: 'Ultimate',
                    subtitle: 'Best for professionals',
                    oldPrice: '\$24.99',
                    newPrice: '\$19.99',
                    period: '/month',
                    billed: 'Billed for 12 months',
                    saveText: 'Save \$60 per year',
                    color: const Color(0xFF0F3D2E),
                    topColor: Colors.limeAccent,
                    topText: 'MOST POPULAR',
                    features: [
                      '10 TB Cloud Storage',
                      'AI-Powered Photo Search',
                      'Unlimited devices',
                      '24/7 Premium Support',
                      'Advanced Security & Encryption',
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildSanDiskPlan(
                    title: 'Creator',
                    subtitle: 'For content creators & businesses',
                    oldPrice: '\$49.99',
                    newPrice: '\$39.99',
                    period: '/month',
                    billed: 'Billed for 12 months',
                    saveText: 'Save \$120 per year',
                    color: const Color(0xFF3D1B2E),
                    topColor: Colors.pinkAccent,
                    topText: 'BEST VALUE',
                    features: [
                      'Unlimited Cloud Storage',
                      'Professional Editing Tools',
                      'Dedicated Account Manager',
                      'Highest Security & Encryption',
                      'Free Data Recovery Service',
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60, fontSize: 16),
        filled: true,
        fillColor: Colors.white.withOpacity(0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 17),
    );
  }

  Widget _buildSanDiskPlan({
    required String title,
    required String subtitle,
    required String? oldPrice,
    required String newPrice,
    required String period,
    required String billed,
    required String saveText,
    required Color color,
    required Color? topColor,
    required String? topText,
    required List<String> features,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: topColor != null ? Border.all(color: topColor.withOpacity(0.7), width: 3) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Attractive colored top banner like in your image
          if (topText != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Center(
                child: Text(
                  topText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 15)),

                const SizedBox(height: 20),

                // Price with correct strikethrough (old price cancelled)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (oldPrice != null)
                      Text(
                        oldPrice,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white54,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      newPrice,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      period,
                      style: const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),

                Text(billed, style: const TextStyle(color: Colors.white60, fontSize: 14)),
                if (saveText.isNotEmpty)
                  Text(saveText, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w500)),

                const SizedBox(height: 24),

                const Text('Includes:', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white70)),

                ...features.map((f) => Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 20),
                          const SizedBox(width: 12),
                          Expanded(child: Text(f, style: const TextStyle(fontSize: 15.5))),
                        ],
                      ),
                    )),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: topColor ?? Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Select Plan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}