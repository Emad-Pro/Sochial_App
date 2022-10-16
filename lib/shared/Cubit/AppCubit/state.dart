abstract class socialStates {}

class socialInitialState extends socialStates {}

class socialGetUserLoadingState extends socialStates {}

class socialGetUserSuccessState extends socialStates {}

class socialGetUserErorrState extends socialStates {
  final String? Erorr;

  socialGetUserErorrState(this.Erorr);
}

class socialChangebuttomNavState extends socialStates {}
