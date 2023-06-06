import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/home/repository/home_repository.dart';

import '../../../models/chat.dart';


final getUserChatsProvider = StreamProvider.family((ref, String uid){
  return ref.watch(homeControllerProvider.notifier).getUserChats(uid);
});

final homeControllerProvider = StateNotifierProvider<HomeController, bool>((ref) {
  final HomeRepository repo = ref.read(homeRepoProvider);
  return HomeController(repo: repo);
});


class HomeController extends StateNotifier<bool>{
  final HomeRepository _repo;
  HomeController({required HomeRepository repo}):_repo=repo, super(false);

Stream<List<Chat>> getUserChats(String uid){
  return _repo.getUserChats(uid);
}
}