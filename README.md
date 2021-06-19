# vtr_joblisting

Simple Job Center script for ESX FiveM. Using bt-target, ms-peds and nh-context. Made by Ventraks

### Requirements
* [bt-target](https://github.com/Mojito-Fivem/bt-target)
* [ms-peds](https://github.com/MiddleSkillz/ms-peds)
* [nh-context](https://github.com/nerohiro/nh-context)

### Preview

https://streamable.com/1gtyss

### Installation

- Download https://github.com/Ventraks/vtr_joblisting
- Put it in the `[your_folder]` directory
- Write `ensure vtr_joblisting` in server.cfg
- Make sure you have all required resources
- Go to ms-peds/config.lua, add line what is down 
- Restart your server

```
	{
		model = `cs_paper`,
		coords = vector4(-1083.0645751954,-245.82865905762,37.763278961182, 200.0),
		gender = 'male'
	},
```

### Editing

- You can add your own jobs in vtr_joblisting/client.lua
- You can change ped with changing every `cs_paper` to `your_ped` 
  - [Ped list](https://docs.fivem.net/docs/game-references/ped-models/)

# Legal
### License
vtr_joblisting - Simple Job Center script for ESX FiveM. Using bt-target, ms-peds and nh-context

Copyright (C) 2021 Ventraks

You can redistribute it or modify it. You can't sell this script like your own.
