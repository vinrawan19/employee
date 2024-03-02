import 'package:employee_search/controller/employee_cubit/employee_cubit.dart';
import 'package:employee_search/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TypeAheadField<EmployeeModel>(
                    suggestionsCallback: (search) => context.read<EmployeeCubit>().employeeSearch(search),
                    onSelected: (value) => {}, 
                    itemBuilder: (context, value) {
                      return ListTile(
                        title: Text(value.name),
                        subtitle: Text("ID: ${value.id}"),
                      );
                    },
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Employee'
                        ),
                      );
                    },
                  ),
                  Builder(builder: (context) {
                    if(state is EmployeeLoading){
                      return Center(
                        child: SizedBox(
                          height: 10.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.horizontalRotatingDots(color: Colors.blue, size: 7.h),
                              const Text("Please wait, loading your data!")
                            ],
                          ),
                        ),
                      );
                    }else if(state is EmployeeLoaded){
                      return SingleChildScrollView(
                        child: Container(
                          height: 70.h,
                          child: TreeView(
                            nodes: context.read<EmployeeCubit>().employeeSelected(state.employeeData.last),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
