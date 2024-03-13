import 'package:employee_search/model/employee_model.dart';

class EmployeeUtil{
static EmployeeModel sort(List<EmployeeModel> dataEmployee, EmployeeModel employee, {EmployeeModel? empState}) {
    List<EmployeeModel> sortedDataEmployee = List<EmployeeModel>.from(dataEmployee);

    EmployeeModel selectedEmployee = employee;
    List<EmployeeModel> identicalManagerEmployee = [];
    EmployeeModel? employeeState = empState;
    EmployeeModel selectedEmployeeManager = sortedDataEmployee.firstWhere((e) => e.id == selectedEmployee.managerId);
    
    // START GROUP IDENTICAL MANAGER
    for(var e in sortedDataEmployee){
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
      employeeState = sort(sortedDataEmployee, selectedEmployeeManager, empState: employeeState);
    }
    // END CHECK UPPER HIERARCHY
    
    return employeeState;
}
}