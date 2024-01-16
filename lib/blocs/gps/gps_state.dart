part of 'gps_bloc.dart';


class GpsState extends Equatable{

  final GpsModel? gpsModel;
 

  const GpsState({
    this.gpsModel
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted, required gpsModel,
  }) => GpsState(
    gpsModel: gpsModel?? gpsModel
  );

  @override
  List<Object?> get props => [ gpsModel ];
}


