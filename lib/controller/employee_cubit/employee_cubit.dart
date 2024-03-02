import 'package:bloc/bloc.dart';
import 'package:employee_search/data/employee_data.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:meta/meta.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  void employeeInitial(){
    emit(EmployeeInitial());
    emit(EmployeeLoading());
    List<EmployeeModel> employeeData = EmployeeData.correctEmployee.map((e) => EmployeeModel.fromJson(e)).toList();
    emit(EmployeeLoaded(employeeData: employeeData));
  }
}
