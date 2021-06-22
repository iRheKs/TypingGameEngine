<!--<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/6wj0hh6.jpg" alt="Project logo"></a>
</p>-->

<h1 align="center">Typing Game Engine</h3>

<p align="center"> Simple typing game engine for godot engine 3.3. Make typing games way easier with this tool.
    <br> 
</p>

---
## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Examples](#examples)
- [Usage](#usage)
- [TODO](../TODO.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

This is a simple godot plugin made in gdScript that helps you create a typing game. For now it's really simple but the idea is to make it grow so it has more options. 

## 🏁 Getting Started <a name = "getting_started"></a>
### Installing

Download the addons folder into your godot project. If you already have an addons folder just accept combination of the folders.
For more information go to [InstallingPlugins] (https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) from godot's official documentation.

### Prerequisites

You need a godot proyect to be able to install this plugin.

## 🔧 Examples <a name = "examples"></a>

Here you have some examples of use of the plugin.

### Scene: 1

In this example you can see how to create words that move and have lifespan. Getting the word right before despawning will give you points.

```gdscript
Give an example
```

### Scene: 2

In this example you can see how to create words that are static and have no lifespan. Failing to get the word right will get you killed if else you will kill the enemy.

```gdscript
Give an example
```

## 🎈 Usage <a name="usage"></a>

### Normal mode

First create a node `WordController` this will create a node wich you can access from your game controller. 

### Singleton mode

If you wish the `WordController.gd` script can be added to the autoload settings so it can be used as a singleton. In this case, theres no need to add the controller as a node, but you will need to set your custom font and font size in runtime to the controller.


It's also possible to set a custom font to each word separately.

## ✍️ Authors <a name = "authors"></a>

- [@iRheKs](https://github.com/iRheKs) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [@Rafalagoon](https://github.com/rafalagoon) for introducing godot in his streams in [twitch](https://www.twitch.tv/rafalagoon). Also you can follow him on [twitter](https://twitter.com/RafaLagoon).
- Thanks to my friend [@cronorobs](https://github.com/cronorobs) for encouraging me to start this project in godot.
- All references used from godot's official [documentation](https://docs.godotengine.org/en/stable/).
