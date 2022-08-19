// // import 'package:meta/meta.dart';
// // import 'package:equatable/equatable.dart';

// // @immutable
// // abstract class BottomNavigationState extends Equatable {
// //   BottomNavigationState([List props = const []]) : super();
// // }

// // abstract class CurrentIndexChanged extends BottomNavigationState {
// //   final int currentIndex;

// //   CurrentIndexChanged({required this.currentIndex}) : super([currentIndex]);

// //   @override
// //   String toString() => 'CurrentIndexChanged to $currentIndex';
// // }

// // abstract class PageLoading extends BottomNavigationState {
// //   @override
// //   String toString() => 'PageLoading';
// // }

// // abstract class TaskPageLoaded extends BottomNavigationState {
// //   final String text;

// //   TaskPageLoaded({required this.text}) : super([text]);

// //   @override
// //   String toString() => 'FirstPageLoaded with text: $text';
// // }

// // abstract class TaskListPageLoaded extends BottomNavigationState {
// //   final String text;

// //   TaskListPageLoaded({required this.text}) : super([text]);

// //   @override
// //   String toString() => 'SecondPageLoaded with number: 


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BottomNavigationState extends Equatable{
  const BottomNavigationState();
  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState{
  late final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

@override
String toString() => 'CurrentIndexChanged to $currentIndex';


}

class PageLoading extends BottomNavigationState{
  @override
  String toString() => 'PageLoading';
}


class TaskPageLoaded extends BottomNavigationState{
  late final text;
  TaskPageLoaded({required this.text});
  @override
  String toString() => 'TaskPageLoaded';
}


class TaskListPageLoaded extends BottomNavigationState{
  late final text;
  TaskListPageLoaded({required this.text});
  @override
  String toString() => 'TaskListPageLoaded';
}






