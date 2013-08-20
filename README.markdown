GOSU RPG PROTOTYPE
==================

[Gosu-based](http://www.libgosu.org/) RPG game written in Ruby.

Currently serves as prove of concept for me for developing games with Gosu.
Experience is always good.

Following concepts have been implemented:

* Animated sprites
* Map scrolling and dynamic loading 
* Game's protagonist with sets of RPG characteristics (hp, mana, exp etc)
* Simple level modification / construction / object spawning
* Protagonist collision detection
* Multi layer static map building
* Sample enemy
* Static monster with line of sight detection and spell construction
* Spell reloading time
* Spell collision detection
* Sample items (potions etc)
* Song loading.

This has been updated to work with Ruby 2.0 and will automatically be loaded if you're using [RVM](https://rvm.io) or [rbenv](https://github.com/sstephenson/rbenv).

To run the game:

    bundle install
    bundle exec ruby game.rb

A LOT has to be done.