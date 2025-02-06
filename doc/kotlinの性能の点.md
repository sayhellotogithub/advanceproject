
* Modern hardware has been optimized for Double so it is the one that you should reach for unless you have good reason not to.
* When you create a map, you can define its capacity. This is an easy way to improve performance when you have an idea of how much data
  the map needs to store.
* For performance-critical code, HashMap<K, V> should be used via hashMapOf(), instead of mapOf().