import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:employee_search/controller/employee_cubit/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            appBar: EasySearchBar(
                isFloating: true,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                openOverlayOnSearch: true,
                debounceDuration: const Duration(seconds: 1),
                suggestions: state is EmployeeLoaded ? state.employeeData.map((e) => e.name).toList() : [],
                title: const Text("Employee Search"), onSearch: (v) {},
              ),
            body: Builder(builder: (context) {
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
              }
              return Container();
            },),
          ),
        );
      },
    );
  }
}
