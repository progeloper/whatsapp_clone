import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/home/controller/home_controller.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/theme/palette.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isInnerBoxScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 50,
                snap: true,
                floating: true,
                flexibleSpace: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Palette.tabColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'WhatsApp',
                        style: TextStyle(
                          color: Palette.extraLightGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                                color: Palette.extraLightGrey,
                                size: 32,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search_outlined,
                                color: Palette.extraLightGrey,
                                size: 32,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: Palette.extraLightGrey,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Palette.tabColor,
              appBar: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                isScrollable: false,
                tabs: const [
                  Tab(
                    text: 'Chats',
                  ),
                  Tab(
                    text: 'Status',
                  ),
                  Tab(
                    text: 'Calls',
                  ),
                ],
              ),
              body: TabBarView(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
