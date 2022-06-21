import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {readyFirst, readyLast}

class OrdersBloc extends BlocBase {

  final _ordersController = BehaviorSubject<List>();

  Stream<List> get outOrders => _ordersController.stream;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrdersBloc() : super(null){
    _addOrdersListener();
  }

  final List<DocumentSnapshot> _orders = [];

  SortCriteria _criteria = SortCriteria.readyLast;

  void _addOrdersListener(){
    _firestore.collection("orders").snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        String oid = change.doc.id;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.id == oid);
            _orders.add(change.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.id == oid);
            break;
        }
      }

      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria){
    _criteria = criteria;
    _sort();
  }

  void _sort(){
    switch(_criteria){
      case SortCriteria.readyFirst:
        _orders.sort((a,b){
          int sa = a["status"];
          int sb = b["status"];

          if(sa < sb){
            return 1;
          } else if(sa > sb){
            return -1;
          } else {
            return 0;
          }
        });
        break;
      case SortCriteria.readyLast:
        _orders.sort((a,b){
          int sa = a["status"];
          int sb = b["status"];

          if(sa > sb){
            return 1;
          } else if(sa < sb){
            return -1;
          } else {
            return 0;
          }
        });
        break;
    }

    _ordersController.sink.add(_orders);
  }
}