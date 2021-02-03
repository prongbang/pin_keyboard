library pin_keyboard;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PinKeyboard extends StatefulWidget {
  final double space;
  final int length;
  final double maxWidth;
  final void Function(String) onChange;
  final void Function(String) onConfirm;
  final VoidCallback onBiometric;
  final bool enableBiometric;
  final Widget iconBiometric;
  final Widget iconBackspace;
  final Color iconBackspaceColor;
  final Color iconBiometricColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const PinKeyboard(
      {Key key,
      this.space = 63,
      @required this.length,
      @required this.onChange,
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
      this.iconBackspace})
      : super(key: key);

  @override
  _PinKeyboardState createState() => _PinKeyboardState();
}

class _PinKeyboardState extends State<PinKeyboard> {
  String _pinCode = "";

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
                _createNumber("1", _handleTabNumber),
                Spacer(),
                _createNumber("2", _handleTabNumber),
                Spacer(),
                _createNumber("3", _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createNumber("4", _handleTabNumber),
                Spacer(),
                _createNumber("5", _handleTabNumber),
                Spacer(),
                _createNumber("6", _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createNumber("7", _handleTabNumber),
                Spacer(),
                _createNumber("8", _handleTabNumber),
                Spacer(),
                _createNumber("9", _handleTabNumber),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createBiometricIcon(),
                Spacer(),
                _createNumber("0", _handleTabNumber),
                Spacer(),
                _createBackspaceIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _createNumber(String number, void Function(String) onPress) => InkWell(
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

  Widget _createImage(Widget icon, void Function() onPress) => InkWell(
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

  void _handleTabNumber(String number) {
    if (_pinCode.length < widget.length) {
      _pinCode += number;
      if (widget.onChange != null) {
        widget.onChange(_pinCode);
      }
      if (_pinCode.length == widget.length) {
        if (widget.onConfirm != null) {
          widget.onConfirm(_pinCode);
        }
        _pinCode = "";
      }
    }
  }

  void _handleTabBiometric() {
    if (widget.onBiometric != null) {
      widget.onBiometric();
    }
  }

  void _handleTabBackspace() {
    if (_pinCode.length > 0) {
      _pinCode = _pinCode.substring(0, _pinCode.length - 1);
      if (widget.onChange != null) {
        widget.onChange(_pinCode);
      }
    }
  }

  Widget _createBiometricIcon() {
    if (widget.enableBiometric) {
      return _createImage(
        widget.iconBiometric ??
            SvgPicture.asset(
              "assets/icons/biometric.svg",
              package: "pin_keyboard",
              color: widget.iconBiometricColor ?? Color(0xff6f6f6f),
            ),
        _handleTabBiometric,
      );
    } else {
      return SizedBox(
        height: widget.space,
        width: widget.space,
      );
    }
  }

  Widget _createBackspaceIcon() => _createImage(
        widget.iconBackspace ??
            SvgPicture.asset(
              "assets/icons/backspace.svg",
              package: "pin_keyboard",
              color: widget.iconBackspaceColor ?? Color(0xff6f6f6f),
            ),
        _handleTabBackspace,
      );
}
