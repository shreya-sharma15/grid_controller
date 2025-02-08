import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:grid_controller/grid_controller.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple DataGrid Example'),
        ),
        body: MyDataGrid(),
      ),
    );
  }
}

class MyDataGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ColumnConfig> columnsConfig = [
      ColumnConfig(columnName: 'name', labelText: 'Name', allowSorting: true, visible: true, columnWidthMode: ColumnWidthMode.fitByCellValue),
      ColumnConfig(columnName: 'age', labelText: 'Age', allowSorting: true, visible: true),
      ColumnConfig(columnName: 'city', labelText: 'City', visible: true, columnWidthMode: ColumnWidthMode.fitByCellValue),
    ];

    // Prepare your data source
    List<Map<String, dynamic>> data = [
      {'name': 'John Doe', 'age': 30, 'city': 'New York'},
      {'name': 'Jane Smith', 'age': 25, 'city': 'Los Angeles'},
      {'name': 'John', 'age': 30, 'city': 'America'},
      {'name': 'Doe', 'age': 30, 'city': 'America'},
      {'name': 'JohDoe', 'age': 30, 'city': 'New York'},
      {'name': 'DoeJohn', 'age': 30, 'city': 'America'},
    ];

    // Use your custom data grid source
    MyDataGridSource dataSource = MyDataGridSource(data);

    // Use the DataGridWidget from the library
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DataGridWidget(
        columnsConfig: columnsConfig, // Pass the column configuration
        dataGridSource: dataSource,   // Pass the data source
      ),
    );
  }
}

class MyDataGridSource extends DataGridSource {
  final List<Map<String, dynamic>> data;

  MyDataGridSource(this.data);

  @override
  List<DataGridRow> get rows {
    return data.map<DataGridRow>((map) {
      return DataGridRow(
        cells: map.entries.map((e) {
          return DataGridCell<String>(
            columnName: e.key,
            value: e.value.toString(),
          );
        }).toList(),
      );
    }).toList();
  }

  @override
  List<SortColumnDetails> get sortedColumns {
    return [];
  }

  @override
  bool get isReorderable => false;

  @override
  void handleSortColumn(dynamic columnName, bool ascending) {}

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(dataCell.value.toString()),
        );
      }).toList(),
    );
  }
}
