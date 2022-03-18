import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nil/nil.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/delays.dart';

class AppTextField extends StatefulWidget {
  final void Function(String value)? onChanged;
  final String? hint;
  final String? labelText;
  final IconData? prefixIcon;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? maxLength;
  final bool showCounter;
  final bool autoFocus;
  final bool? enabled;
  final bool capitalize;
  final TextInputAction? action;
  final void Function(String value)? onDone;
  final FocusNode focusNode;
  final Widget? suffix;
  final List<TextInputFormatter>? formatters;
  final TextStyle textStyle;
  final VoidCallback? onEndEditing;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool border;
  final TextAlign? textAlign;
  final bool expand;
  final bool hideInput;
  final Color cursorColor;
  final Color? hintColor;
  final bool showCursor;
  final String initialValue;

  AppTextField({
    Key? key,
    this.onChanged,
    this.hint,
    this.labelText,
    this.maxLines = 1,
    this.prefixIcon,
    this.textInputType,
    this.controller,
    this.maxLength,
    this.showCounter = false,
    this.showCursor = true,
    this.autoFocus = false,
    this.enabled,
    this.capitalize = false,
    this.action,
    this.onDone,
    focusNode,
    this.suffix,
    this.formatters,
    textStyle,
    this.onEndEditing,
    this.onTap,
    this.readOnly,
    this.border = true,
    this.textAlign,
    this.expand = false,
    this.hideInput = false,
    this.cursorColor = AppColors.purple80,
    this.hintColor = AppColors.black60,
    this.initialValue = '',
  })  : textStyle = textStyle ?? AppTextStyles.medium16.apply(color: AppColors.black100),
        focusNode = focusNode ?? FocusNode(),
        super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  static const double bottomPadding = 2;

  Timer? _timer;
  TextEditingController? _inputController;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    this._inputController = widget.controller ?? TextEditingController();
    _inputController!.text = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.border ? AppColors.white20 : Colors.transparent,
        width: 0.7,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.labelText != null) ...[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.focusNode.requestFocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.labelText!,
                  style: AppTextStyles.regular12.apply(color: AppColors.black60),
                ),
                const SizedBox(height: 13),
              ],
            ),
          ),
        ],

        TextField(
          // For passwords
          obscureText: widget.hideInput,
          enableSuggestions: !widget.hideInput,
          autocorrect: !widget.hideInput,

          // Cursor
          showCursor: widget.showCursor,
          cursorColor: widget.cursorColor,

          readOnly: widget.readOnly ?? false,
          onTap: widget.onTap,
          textAlign: widget.textAlign ?? TextAlign.left,

          // Focus
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode,

          enabled: widget.enabled,
          onSubmitted: widget.onDone,
          scrollPadding: EdgeInsets.zero,
          expands: widget.expand,
          textCapitalization: widget.capitalize ? TextCapitalization.words : TextCapitalization.none,
          controller: _inputController,
          onChanged: (text) {
            widget.onChanged?.call(text);
            _timer?.cancel();
            _timer = Timer(Delays.delay500, () {
              if (mounted) {
                widget.onEndEditing?.call();
              }
            });
          },
          maxLength: widget.maxLength,
          inputFormatters: widget.formatters,
          maxLines: widget.expand ? null : widget.maxLines,
          minLines: widget.expand ? null : 1,
          style: widget.textStyle,
          keyboardType: widget.textInputType,
          textInputAction: widget.action,
          decoration: InputDecoration(
            focusColor: AppColors.white100,
            isDense: true,
            contentPadding: widget.border ? const EdgeInsets.only(bottom: bottomPadding) : EdgeInsets.zero,
            counter: widget.showCounter ? null : nil,
            counterStyle: AppTextStyles.medium16.apply(color: AppColors.black100),

            // Suffix/prefix
            suffixIcon: widget.suffix,
            suffixIconConstraints: widget.suffix != null ? const BoxConstraints(maxWidth: 26) : null,
            prefixIconConstraints: widget.prefixIcon != null ? const BoxConstraints(minWidth: 26) : null,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(
                      right: 8,
                      bottom: widget.border ? bottomPadding : 0,
                    ),
                    child: Icon(
                      widget.prefixIcon,
                      color: AppColors.black60,
                      size: 20,
                    ),
                  )
                : null,

            // Hint
            hintStyle: widget.textStyle.apply(color: widget.hintColor),
            hintText: widget.hint,

            // Border
            border: border,
            focusedBorder: border,
            enabledBorder: border,
          ),
        ),
      ],
    );
  }
}
