import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  void employeeInitial(){
    emit(EmployeeInitial());
    emit(EmployeeLoading());
    
  }
}
