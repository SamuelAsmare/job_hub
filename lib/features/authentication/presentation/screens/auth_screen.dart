import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_role_selector.dart';
import '../widgets/auth_text_field.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({
    super.key,
    required this.isRegistration,
    required this.onAuthenticated,
    required this.onBack,
    this.onSwitchMode,
  });

  final bool isRegistration;
  final ValueChanged<User> onAuthenticated;
  final VoidCallback onBack;
  final VoidCallback? onSwitchMode;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UserRole _selectedRole = UserRole.jobSeeker;

  bool get _isRegistration => widget.isRegistration;

  String get _illustration {
    if (!_isRegistration) {
      return 'assets/images/signin.png';
    }

    return _selectedRole == UserRole.employer
        ? 'assets/images/register_company.png'
        : 'assets/images/register.png';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required.';
    }

    if (value.trim().length < 2) {
      return 'Name must contain at least 2 characters.';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailPattern.hasMatch(value.trim())) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (_isRegistration && value.length < 8) {
      return 'Password must contain at least 8 characters.';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(authProvider.notifier);

    final success = _isRegistration
        ? await controller.register(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            role: _selectedRole,
          )
        : await controller.login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

    if (!mounted || !success) return;

    final user = ref.read(currentUserProvider);

    if (user != null) {
      widget.onAuthenticated(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(_isRegistration ? 'Create Account' : 'Sign In'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Image.asset(
                        _illustration,
                        key: ValueKey(_illustration),
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _isRegistration ? 'Join JobHub' : 'Welcome Back',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isRegistration
                          ? 'Create your account and discover new opportunities.'
                          : 'Sign in to continue your career journey.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_isRegistration) ...[
                      AuthTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        textInputAction: TextInputAction.next,
                        validator: _validateName,
                        autofillHints: const [AutofillHints.name],
                      ),
                      const SizedBox(height: 18),
                    ],
                    AuthTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      autofillHints: const [AutofillHints.email],
                    ),
                    const SizedBox(height: 18),
                    AuthTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      textInputAction: _isRegistration
                          ? TextInputAction.next
                          : TextInputAction.done,
                      validator: _validatePassword,
                      autofillHints: [
                        _isRegistration
                            ? AutofillHints.newPassword
                            : AutofillHints.password,
                      ],
                    ),
                    if (_isRegistration) ...[
                      const SizedBox(height: 18),
                      AuthTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        icon: Icons.lock_reset_outlined,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        validator: _validateConfirmPassword,
                        autofillHints: const [AutofillHints.newPassword],
                      ),
                      const SizedBox(height: 24),
                      AuthRoleSelector(
                        selectedRole: _selectedRole,
                        onChanged: (role) {
                          setState(() => _selectedRole = role);
                        },
                      ),
                    ],
                    if (authState.errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        authState.errorMessage!,
                        style: TextStyle(
                          color: theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: authState.isLoading ? null : _submit,
                        child: authState.isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isRegistration ? 'Create Account' : 'Sign In',
                              ),
                      ),
                    ),
                    if (widget.onSwitchMode != null) ...[
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed:
                            authState.isLoading ? null : widget.onSwitchMode,
                        child: Text(
                          _isRegistration
                              ? 'Already have an account? Sign In'
                              : 'New to JobHub? Create Account',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
