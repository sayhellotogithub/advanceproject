#### 資源

https://github.com/ReactiveX
https://www.kodeco.com/books/reactive-programming-with-kotlin


#### Subject
- **PublishSubject** is used when you only want to receive events that occur after you’ve subscribed.
- **BehaviorSubject** will relay the latest event that has occurred when you subscribe, including an optional initial value.
- **ReplaySubject** will buffer a configurable number of events that get replayed to new subscribers. You must watch out for buffering too much data in a replay subject.
- **AsyncSubject** only sends subscribers the most recent `next` event upon a `complete` event occurring.

#### RxRelay
https://github.com/JakeWharton/RxRelay
- The **RxRelay** library can be used with relays in place of subjects, to prevent accidental `complete` and `error` events to be sent.

