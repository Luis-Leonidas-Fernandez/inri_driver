part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isLoadedIcon;
  final bool isMapInitialized;
  final bool isfollowingUser;
 

  const MapState({
    this.isMapInitialized= false,
    this.isfollowingUser = true,
    this.isLoadedIcon     = false,
   
    });


  MapState copyWith({
    bool? isMapInitialized,
    bool? isfollowingUser,
    bool? isLoadedIcon,
   

  })
   => MapState(
     isMapInitialized: isMapInitialized ?? this.isMapInitialized,
     isfollowingUser: isfollowingUser ?? this.isfollowingUser,
     isLoadedIcon: isLoadedIcon ?? this.isLoadedIcon,
    
   );
  
  @override
  List<Object> get props => [isMapInitialized, isfollowingUser, isLoadedIcon,  ];
}


