part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable{

const NotificationEvent();

@override
List<Object> get props => [];

}

class NotificationAndPermissionEvent extends NotificationEvent{
 
 final NotificationModel? notificationModel;
  
 const NotificationAndPermissionEvent({ required this.notificationModel});

  
}