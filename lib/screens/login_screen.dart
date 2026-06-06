import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../authority/screens/authority_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _otpSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF160507), Color(0xFF0A0A0C)],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE52E3D),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE52E3D).withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child:
                      const Icon(Icons.shield, size: 44, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "SENTINEL",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "YOUR SAFETY, ALWAYS ON",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(
                  label: "USER NAME",
                  controller: _nameController,
                  hint: "Priya Sharma",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "PHONE NUMBER",
                  controller: _phoneController,
                  hint: "+1 (555) 000-0000",
                  icon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                if (_otpSent) ...[
                  const SizedBox(height: 20),
                  _buildInputField(
                    label: "ENTER OTP",
                    controller: _otpController,
                    hint: "123456",
                    icon: Icons.sms_outlined,
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE52E3D),
                    minimumSize: const Size(
                      double.infinity,
                      56,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFFE52E3D).withOpacity(0.4),
                  ),
                  onPressed: () {
                    if (!_otpSent) {
                      setState(() {
                        _otpSent = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Demo OTP: 123456",
                          ),
                        ),
                      );

                      return;
                    }

                    if (_otpController.text == "123456") {
                      String finalName = _nameController.text.trim().isEmpty
                          ? "Priya Sharma"
                          : _nameController.text.trim();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(
                            userName: finalName,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Invalid OTP",
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _otpSent ? "Verify OTP" : "Send OTP",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child:
                            Divider(color: Colors.grey[800], thickness: 0.8)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("or use biometrics",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ),
                    Expanded(
                        child:
                            Divider(color: Colors.grey[800], thickness: 0.8)),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF18181C),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[900]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.fingerprint, color: Color(0xFFE52E3D)),
                      const SizedBox(width: 10),
                      Text("Fingerprint / Face ID",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.security,
                      color: Color(0xFFE52E3D),
                    ),
                    label: const Text(
                      "Authority Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.grey[800]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: const Color(0xFF18181C),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthorityLoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("In an emergency? ",
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 13)),
                    const Text("Call 911",
                        style: TextStyle(
                            color: Color(0xFFE52E3D),
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
            filled: true,
            fillColor: const Color(0xFF18181C),
            prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
            suffixIcon: isPassword
                ? Icon(Icons.visibility_off_outlined,
                    color: Colors.grey[700], size: 20)
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
