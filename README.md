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

This is a simple godot plugin made in gdScript that helps creating a typing game. For now it's really simple but the idea is to make it grow so it has more options. All improvements are welcome and will be studied to be included in the proyect.

## 🏁 Getting Started <a name = "getting_started"></a>
### Installing

Download the addons folder into your godot project. If you already have an addons folder just accept combination of the folders.
For more information go to [Installing Plugins](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) from godot's official documentation.

### Prerequisites

A godot proyect is needed to be able to install this plugin in.

## 🔧 Examples <a name = "examples"></a>

Here there are some examples of use of the plugin.

### Scene: 1

In this example how to create words that move and have lifespan is shown. Getting the word right before despawning will give you points. It will also tell if a word was missed

```gdscript
# First create connection to the word controller
onready var word_controller = $WordController

# When node ready connection with the signals are made (this demo uses word_finished and word_missed signals)
func _ready():
	word_controller.connect("word_finished", self, "_on_WordController_word_finished")
	word_controller.connect("word_missed", self, "_on_WordController_word_missed")

# At some point in the process a word can be created from a word_list String Array
# position, direction speed and lifespan are setted by the game controller
func _process():
  ...
  word_controller.new_word(word_list[random_word_index], get_random_position(word_list[random_word_index]), word_controller.DirectionEnum.DOWNWARDS, word_speed, word_lifespan)
  ...

# In the defined event methods things such as setting a score or referencing a missed word can be done 
# these methods may have the name you desire
func _on_WordController_word_finished(word_text:String):
	score += 1
	score_label.text = "Score: " + score as String

func _on_WordController_word_missed(word_text:String):
	missed_word_label.text = "Last missed: " + word_text
```

### Scene: 2

In this example how to create words that are static and have no lifespan is shown. Failing to get the word right will get the player killed if else the player will kill the enemy. It will also despawn all pooled words if player is killed

```gdscript
# First create connection to the word controller
onready var word_controller = $WordController

# When node ready connection with the signals are made (this demo uses word_finished and word_failed signals)
func _ready():
	word_controller.connect("word_finished", self, "_on_WordController_word_finished")
	word_controller.connect("word_failed", self, "_on_WordController_word_failed")
  word_on_enemy(enemy_tank_1, enemy_tank_1.word)

# This method creates an static word on top of the enemy tank
func word_on_enemy(enemy:Node2D, word:String):
	var word_position = Vector2(enemy.position.x - 35, enemy.position.y - 70)
	word_controller.new_word(word, word_position)

#	Check before trying to shoot an enemy whether it exists or not
func _on_WordController_word_finished(word_text:String):
	if (is_instance_valid(enemy_tank_1) and word_text == enemy_tank_1.word):
			player_shoots(enemy_tank_1.position)
#			after shooting one enemy, the second enemy word is instanced so words don't overlap and second tank kills the player
			word_on_enemy(enemy_tank_2, enemy_tank_2.word)
	elif(is_instance_valid(enemy_tank_2) and (word_text == enemy_tank_2.word)):
		player_shoots(enemy_tank_2.position)

# If failed to get the word right enemy will shoot the player
func _on_WordController_word_failed(word_text:String):
	enemy_shoots(player.position, word_text)

# On game over, due to all words being static this method can be used to despawn them, it will make all the pooled words non-visible and also stop their processes
func game_over():
  ...
	word_controller.despawn_words()
```

## 🎈 Usage <a name="usage"></a>

### Normal mode

First create a node `WordController` this will create a node wich can be accessed from a game controller. 

### Singleton mode

If you wish the `WordController.gd` script can be added to the autoload settings so it can be used as a singleton. In this case, theres no need to add the controller as a node, but you will need to set your custom font and font size in runtime to the controller.


It's also possible to set a custom font to each word separately.

## ✍️ Authors <a name = "authors"></a>

- [@iRheKs](https://github.com/iRheKs) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [@Rafalagoon](https://github.com/rafalagoon) for introducing godot in his streams in [twitch](https://www.twitch.tv/rafalagoon). Also you can follow him on [twitter](https://twitter.com/RafaLagoon).
- Thanks to my friend [@cronorobs](https://github.com/cronorobs) for encouraging me to start this project in godot.
- All references used from godot's official [documentation](https://docs.godotengine.org/en/stable/).
