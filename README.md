# Lua Qlock
A [Qlock](https://gist.github.com/olooney/a89db3932b089925b71b68d7e9f27bbb), or Quine Clock, is a Quine program that displays its own source code, while showing the time at the same time.

![image](https://github.com/user-attachments/assets/a28c3b03-7348-48a1-b59c-7c05c21f0e84)

This is a Lua implementation of the same idea, which is meant to run on a [TTY](https://en.wikipedia.org/wiki/Teleprinter).

This repository contains the building tools for turning the source code (`src` directory) into a minimized Lua script that functions the same with the expected Quine functionality.

## Capabilities
For everything to be shown on the screen, the resolution has to be atleast 80x21. The standard minimum resolution of a Linux TTY is 80x24, which is a little bit more.

The outputted code ends itself with 2 or more dashes, which acts as a comment in Lua.

The bitmap font has a resolution of 4x6, encoded in hexadecimal in one continuous string.

Characters in a white background get a black foreground so that they are visible regardless of the clock.

## Running
This is currently only tested on Linux! If something wrong happens when using another operating system like Windows, please [submit an Issue](https://github.com/Ponali/lua-qlock/issues)!

Go to the `build` direcory and run the `qlock.lua` file. If something errors out, make sure the version is Lua 5.1 or something newer.
If the build directory doesn't exist, check the "Building and Contributing category."

## Minifier used
The minifying code used comes from [stravant/lua-minify](https://github.com/stravant/lua-minify/blob/master/minify.lua). It was very helpful; however, some tweaking had to be done for it to run automatically without requiring command-line arguments.

The [other minifier](https://mths.be/luamin) with a JavaScript codebase couldn't handle all of it because it refuses to change the variable names if the variables aren't set to be local, which adds a lot more characters to the code.

## Building and Contributing
Make sure to remember that the source code (in the `src` directory) is different than the actual quine output you run (in the `build` directory).
If the `build` directory is missing, or you changed the source code for contributing, run the `make.lua` file in the root of the repository. It will take the source code and automatically turn them into a capable quine program.

The font is at the root, with the filename `font.txt`. If you would like to edit the font, then edit this file. A dot represents a black pixel and `@` represents a white pixel.
You don't need to edit anything else after editing font.txt, except from rebuilding. The font gets automatically converted to its hexadecimal variant when building.

You can always make a Pull Request to contribute! It will take some time for it to get approved though, since i usually forget the projects i upload here.

## Inspiration
[aem1k](https://aem1k.com/), a well-known code golfer, made [his Quine Clock](https://aem1k.com/qlock/) in JavaScript. It's actually not that surprising that JavaScript was used here, since JavaScript is very extensible with code size, and various JavaScript minifiers exist here and there on GitHub. There was also some cheating in the process: JavaScript code can convert a [function into a string of its own code](https://stackoverflow.com/a/6583368).

But then, [Tsoding](https://github.com/tsoding), a very talented C(++) and Rust developper saw this project and got the idea to make a Quine Clock, but in C. You can find a video of him developping it [here](https://youtu.be/plFwBqBYpcY).

Most of the inspiration i got came from Tsoding, since that's how I found out that Quines can be done on compiled/JIT languages that don't let you get the code of a function. It was very limiting, but still possible.

I saw some mistakes where sometimes it looked ugly (red text, non-constant width between lines) or when the building process bugged a bit and made a line that was too big because of the improper order between making the "blob" and handling the tokens. (even with those mistakes, it's still impressive since it's in C. Tsoding, if you're reading this, godspeed to you bro.)

Since i can't code in C easily, i can't contribute to the project even if it's now open-source, but i can always recreate it in another language so i can add features to it afterwards.
I wanted to challenge myself with a compiled/JIT language like i explained before, so i picked Lua. I've had experience with it before on Roblox, [Retro Gadgets](https://www.retrogadgets.game/)* and many others.

*Retro Gadgets uses [Luau](https://luau.org/), which is based on Lua 5.1 while adding more features.
