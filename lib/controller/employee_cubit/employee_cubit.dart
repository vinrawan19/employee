import 'package:bloc/bloc.dart';
import 'package:employee_search/data/employee_data.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

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
    List<TreeNode> root = [];
    emit(EmployeeLoading());
    EmployeeModel? tempLoopEmployee = selectedEmployee;
    while(true){
      List<EmployeeModel> employeeGrouping = currentState.employeeData.where((e) => e.managerId == tempLoopEmployee!.managerId).toList();
      EmployeeModel? manager = currentState.employeeData.firstWhereOrNull((e) => e.id == employeeGrouping.first.managerId);
      if(manager != null){
        tempLoopEmployee = currentState.employeeData.firstWhereOrNull((e) => e.id == manager.managerId);
        manager.children.addAll(employeeGrouping);
        root.add(TreeNode(
          content: Text(manager.name),
          children: manager.children.map((e) => TreeNode(content: Text(e.name))).toList()
        ));
        if(tempLoopEmployee == null){
          emit(currentState.copyWith(treeNodes: root));
          break;
        }
      }else{
        emit(currentState.copyWith(treeNodes: root));
        break;
      }
    }
  }
}
