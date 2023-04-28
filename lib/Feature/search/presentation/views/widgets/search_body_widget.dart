import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/search/presentation/views/widgets/post_widget.dart';
import 'package:instgrameclone/Feature/search/presentation/views/widgets/search_textFormField_widget.dart';

class SearchBodyWidget extends StatelessWidget {
  const SearchBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children:   const [
          SearchTextFormField(),
          Expanded(child: PostWidgetInSearchScreen()),
        ],
      ),
    );
  }
}


