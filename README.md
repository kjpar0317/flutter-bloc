# ncoininfos

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Bloc Pattern

### BlocBuilder

This is the easy one. This is used when we want to draw a Widget based on what is the current State. In the following example a new “text” gets drawn every time the state changes.

- buildWhen (Optional): This is flag (true/false) indicates if the builder method should be called or not, keep in mind that this is called only during a rebuild process (explained at the bottom of the article). If this returns true then builder is called, if returns false it is not called. If buildWhen is not declared then the builder is always executed.
- builder (Required): This method is most important, this returns the widget that we want to draw based on the current state. i.e. The state is “OrderCompleted” then it returns “Text(‘Order Completed!’)”

### BlocListener

This is just a listener not a builder (like the above), that means that its job is keep listening for new changes in the state and not to return a widget. Each time the state changes to a new state this listener will receive a notification that the state has changed and then you can trigger an action (e.g. Send a notification, consume an endpoint, analytics, etc).

- listenWhen (Optional): This is flag (true/false) indicates if the listener method should be called or not, keep in mind that this is called only during a rebuild process (explained at the bottom of the article). If this returns true then listener is called, if returns false it is not called. If listenWhen is not declared then the listener is always executed.
- listener: This method is most important, it listens for new changes in the state and execute actions based on the received state. For example: API requests, call analytics stuff, etc.

### BlocConsumer

This is a mix between “BlocListener” and “BlocBuilder”. This is used when we want to draw something based on the current state and execute some actions depending on the new arriving states.
The methods “buildWhen” and “listenWhen” are optional.
The “build” does the same as in BlocBuilder and “listener” does the same as in “BlocListener”.

## Bloc Pattern 한글

### BlocBuilder

화면에서 가장 많이 쓰이는 위젯입니다.
BlocProvider 로 create 해준 Bloc 이 있다면 context.read<T> 로 불러올 수 있습니다.
create 해준 Bloc 이 없다면 bloc 을 받아 사용하는 방법도 있습니다.
buildWhen 을 통해 이전 state 와 현재 state 를 가져올 수 있고 bool 을 리턴합니다.
buildWhen 이 false 를 리턴하면 builder 를 호출하지 않습니다.
context.watch<T>
// 1. normal

BlocBuilder<BlocA, BlocAState>(
builder: (context, state) {
// context.read<T> 로 사용가능
}
)

// 2. bloc
// BlocProvider 로 Bloc 을 create 해주지 않았다면
// context.read<T> 로 사용하면 에러

final blocA = BlocA();

BlocBuilder<BlocA, BlocAState>(
bloc: blocA,
builder: (context, state) {
// return widget here based on BlocA's state
}
)

// 3. buildWhen

BlocBuilder<BlocA, BlocAState>(
buildWhen: (previous, current) {
// return true/false to determine whether or not
// to rebuild the widget with state
},
builder: (context, state) {
// return widget here based on BlocA's state
}
)

### BlocSelector

BlocBuilder와 유사하지만 현재 블록 상태를 기반으로 새 값을 선택하여 업데이트를 필터링할 수 있는 위젯
state 변경에 따라 rebuild가 필요한 부분을 selector 로 지정
BlocBuilder 의 buildWhen 과 비슷하지만 buildWhen 은 Builder 가 호출된다고 보장하지 않는다고 합니다.
context.select<T>
BlocSelector<BlocA, BlocAState, SelectedState>(
selector: (state) {
// return selected state based on the provided state.
},
builder: (context, state) {
// return widget here based on the selected state.
},
)

### BlocProvider

자식에게 Bloc 을 제공하는 위젯입니다.
BlocProvider.of<BlocA>(context) 를 통해 블록을 조회할 때 create 가 실행됩니다.
create 가 즉시 실행되길 원한다면 lazy 를 false 로 두면 됩니다.
BlocProvider(
create: (BuildContext context) => BlocA(),
child: ChildA(),
);

BlocProvider(
lazy: false, // 기본값 true
create: (BuildContext context) => BlocA(),
child: ChildA(),
);

BlocProvider.value 는 잘 사용되지는 않는 것 같지만 위젯 트리의 새 부분에 기존 블록을 제공하는 데 사용합니다.
Bloc 을 create 하지 않았기 때문에 블록을 자동으로 닫지 않는다고 합니다.
BlocProvider.value(
value: BlocProvider.of<BlocA>(context),
child: ScreenA(),
);

