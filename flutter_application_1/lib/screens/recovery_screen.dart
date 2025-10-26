import 'package:flutter/material.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key, required this.isForgotPassword});

  final bool isForgotPassword; // true para "Esqueci minha senha", false para "Não tenho cadastro"

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
                  Text(
                    isForgotPassword ? 'Recuperar Senha' : 'Registro',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                isForgotPassword
                    ? 'Digite seu e-mail para receber um código de verificação'
                    : 'Crie sua conta preenchendo os dados abaixo',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
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
              const SizedBox(height: 20),
              if (!isForgotPassword) ...[
                // Campos extras para registro (exemplo)
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    filled: true,
                    fillColor: Colors.teal[50],
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.teal[50],
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (isForgotPassword) {
                      // Simula envio de código de verificação (placeholder)
                      // TODO: Substituir por lógica de backend
                      print('Código de verificação enviado!'); // Placeholder
                      // Navega para a tela de verificação (a ser definida)
                      Navigator.pushNamed(context, '/verification');
                    } else {
                      // Simula registro (placeholder)
                      print('Registro solicitado!'); // Placeholder
                      // Navega para a tela de registro confirmada (a ser definida)
                      Navigator.pushNamed(context, '/register_confirm');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    isForgotPassword ? 'Enviar Código' : 'Criar Conta',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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