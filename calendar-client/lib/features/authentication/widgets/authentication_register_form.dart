import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';
import 'package:flutter_application_1/theme/app_button_decorations.dart';
import 'package:flutter_application_1/theme/app_input_decorations.dart';

class AuthenticationRegisterForm extends StatefulWidget
{
  const AuthenticationRegisterForm({
    super.key,
    required this.onRegisterPressed,
  });

  final void Function(RegisterRequest request)? onRegisterPressed;

  @override
  State<AuthenticationRegisterForm> createState() => _AuthenticationRegisterState();
}

class _AuthenticationRegisterState extends State<AuthenticationRegisterForm>
{
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstPasswordController = TextEditingController();
  final _secondPasswordController = TextEditingController();

  bool _firstPasswordObscure = true;
  bool _secondPasswordObscure = true;

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
    super.dispose();
  }

    void _submit()
  {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final request = RegisterRequest(nickname: _nicknameController.text, email: _emailController.text.trim(), password: _firstPasswordController.text);

    widget.onRegisterPressed?.call(request);
  }

  String? _validatePassword (String? value)
  {
    final text = value ?? '';
    if (text.isEmpty) return 'Введите пароль';
    if (text.length < 8) return 'Пароль должен быть не короче 8 символов';
    final hasLowercaseLatin = RegExp(r'[a-z]').hasMatch(text);
    final hasUppercaseLatin = RegExp(r'[A-Z]').hasMatch(text);
    final hasDigit = RegExp(r'\d').hasMatch(text);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\\[\];]').hasMatch(text);
    final hasOnlyAllowedChars = RegExp(r'^[A-Za-z\d!@#\$%^&*(),.?":{}|<>_\-+=/\\[\];]+$').hasMatch(text);
    if (!hasOnlyAllowedChars || !hasLowercaseLatin || !hasDigit || !hasUppercaseLatin || !hasSpecial) return 'Пароль должен содержать хотя бы одну строчную и заглавную латинскую букву\nспециальный символ - !"(;%\nцифру - 0-9';
    return null;
  }

  String? _validateConfirmPassword (String? value)
  {
    final confirmPassword = value ?? '';
    final password = _firstPasswordController.text;

    if (confirmPassword.isEmpty) return 'Подтвердите пароль';
    if (confirmPassword != password) return 'Пароли не совпадают';
    return null;
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
                  const SizedBox(height: 16,),
                  const Text(
                  'Регистрация',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16,),
                const Text(
                  'Имя',
                  textAlign: TextAlign.left,
                  
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                 ),
                ),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: _nicknameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  decoration: AppInputDecorations.authInput(
                    hintText: 'Ваше имя',
                    prefixIcon: Icons.person_rounded
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return 'Введите имя';
                      return null;
                    },
                ),
                const SizedBox(height: 16,),
                const Text(
                  'Email',
                  textAlign: TextAlign.left,
                  
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                 ),
                ),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  decoration: AppInputDecorations.authInput(
                    hintText: 'example@email.com',
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
                const Text(
                  'Пароль',
                  textAlign: TextAlign.left,
                  
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                 ),
                ),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: _firstPasswordController,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.password],
                  obscureText: _firstPasswordObscure,
                  decoration: AppInputDecorations.authInput(
                    hintText: 'Минимум 8 символов',
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: IconButton(
                      onPressed: () {
                      setState(() {
                        _firstPasswordObscure = !_firstPasswordObscure;
                      });
                    }, 
                    icon: Icon(_firstPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    )
                    ),
                    validator: _validatePassword,
                ),
                const SizedBox(height: 16,),
                const Text(
                  'Подтвердите пароль',
                  textAlign: TextAlign.left,
                  
                  style: TextStyle(
                    color: Color(0xFF1F1F29),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                 ),
                ),
                const SizedBox(height: 4,),
                TextFormField(
                  controller: _secondPasswordController,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  obscureText: _secondPasswordObscure,
                  decoration: AppInputDecorations.authInput(
                    hintText: 'Повторите пароль',
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: IconButton(
                      onPressed: () {
                      setState(() {
                        _secondPasswordObscure = !_secondPasswordObscure;
                      });
                    }, 
                    icon: Icon(_secondPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    )
                    ),
                    validator: _validateConfirmPassword,
                    onFieldSubmitted: (_) => _submit(),
                ),
                SizedBox(height: 36,),
                AppButtonDecorations.gradientButton(text: 'Зарегистрироваться', onTap: _submit)
                ]
              ),
            )
          ),
        );
      }
    );
  }
}