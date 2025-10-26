import 'package:flutter/material.dart';
import 'code_verification_screen.dart'; // Placeholder para tela de código
import 'register_screen.dart'; // Placeholder para tela de registro

class EmailRequestScreen extends StatelessWidget {
  const EmailRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controlador para o campo de e-mail
    final emailController = TextEditingController();

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
                    'Recuperação',
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
                'Digite seu e-mail para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController, // Vincula o controlador ao campo
                decoration: InputDecoration(
                  labelText: 'E-mail',
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
                    // Obtém o e-mail digitado pelo usuário
                    String enteredEmail = emailController.text.trim();
                    // Simulação: verifica se o e-mail existe (placeholder)
                    // TODO: Substituir por lógica de backend
                    if (enteredEmail == 'usuario@exemplo.com') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CodeVerificationScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Enviar',
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