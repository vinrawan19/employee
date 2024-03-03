import 'package:bloc/bloc.dart';
import 'package:employee_search/data/employee_data.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    emit(EmployeeLoading());
    EmployeeModel result = employeeDataSort(currentState.employeeData, selectedEmployee);
    print(result);
  }

  EmployeeModel employeeDataSort(List<EmployeeModel> dataEmployee, EmployeeModel employee, {EmployeeModel? empState}) {
    EmployeeModel selectedEmployee = employee;
    List<EmployeeModel> identicalManagerEmployee = [];
    EmployeeModel? employeeState = empState;
    EmployeeModel selectedEmployeeManager = dataEmployee.firstWhere((e) => e.id == selectedEmployee.managerId);
    
    // START GROUP IDENTICAL MANAGER
    for(var e in dataEmployee){
      if(e.managerId == selectedEmployee.managerId){
        if(e.id == selectedEmployee.id){
          e.isDirectReport = true;
        }
        identicalManagerEmployee.add(e);
      }
    }
    selectedEmployeeManager.isDirectReport = true;
    selectedEmployeeManager.children.addAll(identicalManagerEmployee);
    // END GROUP IDENTICAL MANAGER

    // START UPDATING STATE
    employeeState = selectedEmployeeManager;
    // END UPDATING STATE

    // START CHECK UPPER HIERARCHY
    if(selectedEmployeeManager.managerId != null){
      employeeState = employeeDataSort(dataEmployee, selectedEmployeeManager, empState: employeeState);
    }
    // END CHECK UPPER HIERARCHY
    
    return employeeState;
  }
}

