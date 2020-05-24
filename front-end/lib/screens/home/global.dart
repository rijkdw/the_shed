library user.global;
import 'package:rw334/models/user.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/message.dart';

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

var dummyMessages = [
  new Message(
    epochTime: (DateTime(2020, 5, 24, 12, 34).millisecondsSinceEpoch/1000).floor(),
    id: 0,
    senderId: 0,
    text: 'Hello world!',
  ),
  new Message(
    epochTime: (DateTime(2020, 5, 24, 12, 36).millisecondsSinceEpoch/1000).floor(),
    id: 1,
    senderId: 0,
    text: 'I\'m using a new app.  It\'s called \"The Shed\".',
  ),
  new Message(
    epochTime: (DateTime(2020, 5, 23, 12, 00).millisecondsSinceEpoch/1000).floor(),
    id: 3,
    senderId: 1,
    text: 'uwu',
  ),
  new Message(
    epochTime: (DateTime(2020, 5, 23, 13, 00).millisecondsSinceEpoch/1000).floor(),
    id: 2,
    senderId: 1,
    text: 'owo',
  ),
  new Message(
    epochTime: (DateTime(2019, 5, 24, 12, 34).millisecondsSinceEpoch/1000).floor(),
    id: 5,
    senderId: 2,
    text: 'This message is from last year.',
  ),
];