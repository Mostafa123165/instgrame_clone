import 'package:equatable/equatable.dart';
import 'package:instgrameclone/Feature/Authorization/data/entities.dart';

class UserResult extends Equatable{
  static UserEntities? data ;
  static bool? hasError ;

  @override
  List<Object?> get props => [
    data,
  ] ;
}