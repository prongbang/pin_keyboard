# pin_keyboard

A Pin Keyboard Flutter package.

![Screenshot](screenshot/pin_keyboard.png)

## Usage

```dart
PinKeyboard(
    length: 4,
    enableBiometric: true,
    iconBiometricColor: Colors.blue[400],
    onChange: (pin) {},
    onConfirm: (pin) {},
    onBiometric: () {},
)
```