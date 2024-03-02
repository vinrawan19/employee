import 'package:bloc/bloc.dart';
import 'package:employee_search/data/employee_data.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:flutter/cupertino.dart';
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
    return employeeDataSuggestions;
  }

  employeeSelected(EmployeeModel selectedEmployee){
    var currentState = state as EmployeeLoaded;

    List<TreeNode> root = [];
    List<EmployeeModel> employeeGrouping = [];
    emit(EmployeeLoading());
    while(true){
      EmployeeModel tempLoopEmployee = selectedEmployee;
      List<EmployeeModel> employeeNodes = currentState.employeeData.where((e) => e.managerId == tempLoopEmployee.managerId).toList();
      EmployeeModel manager = currentState.employeeData.firstWhere((e) => e.id == employeeNodes.first.managerId);
      if(tempLoopEmployee.managerId == null){
        employeeGrouping.add(tempLoopEmployee);
        for(var e in employeeGrouping){
          List<TreeNode> children = [];
          if(e.children != null){
            e.children!.map((e)=>children.add(TreeNode(content: Text(e.name))));
          }
          root.add(TreeNode(content: Text(e.name), children: children));
        }
        emit(currentState);
        return root;
      }
      employeeGrouping.add(EmployeeModel(id: manager.id, name: manager.name, managerId: manager.managerId, children: employeeNodes));
      tempLoopEmployee = manager;
    }
  }
}
