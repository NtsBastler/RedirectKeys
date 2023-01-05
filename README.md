# RedirectKeys
Redirect Keys to a program which currently does not have the focus.
The focus application could for example be an exclusive fullscreen game and your target program could be a solution guide in your browser.
With this tool you can scroll your browser without switching between programs.

## Usage
This tool can redirect keyboard inputs to another window which currently doesn't have the focus.
Most programs ignore keyboard inputs while they aren't in focus.
But it works good with Firefox.

### Setup
At first startup the program will open the options menu.
Here you can configure how the target window should be identified.
The class name of a window is the internal reference, this is most consistant.
The title is the visible title of the window.
To automatically fill the fields click on the small square and release over the target window.

With a click on the test button the target window should come to the front and blink in the task bar.

By default there isn't any caret while typing with this tool.
The option set keyboard focus can add a caret to the target program.
But this depends on the target program.
Some programs might try to gain complete focus after receiving the keyboard focus.
That's why this option is off by default.

It's also possible to add the program to your autostart if you want to have it always running.

Press the save button to save your changes.

### How to use it
Start your target application and the Redirect Keys tool.
Make sure your prefered input field is selected in the target application.
Than start your exclusive fullscreen program.

Now you can toggle the keyboard focus between your target application and the exclusive fullscreen program with the scrollock-key.
With the scrollock on your keystrokes will be redirected to the target application.
The window with the actual focus will get your keyboard inputs with scrollock off.


## Debugging RedirectKeys yourself
You need the [XOJO IDE](https://www.xojo.com/download/) to debug the program.
Additionally you need the [MBS Xojo Win Plugin](https://www.monkeybreadsoftware.de/xojo/plugin-win.shtml) from MonkeyBread.
[Installation instructions for the Plugin.](https://www.monkeybreadsoftware.de/xojo/download/plugin/Installation.pdf)

After installing Xojo and the Plugin open the `RedirectKeys.xojo_project` in the IDE.
You should be able to press the run button to debug the application.

Building your own copy of this tool requires a XOJO license and an MBS license!
