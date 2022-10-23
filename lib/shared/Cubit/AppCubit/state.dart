abstract class socialStates {}

class socialInitialState extends socialStates {}

class socialGetUserLoadingState extends socialStates {}

class socialGetUserSuccessState extends socialStates {}

class socialGetUserErorrState extends socialStates {
  final String? Erorr;

  socialGetUserErorrState(this.Erorr);
}

class socialChangebuttomNavState extends socialStates {}

class socialChangeDateState extends socialStates {}

class socialProfileImagePickedSuccessState extends socialStates {}

class socialProfileImagePickedErorrState extends socialStates {}

class socialProfileCoverPickedSuccessState extends socialStates {}

class socialProfileCoverPickedErorrState extends socialStates {}
