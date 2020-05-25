library user.global;
import 'package:rw334/models/user.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';
import 'package:rw334/models/message.dart';

final User dummy =
new User("group9@rw334.com", "MikeHunt69", "Hue G. Dick", "assets/user1.jpeg", 420, 666);

var dummyPosts = [
  new Post(
    text: 'How to grow better carrots?',
    categories: ['Gardening', 'Environmental', 'Sustainability'],
    id: 1,
  ),
  new Post(
    text: 'How to ride bicycle?',
    categories: ['Sports', 'Lifestyle', 'Transportation'],
    id: 2,
  ),
  new Post(
    text: 'How to overthrow a lawfully elected government?',
    categories: ['Politics', 'Military Tactics', 'Genocide'],
    id: 3,
  ),
  new Post(
    text: 'A very long post title.  '*20,
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  new Post(
    text: 'Title',
    categories: ['Categoryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy 1', 'Cat 2', 'Cat 3'],
  ),
  new Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  new Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  new Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  new Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
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
    epochTime: (DateTime(2020, 5, 23, 13, 00).millisecondsSinceEpoch/1000).floor(),
    id: 2,
    senderId: 1,
    text: 'Why did you leave me',
  ),
  new Message(
    epochTime: (DateTime(2019, 5, 24, 12, 34).millisecondsSinceEpoch/1000).floor(),
    id: 5,
    senderId: 2,
    text: '2019 message.',
  ),
];

var dummyComments = [
  new Comment(
    epochTime: (DateTime(2020, 01, 01, 10, 00).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'Get better fertilizer bro.',
    userId: 0,
  ),
  new Comment(
    epochTime: (DateTime(2020, 01, 01, 11, 00).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'I\'d recommend getting better seeds and tools.  Hoes aren\'t cheap tho :(',
    userId: 1,
  ),
  new Comment(
    epochTime: (DateTime(2020, 05, 05, 21, 30).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'Are they getting enough sunlight?',
    userId: 1,
  ),
];