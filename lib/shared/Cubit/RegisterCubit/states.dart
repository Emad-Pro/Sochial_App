abstract class SochialRegisterState {}

class SochialRegisterInitialState extends SochialRegisterState {}

class SochialRegisterLoadingState extends SochialRegisterState {}

class SochialRegisterSuccessState extends SochialRegisterState {}

class SochialRegisterErorrState extends SochialRegisterState {
  final Erorr;
  SochialRegisterErorrState(this.Erorr);
}

class SochialRegisterChangeOserctorAndIconState extends SochialRegisterState {}

class SochialRegisterCheckInternet extends SochialRegisterState {}
