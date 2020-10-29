# sigma

### What is the difference between “main()” and “runApp()” functions in Flutter?
<br />
Main is the entry point of dart, which is common for various languages such as c++, java and many more.  <br />
runApp() loads the flutter application, root of the widget tree is rendered, variables are intitalised.  <br />
<br />

### What is an App State?
<br />
As there are two types of widget in flutter, Stateless and Stateful. Stateful widgets store some state in memory which can be changed by some actions. For example if we want to change the title of the app bar. We can set the app bar as some string (variable member of the class) and modify this variable by calling setState(), using that widget will be re-rendered. Default way of managing App's state is through setState() but using packages like Provider makes thing easier.

