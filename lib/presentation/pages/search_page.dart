import 'package:api_study/presentation/widgets/home_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _showCancel = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _showCancel = !_showCancel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        title: Text(
          'Pesquisar',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              // height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Pesquise seus filmes favoritos...',
                      ),
                      onSubmitted: (value) {},
                    ),
                  ),
                  AnimatedCrossFade(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 250),
                    firstChild: TextButton(
                      onPressed: () => _focusNode.unfocus(),
                      child: const Text('Cancelar'),
                    ),
                    secondChild: const SizedBox(),
                    crossFadeState: _showCancel
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
