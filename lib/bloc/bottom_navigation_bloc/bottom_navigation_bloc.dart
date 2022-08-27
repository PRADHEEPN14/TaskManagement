// // class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
// //   final FirstPageRepository firstPageRepository;
// //   final SecondPageRepository secondPageRepository;
// //   int currentIndex = 0;

// //   BottomNavigationBloc({
// //     this.firstPageRepository,
// //     this.secondPageRepository
// //   }) : assert(firstPageRepository != null),
// //         assert(secondPageRepository != null);

// //   @override
// //   BottomNavigationState get initialState => PageLoading();

// //   @override
// //   Stream<BottomNavigationState> mapEventToState(BottomNavigationEvent event) async* {
// //     if (event is AppStarted) {
// //       this.dispatch(PageTapped(index: this.currentIndex));
// //     }
// //     if (event is PageTapped) {
// //       this.currentIndex = event.index;
// //       yield CurrentIndexChanged(currentIndex: this.currentIndex);
// //       yield PageLoading();

// //       if (this.currentIndex == 0) {
// //         String data = await _getFirstPageData();
// //         yield FirstPageLoaded(text: data);
// //       }
// //       if (this.currentIndex == 1) {
// //         int data = await _getSecondPageData();
// //         yield SecondPageLoaded(number: data);
// //       }
// //     }
// //   }

// //   Future<String> _getFirstPageData() async {
// //     String data = firstPageRepository.data;
// //     if (data == null) {
// //       await firstPageRepository.fetchData();
// //       data = firstPageRepository.data;
// //     }
// //     return data;
// //   }

// //   Future<int> _getSecondPageData() async {
// //     int data = secondPageRepository.data;
// //     if (data == null) {
// //       await secondPageRepository.fetchData();
// //       data = secondPageRepository.data;
// //     }
// //     return data;
// //   }
// // }


import 'package:bloc/bloc.dart';
// import 'package:bloc_auth/bloc/auth/bottom_navigation_bloc/bloc/bottom_navigation_event.dart';
// import 'package:bloc_auth/bloc/auth/bottom_navigation_bloc/bloc/bottom_navigation_state.dart';
import 'package:bloc_auth/bloc/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:bloc_auth/bloc/bottom_navigation_bloc/bottom_navigation_state.dart';
import 'package:bloc_auth/data/repositories/task_list_repository.dart';
import 'package:bloc_auth/data/repositories/task_repository.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationState,BottomNavigationState>{
  BottomNavigationBloc({required this.taskPageRepository, required this.tasklistPageRepository})
  :assert(taskPageRepository != null),
  assert(tasklistPageRepository !=null),super(PageLoading());
  final TaskPageRepository taskPageRepository;
  final TaskListRepository tasklistPageRepository;
  int currentIndex = 0;

@override
 Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    // if (event is AppStarted) {
    //   this.add(PageTapped(index: this.currentIndex));
    // }
    if(event is PageTapped){
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if(this.currentIndex ==0){
        String data = await _getTaskPageData();
        yield TaskPageLoaded( text: state.toString());
      }

       if(this.currentIndex ==1){
        String data = await _getTasklistPageData();
        yield TaskListPageLoaded(text: state.toString());
      }

    }
  }

  Future<String> _getTaskPageData() async {
    String data = taskPageRepository.data;
    if (data == null) {
      await taskPageRepository.fetchdata();
      data = taskPageRepository.data;
    }
    return data;
  }

Future<String> _getTasklistPageData() async {
    String data = tasklistPageRepository.data;
    if (data == null) {
      await tasklistPageRepository.fetchdata();
      data = tasklistPageRepository.data;
    }
    return data;
  }


}
