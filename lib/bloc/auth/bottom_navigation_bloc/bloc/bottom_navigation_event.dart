// // import 'package:meta/meta.dart';
// // import 'package:equatable/equatable.dart';

// // abstract class BottomNavigationEvent extends Equatable {
// //   BottomNavigationEvent([List props = const []]) : super();
// // }

// // abstract class AppStarted extends BottomNavigationEvent {
// //   @override
// //   String toString() => 'AppStarted';
// // }

// // abstract class PageTapped extends BottomNavigationEvent {
// //   final int index;

// //   PageTapped({required this.index}) : super([index]);

// //   @override
// //   String toString() => 'PageTapped: $index';
// // }


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class BottomNavigationEvent extends Equatable{
  const BottomNavigationEvent();
  @override
  List<Object> get props => [];

  }


  class AppStarted extends BottomNavigationEvent{

    @override
    String toString()=> 'AppStarted';
  }

  class PageTapped extends BottomNavigationEvent{
    late final int index;
    PageTapped({required this.index});

    @override
    String toString() =>'PageTapped $index';
  }