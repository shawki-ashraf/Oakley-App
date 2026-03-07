import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/profile/data/deleteAccount.dart';
import 'package:furneture_app/fetures/profile/model/order_repo.dart';
import 'package:furneture_app/fetures/profile/model/OrdershistoryModel.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo authRepo = AuthRepo();
  final OrderRepo orderRepo = OrderRepo();
  User? currentUser;

  ProfileCubit() : super(ProfileInitial());
  Future<void> deleteAccount(String password) async {
    emit(Deleteloding());
    try {
      await authRepo.deleteAccount(password);
      emit(Deleteloaded());
    } catch (e) {
      emit((DeleteError(msg: e.toString())));
    }
  }

  void listenOrders() {
    emit(Ordersloding());
    orderRepo.getUserOrders().listen((orders) {
      emit(Ordersloaded(orders: orders));
    }, onError: (e) => emit(OrdersError(msg: e.toString())));
  }

  Future<void> logout() async {
    emit(Logoutloding());
    await FirebaseAuth.instance.signOut();
    currentUser = null;
    emit(Logoutloaded());
  }
}
