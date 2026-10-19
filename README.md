# yecontinuity

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Fluxo:
 Fluxo da App
 1.º arranque     splash → onboarding → welcome → register/login → home
 Voltas (sem sessão)  splash → welcome → login → home
 Voltas (com sessão)  splash → home
 Logout               qualquer ecrã da app → welcome
 Ninguém navega à mão depois de um login/registo/logout: o estado do
 `authProvider` muda e o `redirect` abaixo leva o utilizador ao sítio certo.