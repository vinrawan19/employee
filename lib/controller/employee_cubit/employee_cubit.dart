import 'package:bloc/bloc.dart';
import 'package:employee_search/data/employee_data.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:employee_search/util/employee_util.dart';
import 'package:employee_search/util/tree_node_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
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

  employeeSearch(String keyword){
    var currentState = state as EmployeeLoaded;
    emit(EmployeeLoading());
    List<EmployeeModel> employeeDataSuggestions = currentState.employeeData.where((e) => e.name.contains(keyword.toLowerCase())).toList();
    emit(currentState);
    return employeeDataSuggestions;
  }

employeeSelected(EmployeeModel selectedEmployee){
  var currentState = state as EmployeeLoaded;
  emit(EmployeeLoading());
  List<EmployeeModel> employeeDataCopy = currentState.employeeData.map((employee) => employee.deepCopy()).toList();

  EmployeeModel result = EmployeeUtil.sort(employeeDataCopy, selectedEmployee);

  TreeNode treeNode = TreeNodeUtil.render(result);

  emit(EmployeeLoaded(employeeData: currentState.employeeData, treeNodes: [treeNode]));
}
}

