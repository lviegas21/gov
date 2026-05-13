import 'package:auth_gov/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  String _result = 'Não autenticado';
  String? _accessToken;
  String? _refreshToken;
  String? _idToken;

  Future<void> _login() async {
    try {
      final tokens = await _authService.login();
      if (tokens == null) {
        setState(() => _result = 'Login cancelado ou sem token');
        return;
      }

      setState(() {
        _accessToken = tokens.accessToken;
        _refreshToken = tokens.refreshToken;
        _idToken = tokens.idToken;
        _result = 'Login realizado com sucesso';
      });
    } catch (e) {
      setState(() => _result = 'Erro no login: $e');
    }
  }

  Future<void> _callMe() async {
    print(_accessToken);
    if (_accessToken == null) {
      setState(() => _result = 'Faça login antes');
      return;
    }

    final response = await http.get(
      Uri.parse('https://translator-somerset-bloom-cir.trycloudflare.com/me'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    print(response.body);

    setState(() => _result = response.body);
  }

  Future<void> _refresh() async {
    if (_refreshToken == null) {
      setState(() => _result = 'Sem refresh token');
      return;
    }

    try {
      final tokens = await _authService.refresh(_refreshToken!);
      if (tokens == null) {
        setState(() => _result = 'Falha ao renovar token');
        return;
      }

      setState(() {
        _accessToken = tokens.accessToken;
        _refreshToken = tokens.refreshToken;
        _idToken = tokens.idToken;
        _result = 'Token renovado com sucesso';
      });
    } catch (e) {
      setState(() => _result = 'Erro no refresh: $e');
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.logout(idTokenHint: _idToken);
      setState(() {
        _accessToken = null;
        _refreshToken = null;
        _idToken = null;
        _result = 'Logout realizado';
      });
    } catch (e) {
      setState(() => _result = 'Erro no logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Lab')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _login,
              child: const Text('Entrar com Keycloak'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _callMe,
              child: const Text('Chamar /me'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _refresh,
              child: const Text('Refresh token'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _logout(),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_result),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
