import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';
import 'package:uebersetzer/features/history/domain/usecases/add_search_record_usecase.dart'
as add;
import 'package:uebersetzer/features/history/domain/usecases/clear_search_history_usecase.dart'
as clear;
import 'package:uebersetzer/features/history/domain/usecases/delete_search_record_usecase.dart'
as delete;
import 'package:uebersetzer/features/history/domain/usecases/get_search_history_usecase.dart'
as get_usecase;

part 'search_history_event.dart';

part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final get_usecase.GetSearchHistoryUseCase getSearchHistoryUseCase;
  final add.AddSearchRecordUseCase addSearchRecordUseCase;
  final delete.DeleteSearchRecordUseCase deleteSearchRecordUseCase;
  final clear.ClearSearchHistoryUseCase clearSearchHistoryUseCase;

  SearchHistoryBloc({
    @required this.getSearchHistoryUseCase,
    @required this.addSearchRecordUseCase,
    @required this.deleteSearchRecordUseCase,
    @required this.clearSearchHistoryUseCase,
  });

  @override
  Stream<SearchHistoryState> mapEventToState(SearchHistoryEvent event,) async* {
    if (event is GetSearchHistoryEvent) {
      yield* getSearchHistory(event);
    } else if (event is AddSearchRecordEvent) {
      yield* addSearchRecord(event);
    } else if (event is DeleteSearchRecordEvent) {
      yield* deleteSearchRecord(event);
    } else if (event is ClearSearchHistoryEvent) {
      yield* clearSearchHistory(event);
    }
  }

  Stream<SearchHistoryState> getSearchHistory(
      GetSearchHistoryEvent event) async* {
    yield SearchHistoryLoading();
    final result = await getSearchHistoryUseCase(NoParams());
    yield* result.fold(
          (failure) async* {
        yield SearchHistoryError(message: 'Unknown error has occurred.');
      },
          (historyList) async* {
        if (historyList.isEmpty) {
          yield SearchHistoryEmpty();
        } else {
          yield SearchHistoryLoaded(history: historyList);
        }
      },
    );
  }

  Stream<SearchHistoryState> addSearchRecord(
      AddSearchRecordEvent event) async* {
    final result = await addSearchRecordUseCase(add.Params(query: event.query));
    yield* result.fold((l) async* {
      yield SearchHistoryError(message: 'Unknown error has occurred.');
    }, (r) async* {
      // We need to load the new search records and emit a new state
      final historyResult = await getSearchHistoryUseCase(NoParams());
      yield* historyResult.fold((failure) async* {
        yield SearchHistoryError(message: 'Unknown error has occurred.');
      }, (historyList) async* {
        if (historyList.isEmpty) {
          yield SearchHistoryEmpty();
        } else {
          yield SearchHistoryLoaded(history: historyList);
        }
      });
    });
  }

  Stream<SearchHistoryState> deleteSearchRecord(
      DeleteSearchRecordEvent event) async* {
    final result =
    await deleteSearchRecordUseCase(delete.Params(id: event.id));
    yield* result.fold((l) async* {
      yield SearchHistoryError(message: 'Unknown error has occurred.');
    }, (r) async* {
      // We need to load the new search records and emit a new state
      final historyResult = await getSearchHistoryUseCase(NoParams());
      yield* historyResult.fold((failure) async* {
        yield SearchHistoryError(message: 'Unknown error has occurred.');
      }, (historyList) async* {
        if (historyList.isEmpty) {
          yield SearchHistoryEmpty();
        } else {
          yield SearchHistoryLoaded(history: historyList);
        }
      });
    });
  }

  Stream<SearchHistoryState> clearSearchHistory(
      ClearSearchHistoryEvent event) async* {
    final result = await clearSearchHistoryUseCase(NoParams());
    yield* result.fold((l) async* {
      yield SearchHistoryError(message: 'Unknown error has occurred.');
    }, (r) async* {
      yield SearchHistoryEmpty();
    });
  }

  @override
  SearchHistoryState get initialState => SearchHistoryInitial();
}
