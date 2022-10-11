abstract class SochialLoginState {}

class SochialLoginInitialState extends SochialLoginState {}

class SochialLoginLoadingState extends SochialLoginState {}

class SochialLoginSuccessState extends SochialLoginState {}

class SochialLoginErorrState extends SochialLoginState {
  final String? Erorr;
  SochialLoginErorrState(this.Erorr);
}

class SochialLoginChangeOserctorAndIconState extends SochialLoginState {}
