import 'package:flutter/material.dart';
import 'login_screen.dart';

class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                children: [
                  Icon(
                    Icons.cloud,
                    size: 36,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Verificação',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Enviamos um código ao seu e-mail. Digite-o abaixo para continuar.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Código',
                  filled: true,
                  fillColor: Colors.teal[50],
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Simula verificação de código (placeholder)
                    // TODO: Substituir por lógica de backend
                    print('Código verificado!'); // Placeholder
                    // Navega de volta para LoginScreen como exemplo
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Verificar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}