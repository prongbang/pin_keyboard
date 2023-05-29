library pin_keyboard;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_keyboard/pin_keyboard_controller.dart';

class PinKeyboard extends StatefulWidget {
  final double space;
  final int length;
  final double maxWidth;
  final void Function(String)? onChange;
  final void Function(String)? onConfirm;
  final VoidCallback? onBiometric;
  final bool enableBiometric;
  final Widget? iconBiometric;
  final Widget? iconBackspace;
  final Color? iconBackspaceColor;
  final Color? iconBiometricColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final PinKeyboardController? controller;

  const PinKeyboard({
    Key? key,
    this.space = 63,
    required this.length,
    required this.onChange,
    this.onConfirm,
    this.onBiometric,
    this.enableBiometric = false,
    this.iconBiometric,
    this.maxWidth = 350,
    this.iconBackspaceColor,
    this.iconBiometricColor,
    this.textColor,
    this.fontSize = 30,
    this.fontWeight = FontWeight.bold,
    this.iconBackspace,
    this.controller,
  }) : super(key: key);

  @override
  _PinKeyboardState createState() => _PinKeyboardState();
}

class _PinKeyboardState extends State<PinKeyboard> {
  String _pinCode = '';

  @override
  void initState() {
    _restListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        maxWidth: widget.maxWidth,
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NumberWidget(
                  widget: widget,
                  number: '1',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '2',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '3',
                  onPress: _handleTabNumber,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NumberWidget(
                  widget: widget,
                  number: '4',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '5',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '6',
                  onPress: _handleTabNumber,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NumberWidget(
                  widget: widget,
                  number: '7',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '8',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '9',
                  onPress: _handleTabNumber,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BiometricIconWidget(
                  widget: widget,
                  onPress: _handleTabBiometric,
                ),
                Spacer(),
                _NumberWidget(
                  widget: widget,
                  number: '0',
                  onPress: _handleTabNumber,
                ),
                Spacer(),
                _BackspaceIconWidget(
                  widget: widget,
                  onPress: _handleTabBackspace,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleTabNumber(String number) {
    if (_pinCode.length < widget.length) {
      _pinCode += number;
      if (widget.onChange != null) {
        widget.onChange!(_pinCode);
      }
      if (_pinCode.length == widget.length) {
        if (widget.onConfirm != null) {
          widget.onConfirm!(_pinCode);
        }
        if (widget.controller == null) {
          _pinCode = '';
        }
      }
    }
  }

  void _handleTabBiometric() {
    if (widget.onBiometric != null) {
      widget.onBiometric!();
    }
  }

  void _handleTabBackspace() {
    if (_pinCode.length > 0) {
      _pinCode = _pinCode.substring(0, _pinCode.length - 1);
      if (widget.onChange != null) {
        widget.onChange!(_pinCode);
      }
    }
  }

  void _restListener() {
    widget.controller?.addResetListener(() {
      _pinCode = '';
      if (widget.onChange != null) {
        widget.onChange!('');
      }
    });
  }
}

class _BackspaceIconWidget extends StatelessWidget {
  final PinKeyboard widget;
  final VoidCallback onPress;

  const _BackspaceIconWidget({
    Key? key,
    required this.widget,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _ImageWidget(
        widget: widget,
        icon: widget.iconBackspace ??
            SvgPicture.asset(
              'assets/icons/backspace.svg',
              package: 'pin_keyboard',
              colorFilter: (widget.iconBackspaceColor != null)
                  ? ColorFilter.mode(
                      widget.iconBackspaceColor!,
                      BlendMode.srcIn,
                    )
                  : ColorFilter.mode(
                      Color(0xff6f6f6f),
                      BlendMode.srcIn,
                    ),
            ),
        onPress: onPress,
      );
}

class _BiometricIconWidget extends StatelessWidget {
  final PinKeyboard widget;
  final VoidCallback onPress;

  const _BiometricIconWidget({
    Key? key,
    required this.widget,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (widget.enableBiometric) {
      return _ImageWidget(
        widget: widget,
        icon: widget.iconBiometric ??
            SvgPicture.asset(
              'assets/icons/biometric.svg',
              package: 'pin_keyboard',
              colorFilter: (widget.iconBiometricColor != null)
                  ? ColorFilter.mode(
                      widget.iconBiometricColor!,
                      BlendMode.srcIn,
                    )
                  : ColorFilter.mode(Color(0xff6f6f6f), BlendMode.srcIn),
            ),
        onPress: onPress,
      );
    } else {
      return SizedBox(
        height: widget.space,
        width: widget.space,
      );
    }
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key? key,
    required this.widget,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final PinKeyboard widget;
  final Widget icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) => InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.space),
        ),
        child: Container(
          height: widget.space,
          width: widget.space,
          child: Center(child: icon),
        ),
        onTap: () {
          onPress();
        },
      );
}

class _NumberWidget extends StatelessWidget {
  const _NumberWidget({
    Key? key,
    required this.widget,
    required this.number,
    required this.onPress,
  }) : super(key: key);

  final PinKeyboard widget;
  final String number;
  final void Function(String p1) onPress;

  @override
  Widget build(BuildContext context) => InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.space),
        ),
        child: Container(
          height: widget.space,
          width: widget.space,
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.textColor ?? Color(0xff6f6f6f),
                fontWeight: widget.fontWeight,
              ),
            ),
          ),
        ),
        onTap: () {
          onPress(number);
        },
      );
}
