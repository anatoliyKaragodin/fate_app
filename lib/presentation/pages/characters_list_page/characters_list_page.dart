import 'package:fate_app/presentation/widgets/character_page/character_page_body_widget.dart';
import 'package:flutter/material.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainCharacterBodyWidget(),
      
    );
  }
}
