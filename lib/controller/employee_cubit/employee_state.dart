part of 'employee_cubit.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeSearch extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeEmpty extends EmployeeState {}

final class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> employeeData;

  // final 
  EmployeeLoaded({required this.employeeData});

    EmployeeLoaded copyWith({
    List<EmployeeModel>? employeeData, 
    }) => 
      EmployeeLoaded(
        employeeData: employeeData ?? this.employeeData,
      );
}

final class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError({required this.message});
}
