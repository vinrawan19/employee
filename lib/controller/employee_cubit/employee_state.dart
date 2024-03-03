part of 'employee_cubit.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeSearch extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeEmpty extends EmployeeState {}

final class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> employeeData;
  final List<TreeNode> treeNodes;

  // final 
  EmployeeLoaded({
    required this.employeeData, 
    List<TreeNode>? treeNodes
  }) : treeNodes = treeNodes ?? [];

    EmployeeLoaded copyWith({
    List<EmployeeModel>? employeeData, 
    List<TreeNode>? treeNodes, 
    }) => 
      EmployeeLoaded(
        employeeData: employeeData ?? this.employeeData,
        treeNodes: treeNodes ?? this.treeNodes
      );
}

final class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError({required this.message});
}