BlocProvider 로 제공한 Bloc 은 아래와 같이 사용합니다.
// with extensions
context.read<BlocA>();

// without extensions
BlocProvider.of<BlocA>(context)

### MultiBlocProvider

여러 BlocProvider 을 하나로 합칠 수 있는 위젯입니다.
MultiBlocProvider(
providers: [
BlocProvider<BlocA>(
create: (BuildContext context) => BlocA(),
),
BlocProvider<BlocB>(
create: (BuildContext context) => BlocB(),
),
BlocProvider<BlocC>(
create: (BuildContext context) => BlocC(),
),
],
child: ChildA(),
)

### BlocListener

Bloc 의 상태 변경에 대한 응답으로 리스너를 호출하는 위젯
navigation, SnackBar, Dialog 등과 같이 상태 변경당 한 번 발생해야 하는 기능에 사용해야 한다고 합니다.
create 해준 Bloc 이 없다면 bloc 을 받아 사용하는 방법도 있습니다.
listenWhen 을 통해 이전 state 와 현재 state 를 가져올 수 있고 bool 을 리턴합니다.
listenWhen 이 false 를 리턴하면 builder 를 호출하지 않습니다.
// normal

BlocListener<BlocA, BlocAState>(
listener: (context, state) {
// do stuff here based on BlocA's state
},
child: Container(),
)

// bloc
// BlocProvider 로 Bloc 을 create 해주지 않았다면
// context.read<T> 로 사용하면 에러

final blocA = BlocA();

BlocListener<BlocA, BlocAState>(
bloc: blocA,
listener: (context, state) {
// do stuff here based on BlocA's state
},
child: Container()
)

// listenWhen

BlocListener<BlocA, BlocAState>(
listenWhen: (previousState, state) {
// return true/false to determine whether or not
// to call listener with state
},
listener: (context, state) {
// do stuff here based on BlocA's state
},
child: Container(),
)

### MultiBlocListener

여러 BlocListener 를 하나로 합칠 수 있는 위젯입니다.
MultiBlocListener(
listeners: [
BlocListener<BlocA, BlocAState>(
listener: (context, state) {},
),
BlocListener<BlocB, BlocBState>(
listener: (context, state) {},
),
BlocListener<BlocC, BlocCState>(
listener: (context, state) {},
),
],
child: ChildA(),
)

### BlocConsumer

BlocBuilder 와 BlocListener 가 합친 형태 입니다.
listenWhen 및 buildWhen는 선택 사항이며 구현되지 않은 경우 기본적으로 true로 설정됩니다.
BlocBuilder 와 차이점은 navigation, SnackBar, Dialog 등과 같이 상태 변경당 한 번 발생해야 하는 기능에 사용해야 합니다.
// 1.normal

BlocConsumer<BlocA, BlocAState>(
listener: (context, state) {
// do stuff here based on BlocA's state
},
builder: (context, state) {
// return widget here based on BlocA's state
}
)

// 2.bloc
// BlocProvider 로 Bloc 을 create 해주지 않았다면
// context.read<T> 로 사용하면 에러

final blocA = BlocA();

BlocConsumer<BlocA, BlocAState>(
bloc: blocA,
listener: (context, state) {
// do stuff here based on BlocA's state
},
builder: (context, state) {
// return widget here based on BlocA's state
}
)

// 3. buildWhen, listenWhen

BlocConsumer<BlocA, BlocAState>(
listenWhen: (previous, current) {
// return true/false to determine whether or not
// to invoke listener with state
},
listener: (context, state) {
// do stuff here based on BlocA's state
},
buildWhen: (previous, current) {
// return true/false to determine whether or not
// to rebuild the widget with state
},
builder: (context, state) {
// return widget here based on BlocA's state
}
)

### RepositoryProvider

의존성 주입(DI) 위젯입니다.
RepositoryProvider(
create: (context) => RepositoryA(),
child: ChildA(),
);

사용방법은 아래와 같습니다.
// with extensions
context.read<RepositoryA>();

// without extensions
RepositoryProvider.of<RepositoryA>(context)

### MultiRepositoryProvider

여러 RepositoryProvider 를 하나로 합칠 수 있는 위젯입니다.
MultiRepositoryProvider(
providers: [
RepositoryProvider<RepositoryA>(
create: (context) => RepositoryA(),
),
RepositoryProvider<RepositoryB>(
create: (context) => RepositoryB(),
),
RepositoryProvider<RepositoryC>(
create: (context) => RepositoryC(),
),
],
child: ChildA(),
)
