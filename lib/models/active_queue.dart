import 'dart:convert';
// ignore: unused_import
import 'package:flutter/material.dart';

class ActiveQueue {
  final String? id;
  final String? stationID;
  final String? fuelType;
  final Map<String, dynamic> requests;
  final String vehicleCount;
  final String selectedAmount;
  final String queueStartTime;
  final String estimatedEndTime;
  final String state;

  ActiveQueue(
      {this.id,
      this.stationID,
      this.fuelType,
      required this.requests,
      required this.vehicleCount,
      required this.selectedAmount,
      required this.queueStartTime,
      required this.estimatedEndTime,
      required this.state});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationID': stationID,
      'fuelType': fuelType,
      'requests': requests,
      'vehicleCount': vehicleCount,
      'selectedAmount': selectedAmount,
      'queueStartTime': queueStartTime,
      'estimatedEndTime': estimatedEndTime,
      'state': state,
    };
  }

  factory ActiveQueue.fromMap(Map<String, dynamic> map) {
    return ActiveQueue(
      id: map['_id'],
      stationID: map['stationID'],
      fuelType: map['fuelType'],
      requests: map['requests'],
      vehicleCount: map['vehicleCount'] ?? '',
      selectedAmount: map['selectedAmount'] ?? '',
      queueStartTime: map['queueStartTime'] ?? '',
      estimatedEndTime: map['estimatedEndTime'] ?? '',
      state: map['state'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveQueue.fromJson(String source) =>
      ActiveQueue.fromMap(json.decode(source));
}
