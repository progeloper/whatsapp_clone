import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/home/repository/home_repository.dart';

class HomeController extends StateNotifier<bool>{
  final HomeRepository _repo;
  HomeController({required HomeRepository repo}):_repo=repo, super(false);
}