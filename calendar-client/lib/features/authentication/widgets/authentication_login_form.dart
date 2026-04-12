import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_register_screen.dart';
import 'package:flutter_application_1/repositories/authentication/authentication.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';
import 'package:flutter_application_1/theme/app_button_decorations.dart';
import 'package:flutter_application_1/theme/app_input_decorations.dart';


class AuthenticationLoginForm extends StatefulWidget
{
  const AuthenticationLoginForm ({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  final void Function(LoginRequest request) onLoginPressed;
  final VoidCallback onRegisterPressed;

  @override
  State<AuthenticationLoginForm> createState() => _AuthenticationLoginState();
}

class _AuthenticationLoginState extends State<AuthenticationLoginForm>
{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit()
  {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final request = LoginRequest(email: _emailController.text.trim(), password: _passwordController.text);

    widget.onLoginPressed.call(request);
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    return LayoutBuilder(
      builder: (context, constraints){
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 32 + bottomSafeArea),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                const SizedBox(height: 32,),
                const Text(
                  'Войдите в аккаунт',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 36,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  decoration: AppInputDecorations.authInput(
                    hintText: 'Email',
                    prefixIcon: Icons.alternate_email_rounded
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return 'Введите email';
                      if (!text.contains('@')) return 'Некорректный email';

                      return null;
                    },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _passwordController,
                  
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  obscureText: _obscurePassword,
                  decoration: AppInputDecorations.authInput(
                    hintText: 'Пароль',
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: IconButton(
                      onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    }, 
                    icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    )
                    ),
                    validator: (value) {
                      final text = value ?? '';
                      if (text.isEmpty) return 'Введите пароль';
                      if (text.length < 8) return 'Пароль должен быть не короче 8 символов';

                      return null;
                    },
                      onFieldSubmitted: (_) => _submit(),
                ),

                
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                  style: ButtonStyle(
                    alignment: Alignment.centerRight,
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: (){},
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      color: Color(0xFF5B3DF5),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ),
                ),
                const SizedBox(height: 8,),
                AppButtonDecorations.gradientButton(text: 'Войти', onTap: _submit),
                const SizedBox(height: 32,),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                      thickness: 1,
                      color: Color(0xFFE7E8EA),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'или',
                        style: const TextStyle(
                          color: Color(0xFF9AA0A6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                      thickness: 1,
                      color: Color(0xFFE7E8EA),
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 32,),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Нет аккаунта? ',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,)
                      ),
                      TextButton(
                        style: ButtonStyle(
                        alignment: Alignment.centerRight,
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        ),
                      onPressed: widget.onRegisterPressed,
                      child: const Text(
                        'Зарегистрируйтесь',
                        style: TextStyle(
                        color: Color(0xFF5B3DF5),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ],
                  ),
                )
            ],
          ),
        ),
        ),
      );
      }
    );
  }
}