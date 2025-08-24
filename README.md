# AutoAFK

![AutoAFK Icon](https://i.imgur.com/pz4Ohs6.png)

_Animated AFK title | Automatically let others know when you step away_

## About

Triggers after 60 seconds, or shortly thereafter when you unfocus (alt-tab out of) the Webfishing window.
Of course, *this is only visible to users who've also installed AutoAFK*

## License

This project is licensed under the [Apache License 2.0](./LICENSE.txt).

That means you’re free to use, fork, modify, and even commercialize this project, as long as you:

- Keep the copyright notice and license text with the code  
- Give credit where it’s due  
- State any significant changes you’ve made  
- Accept that the software is provided “as-is” with no warranty  

For the full details, see the [LICENSE](./LICENSE.txt) file.

## Changelog

### v1.1.0 - Alt-tabbing rework
- Alt-tabbing now reduces the AFK timeout period from 60s to around 12s
    - This change will make it so alt-tabbing no longer immediately triggers an AFK status, just a quicker one
- Restored cute welcome back message by request

### v1.0.0 - Final Major Release
- Alt-tabbing now triggers the AFK title
- Cute "Welcome back" message removed to prevent potential annoyance
- Open-sourced so you guys can stop "decompiling" the mod and/or nagging me about it 😜

### v0.0.3
- Hotfixed bug where AFK title is shown despite not being AFK due to closing game while AFK (It is not longer possible to manually set the AFK title)