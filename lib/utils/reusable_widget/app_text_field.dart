import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_sizes.dart';

class AppTextField extends StatefulWidget {
  final String hintText;

  final String? labelText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCounter;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final String? helperText;
  final Widget? prefix;
  final Widget? suffix;

  const AppTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.showCounter = false,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    this.helperText,
    this.prefix,
    this.suffix,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.labelStyle ?? 
              theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
          ),
          SizedBox(height: AppCommonSizes.paddingXS),
        ],
        
        
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus,
          style: widget.textStyle ?? theme.textTheme.bodyMedium,
          
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ?? 
              theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            
            // Content padding
            contentPadding: widget.contentPadding ?? 
              EdgeInsets.symmetric(
                horizontal: AppCommonSizes.paddingM,
                vertical: AppCommonSizes.paddingM,
              ),
            
            // Fill color
            filled: true,
            fillColor: widget.fillColor ?? 
              theme.colorScheme.surface.withOpacity(0.8),
            
            // Prefix and suffix icons
            prefixIcon: widget.prefixIcon,
            prefix: widget.prefix,
            suffix: widget.suffix,
            suffixIcon: _buildSuffixIcon(),
            
            // Borders
            border: _buildBorder(context),
            enabledBorder: _buildBorder(context),
            focusedBorder: _buildFocusedBorder(context),
            errorBorder: _buildErrorBorder(context),
            focusedErrorBorder: _buildErrorBorder(context),
            disabledBorder: _buildDisabledBorder(context),
            
            // Counter
            counterText: widget.showCounter ? null : '',
            
            // Helper text
            helperText: widget.helperText,
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }

  /// Build suffix icon with password visibility toggle if needed
  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          size: AppCommonSizes.iconM,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  /// Build default border
  OutlineInputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppCommonSizes.borderRadiusM,
      ),
      borderSide: BorderSide(
        color: widget.borderColor ?? 
          Theme.of(context).colorScheme.outline.withOpacity(0.3),
        width: 1.0,
      ),
    );
  }

  /// Build focused border
  OutlineInputBorder _buildFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppCommonSizes.borderRadiusM,
      ),
      borderSide: BorderSide(
        color: widget.focusedBorderColor ?? 
          Theme.of(context).colorScheme.primary,
        width: 2.0,
      ),
    );
  }

  /// Build error border
  OutlineInputBorder _buildErrorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppCommonSizes.borderRadiusM,
      ),
      borderSide: BorderSide(
        color: widget.errorBorderColor ?? 
          Theme.of(context).colorScheme.error,
        width: 2.0,
      ),
    );
  }

  /// Build disabled border
  OutlineInputBorder _buildDisabledBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppCommonSizes.borderRadiusM,
      ),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        width: 1.0,
      ),
    );
  }
}

class AppTextFieldVariants {
  static AppTextField email({
    String? labelText,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      labelText: labelText,
      hintText: 'Enter your email',
      initialValue: initialValue,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      validator: validator ?? _defaultEmailValidator,
      onChanged: onChanged,
      enabled: enabled,
      prefixIcon: const Icon(Icons.email_outlined),
      textInputAction: TextInputAction.next,
    );
  }

  static AppTextField password({
    String? labelText,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      labelText: labelText,
      hintText: 'Enter your password',
      initialValue: initialValue,
      controller: controller,
      obscureText: true,
      validator: validator ?? _defaultPasswordValidator,
      onChanged: onChanged,
      enabled: enabled,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputAction: TextInputAction.done,
    );
  }

  /// Phone number text field
  static AppTextField phone({
    String? labelText,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      labelText: labelText,
      hintText: 'Enter your phone number',
      initialValue: initialValue,
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: validator ?? _defaultPhoneValidator,
      onChanged: onChanged,
      enabled: enabled,
      prefixIcon: const Icon(Icons.phone_outlined),
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }

  /// Search text field
  static AppTextField search({
    String? hintText,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool enabled = true,
  }) {
    return AppTextField(
      hintText: hintText ?? 'Search...',
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      prefixIcon: const Icon(Icons.search),
      textInputAction: TextInputAction.search,
    );
  }

  /// Multiline text field for descriptions/comments
  static AppTextField multiline({
    String? labelText,
    String? hintText,
    String? initialValue,
    TextEditingController? controller,
    int maxLines = 4,
    int? maxLength,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return AppTextField(
      labelText: labelText,
      hintText: hintText ?? 'Enter your message',
      initialValue: initialValue,
      controller: controller,
      maxLines: maxLines,
      minLines: 3,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
    );
  }

  // Default validators
  static String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? _defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? _defaultPhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}