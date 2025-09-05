# Projeto Flutter 🌟

Exercícios de Flutter para treino!

## Criar Projeto Flutter 🛠️

1. Verifique o Flutter:  
   ```bash
   flutter doctor
   ```

2. Crie o projeto:  
   ```bash
   flutter create nome_do_projeto
   ```

3. Acesse o diretório:  
   ```bash
   cd nome_do_projeto
   ```

4. Execute:  
   ```bash
   flutter run
   ```

## Configurar Google Fonts 🌈

1. Adicione no `pubspec.yaml`:  
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     google_fonts: ^6.2.1
   ```

2. Atualize dependências:  
   ```bash
   flutter pub get
   ```

3. Use no código (`lib/main.dart`):  
   ```dart
   import 'package:google_fonts/google_fonts.dart';

   Text(
     'Texto com Google Fonts',
     style: GoogleFonts.roboto(fontSize: 24),
   ),
   ```

## Executar 🏃‍♀️

```bash
flutter run
```

