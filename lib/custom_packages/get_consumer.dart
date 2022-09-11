import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _GetConsumerListeners {
  Map<Key, VoidCallback> listeners = {};

  VoidCallback createListener(Key key, VoidCallback listener) {
    listeners[key] = listener;
    return listeners[key]!;
  }

  VoidCallback getListener(Key key) {
    return listeners[key]!;
  }

  void removeListener(Key key) {
    listeners.removeWhere((k, _) => k == key);
  }
}

final _getConsumerListeners = _GetConsumerListeners();

class GetConsumer<T extends GetxController> extends GetBuilder<T> {
  final void Function(T) listener;

  GetConsumer({
    Key? key,
    required T init,
    global = true,
    required builder,
    required this.listener,
    autoRemove = true,
    assignId = false,
    void Function(GetBuilderState<T>)? initState,
    filter,
    tag,
    dispose,
    id,
    didChangeDependencies,
    didUpdateWidget,
  }) : super(
          key: key,
          init: init,
          global: global,
          builder: builder,
          autoRemove: autoRemove,
          assignId: assignId,
          id: id,
          didChangeDependencies: didChangeDependencies,
          didUpdateWidget: didUpdateWidget,
          filter: filter,
          tag: tag,
          initState: (GetBuilderState<T> state) {
            final consumerState = (state as GetConsumerState<T>);
            consumerState.generateConsumerListenerKey();

            VoidCallback _listener = _getConsumerListeners.createListener(
              consumerState.consumerListenerKey,
              () => listener(init),
            );

            init.addListener(_listener);
            if (initState != null) initState(state);
          },
          dispose: (GetBuilderState<T> state) {
            final consumerState = (state as GetConsumerState<T>);

            VoidCallback _listener = _getConsumerListeners.getListener(
              consumerState.consumerListenerKey,
            );
            
            init.removeListener(_listener);

            _getConsumerListeners.removeListener(consumerState.consumerListenerKey);
            if (dispose != null) dispose(state);
          },
        );

  @override
  GetBuilderState<T> createState() => GetConsumerState<T>();
}

class GetConsumerState<T extends GetxController> extends GetBuilderState<T> {
  late final Key consumerListenerKey;

  void generateConsumerListenerKey() {
    consumerListenerKey = UniqueKey();
  }
}