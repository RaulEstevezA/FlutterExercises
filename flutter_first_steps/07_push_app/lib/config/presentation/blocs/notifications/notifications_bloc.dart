import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  
  NotificationsBloc() : super(const NotificationsState() ) {
    on<NotificationsStatusChanged>(_notificationStatusChanged);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones Foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFirebaseNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

  void _notificationStatusChanged (NotificationsStatusChanged event, Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        status: event.status
      )
    );
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationsStatusChanged(status: settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void _handleRemoteMessage( RemoteMessage message ) {
    print('todo bien');
    print('mensaje data ${message.data}');
    if(message.notification == null) return;

    print('mensaje continene ${message.notification}');
  }

  void _onForegroundMessage(){
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true
    );

    add(NotificationsStatusChanged(status: settings.authorizationStatus));

  }

  


}
