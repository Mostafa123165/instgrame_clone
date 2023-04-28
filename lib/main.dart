import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/Authorization/data/entities.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/login/login_cubit.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/login_screen.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/chats/presentation/controller/chat_cubit.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_cubit.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/views/home_screen.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_cubit.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/local_data_base/cash_helper.dart';
import 'package:instgrameclone/core/themes/ligth_theme.dart';
import 'package:instgrameclone/core/uttils/BlocOpserver.dart';



late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  await getLocalDatebase();
  await setNotification();
  bool login = UserResult.data!.token.isNotEmpty ;
  Widget initialScreen = const LoginScreen() ;
  if(login) {
    initialScreen = HomeScreen() ;
  }

  runApp(MyApp(initialScreen: initialScreen,)) ;
}



class MyApp extends StatelessWidget {
   MyApp({Key? key , required this.initialScreen}) : super(key: key);
  Widget initialScreen ;


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        _configureFCM();
        return  MultiBlocProvider(
          providers: [
            BlocProvider( create: (BuildContext context) => LoginCubit(),),
            BlocProvider( create: (BuildContext context) => FeedCubit(),),
            BlocProvider( create: (BuildContext context) => AddPostCubit(),),
            BlocProvider( create: (BuildContext context) => ProfileCubit(),),
            BlocProvider( create: (BuildContext context) => HomeCubit(),),
            BlocProvider( create: (BuildContext context) => ChatCubit(),),
            BlocProvider( create: (BuildContext context) => SearchCubit(),),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: lightTheme,
            home: initialScreen,
          ),
        );
      },
    );
  }
}


void _configureFCM() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('onMessage: $message');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  });
}

Future getLocalDatebase() async {
  UserResult.data = UserEntities(
    token: CashHelper.getDate(key: 'token') ?? '',
    image: CashHelper.getDate(key: 'image') ?? '',
    bio: CashHelper.getDate(key: 'bio') ?? '',
    cover: CashHelper.getDate(key: 'cover') ?? '',
    email: CashHelper.getDate(key: 'email') ?? '',
    name: CashHelper.getDate(key: 'name') ?? '',
    phone: CashHelper.getDate(key: 'phone') ?? '',
    verify: CashHelper.getDate(key: 'verify') ?? false,
  );
}

Future setNotification() async{

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:  'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


}

