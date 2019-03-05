# Rocket League Custom Quickchat

This is a quickchat script for Rocket League which allows for custom quickchats. <br><br>
It uses AutoHotKey to insert custom chat messages while also providing more useful visual feedback.

## Features

- 2 sets of custom quickchats
- Displays menu in game (where the normal menu is located)
- Menu color is based on message audience (all or team)
- Displays an alert when changing sets (also color coded)
- Custom chat bank for during the game/post game
- Macro menu (coming soon - Change video modes)

## Installation

- Map your controller to the below keybinds
- Download the repo and extract the script to where you please
- Launch the script before/while playing Rocket League.
- The settings.ini file must be in the same folder as the script

## Configuration 

- Both sets of messages can be configured by changing the settings.ini file. It opens in any editor <br>
- Your message must be in the quotes e.g. "IN_HERE" <br>
- Do not edit any other part of the settings.ini file. This will be abstracted to a user interface.
- You are only concerned with anything in the [message] section <br>

## Usage

This works by overriding the default quick chat system. This is achieved by re-mapping the dpad buttons (up, down, left, right) to the mappings shown below.<br>
You also need a way to change between the message set and the post/pre-game menu (optional), team chat only and macro menu buttons.<br>
You can do this by remapping a few of your controllers buttons as explained below.

Steam allows you to remap most popular controllers to output what you like and also gives us activators.<br>
Activators allow you to map additional hotkeys to when an input is activated in a certain way. For example a double press or a long press. <br>
This is really handy as it allows us to add many layers of interaction to pretty much any pad. <br>
It saves a lot of time coding and comes with other benefits such as haptic feedback if your controller supports it.<br><br>

[How to remap buttons through steam](https://www.howtogeek.com/234427/how-to-remap-buttons-on-your-steam-controller/)<br>

I currently use a steam controller which as 2 paddles on the back which I use for all my message options.<br>

- A single press of the left paddle switches from normal to custom chat modes - [toggle mode] below
- A single press of the right paddle means my next quick chat will be sent to the team only - [team only] below
- A long press of the right paddle brings up the pre/post game chat menu - [post/pre-menu] below
- A long press of the left paddle brings up the macro menu
  <br>

## Keybinds

Map your controllor as shown below. <br>
Instead of your controllers dpad outputting up when you press up on the dpad it should output numpad1.

| Command       | Key |
| ------------- | --- |
| up            | 1   |
| right         | 2   |
| down          | 3   |
| left          | 4   |
| toggle mode   | 5   |
| team only     | 6   |
| post/pre-menu | 7   |
| macro menu    | 8   |

## Macro menu

I current have the mapped below as I get horrible framedrops in borderless. <br>
I want to be able to see my game when using stuff on the second menu and this works pretty well<br><br>
I've not yet assigned macros to slot one and 2 so feel free to plug your own in, in the RLChatter.ahk<br>

| Command | Macro                           |
| ------- | ------------------------------- |
| up      | Switch viedo mode to fullscreen |
| right   | Switch viedo mode to Borderless |
| down    | Slot 1                          |
| left    | Slot 2                          |

## Todo

- Extract hotkey and feature settings into ini
- Make gui over the ini
- Make Exe % launch script

- Add macro menu
