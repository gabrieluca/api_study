// void main() {
// 	print('Hello World!');
// }

// // Context: Social Network. Linkedin or Facebook.
// // DONT NEED TO WRITE THIS.
// // get_friends(int user_id) -> List[int]:

// // WRITE this
// // get_recommended_friends(int user_id) -> List[int]:

// // What is a recommended friend?
// // 1. It is a mutual friend.
// // A - B - C
// // A - D - C
// // 0 - 1 - 2 - 3
// // A - G - H - X
// // A - R - H
// // A Q H
// // A G V
// // A G L
// // A - C
// // 
// // 2. Return the list of recommended friends, sorted by the MOST number of mutual friends.
// // get_recommended_friends(A) -> [H, C]
// // get_friends(A) -> [B, D, G, R, Q]

// List<int> get_recommended_friends(int user_id) {
//   var unknownList=<int>[];
//   final myFriendsList= get_friends(user_id);
//   final recommendedMap = <int,int>{};

//   for(var friend in myFriendsList){
//     final newFriendList = get_friends(friend);
//     for(var unknown in newFriendList){
//       if(!myFriendsList.contains(unknown)){    
//         recommended[unknown] = (recommended[unknown] ?? 1) + 1;        
        
//       }
      
//     }
//   }

  

// final uniqueUnknown=unknownList.toSet();
//   for(var item in uniqueUnknown){
//     final 
//   }
  

  
 

// }