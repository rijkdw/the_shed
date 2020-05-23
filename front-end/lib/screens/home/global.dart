library user.global;
import 'package:rw334/models/user.dart';
import 'package:rw334/models/post.dart';

final User dummy =
new User("group9@rw334.com", "MikeHunt69", "Hue G. Dick", "assets/user1.jpeg", 420, 666);

var dummyPosts = [
  new Post(
    text: 'How to grow better carrots?',
    categories: ['Gardening', 'Environmental', 'Sustainability'],
  ),
  new Post(
    text: 'How to ride bicycle?',
    categories: ['Sports', 'Lifestyle', 'Transportation'],
  ),
  new Post(
    text: 'How to overthrow a lawfully elected government?',
    categories: ['Politics', 'Military Tactics', 'Genocide'],
  )
];
