
import 'package:equatable/equatable.dart';

// this is my_list Assets
// ignore: must_be_immutable
class InformationAboutImageInPost extends Equatable{
  late  String file ;
  late   bool choice ;
  late  int numOfChoice ;
  late  int indexInListChoice ;

   InformationAboutImageInPost({required this.file,required this.choice,required this.numOfChoice , required this.indexInListChoice});

  @override
  List<Object?> get props => [
    file , choice , numOfChoice ,indexInListChoice ,
  ] ;
}

// this is my_list Choice in posts
// ignore: must_be_immutable
class InformationAboutChoiceImageInPost extends Equatable{
  late  String file ;
  late  int indexInAssets ;

  InformationAboutChoiceImageInPost({required this.file, required this.indexInAssets});

  @override
  List<Object?> get props => [
    file , indexInAssets ,
  ] ;
}

