library user.global;
import 'package:rw334/models/user.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';

final User dummyUser = User(
  //"group9@rw334.com", "MikeHunt69", "Hue G. Dick", "assets/user1.jpeg", 420, 666);
  email: 'group9@rw334.com',
  username: 'MikeHunt69',
  name: 'Hue G. Dick',
  picture: 'assets/user1.jpeg',
  follow: 666,
  post: 420,
);

var dummyPosts = [
  Post(
    text: 'How to grow better carrots?',
    categories: ['Gardening', 'Environmental', 'Sustainability'],
    id: 1,
    epochTime: (DateTime(2018, 01, 04, 20, 04).millisecondsSinceEpoch/1000).floor(),
  ),
  Post(
    text: 'How to ride bicycle?',
    categories: ['Sports', 'Lifestyle', 'Transportation'],
    id: 2,
  ),
  Post(
    text: 'How to overthrow a lawfully elected government?',
    categories: ['Politics', 'Military Tactics', 'Genocide'],
    id: 3,
  ),
  Post(
    text: 'A very long post title.  '*20,
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  Post(
    text: 'Title',
    categories: ['Categoryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy 1', 'Cat 2', 'Cat 3'],
  ),
  Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
  Post(
    text: 'TestTitle',
    categories: ['Cat 1', 'Cat 2', 'Cat 3'],
  ),
];

var dummyComments = [
  Comment(
    epochTime: (DateTime(2019, 01, 01, 10, 00).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'Get better fertilizer bro.',
    userId: 0,
  ),
  Comment(
    epochTime: (DateTime(2020, 01, 01, 11, 00).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'I\'d recommend getting better seeds and tools.  Hoes aren\'t cheap tho :(',
    userId: 1,
  ),
  Comment(
    epochTime: (DateTime(2020, 05, 26, 15, 25).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'Carrots are lame.  Get potatoes!',
    userId: 1,
  ),
  Comment(
    epochTime: (DateTime(2020, 05, 05, 21, 30).millisecondsSinceEpoch/1000).floor(),
    postId: 1,
    text: 'Are they getting enough sunlight?',
    userId: 1,
  ),
];