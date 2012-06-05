MenuPalette for Delphi and C++Builder
=====================================
MenuPalette is an add-in for Delphi and C++Builder (2006, 2007, 2009 and XE2) that extends the Tool Palette to also contain all IDE menu items. This allows you to search for a menu item by typing some part of its title, and the Tool Palette will do the hard work of narrowing down the matches.

![menupalette](http://www.malcolmgroves.com/images/software/menupalette.gif)


A more detailed description available [here](http://www.malcolmgroves.com/blog/?p=163)


Note
----
This add-in was written before [IDE Insight](http://docwiki.embarcadero.com/RADStudio/en/IDE_Insight) was added to the IDE. IDE Insight supercedes MenuPalette, however I've had a couple of requests from people to see the source as an example of using the palette OpenTools APIs, so thought I'd publish this.


Known Issues
------------
If you remove the package while the IDE is still running, the Tool Palette in the IDE barfs. Restarting the IDE fixes it up. It’s on my list of things to fix, but it doesn’t cause massive problems as it only happens if you manually remove the package from the IDE list. If you can’t live with this, don’t install it.
If you have suggestions or requests, let me know.

