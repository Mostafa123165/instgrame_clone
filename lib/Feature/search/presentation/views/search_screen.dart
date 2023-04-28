import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_cubit.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_state.dart';
import 'package:instgrameclone/Feature/search/presentation/views/widgets/search_body_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SearchBodyWidget(),
          );
        },
      ),
    );
  }
}
