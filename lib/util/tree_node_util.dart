import 'package:employee_search/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:uuid/uuid.dart';

class TreeNodeUtil{
  static TreeNode render(EmployeeModel sortedEmployee){
    EmployeeModel sortedEmployeeData = sortedEmployee;
    List<TreeNode> groupedEmployeeNode = [];
    late TreeNode treeState;
    for(var i in sortedEmployeeData.children){
      groupedEmployeeNode.add(render(i));
    }
    treeState = TreeNode(
      key: Key(const Uuid().v1()),
      content: Container(
        color: sortedEmployee.isDirectReport ? Colors.greenAccent : null,
        child: Text(sortedEmployee.name)),
      children: groupedEmployeeNode
    );
    return treeState;
  }
}