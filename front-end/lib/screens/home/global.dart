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
    epochTime: 1590265421, // 23 May 2020, 20:23:41
    id: 0,
    senderId: 0,
    text: 'Hello world!',
  ),
  new Message(
    epochTime: 1590265461, // 23 May 2020, 20:24:41
    id: 1,
    senderId: 0,
    text: 'I\'m using a new app.  It\'s called \"The Shed\".',
  ),
  new Message(
    epochTime: 1590237296, // 23 May 2020, 12:34:56
    id: 3,
    senderId: 1,
    text: 'Again, I\'m User#1.',
  ),
  new Message(
    epochTime: 1590177600, // 22 May 2020, 20:00:00
    id: 2,
    senderId: 1,
    text: 'I\'m User#1.',
  ),
  new Message(
    epochTime: 1558644557, // sometime in 2019
    id: 5,
    senderId: 2,
    text: 'This message is from last year',
  ),
];