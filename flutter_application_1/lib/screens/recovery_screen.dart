import 'package:flutter/material.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => _loading = true);
    // TODO: chamar seu endpoint de "password reset request"
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _loading = false);

    // TODO: navegue para a tela de verificação de código, ex: '/code-verification'
    // Navigator.of(context).pushNamed('/code-verification', arguments: _emailCtrl.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Se existir, enviaremos um código para o e-mail informado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mesma paleta usada no Login
    const primary = Color(0xFF3C6E91);
    const bg = Color(0xFFF2F8FB);
    const input = Color(0xFFD3E7EF);
    const accent = Color(0xFF9EC6D8);
    const text = Color(0xFF4E4E4E);
    const muted = Color(0xFF8A8A8A);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabeçalho: ícone + "Verifique o e-mail"
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.cloud_outlined, size: 32, color: primary),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: CustomPaint(
                                  painter: _SignalPainter(color: primary.withOpacity(0.65)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Verifique o e-mail',
                            style: TextStyle(
                              color: text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      const Text(
                        'Insira o e-mail',
                        style: TextStyle(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        style: const TextStyle(color: text, fontSize: 16, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: input,
                          hintText: 'XXXXXX',
                          hintStyle: const TextStyle(color: muted, fontWeight: FontWeight.w600),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: primary, width: 1),
                          ),
                        ),
                        validator: (v) {
                          final value = v?.trim() ?? '';
                          if (value.isEmpty) return 'Informe o e-mail';
                          final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value);
                          if (!ok) return 'E-mail inválido';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Botão redondo com seta à direita (igual mock)
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: 54,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                                shape: const CircleBorder(),
                                elevation: 0,
                                padding: EdgeInsets.zero,
                              ),
                              child: _loading
                                  ? const SizedBox(
                                      width: 22, height: 22,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.arrow_forward_rounded, size: 26),
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
        ),
      ),
    );
  }
}

class _SignalPainter extends CustomPainter {
  final Color color;
  const _SignalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final center = Offset(size.width * 0.28, size.height * 0.28);
    for (int i = 0; i < 3; i++) {
      final r = 8 + i * 4;
      final rect = Rect.fromCircle(center: center, radius: r.toDouble());
      canvas.drawArc(rect, -2.6, 1.2, false, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
