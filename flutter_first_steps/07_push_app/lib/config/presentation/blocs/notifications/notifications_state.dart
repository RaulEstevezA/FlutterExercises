part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  //TODO: Crear mi modelo de notificaciones

  final List<dynamic> notifications;

  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined, 
    this.notifications = const[]}
  );
  
  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}
