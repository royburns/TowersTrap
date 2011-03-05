-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

-- Resources
color =	 {	background = love.graphics.newColor(240,243,247),
      main = love.graphics.newColor(63,193,245),
      menu_bg = love.graphics.newColor(130,135,121,150),
      menu_border = love.graphics.newColor(136,143,134,200),
      text = love.graphics.newColor(76,77,78),
      menu_text = love.graphics.newColor(0,0,0),
      obj_selected = love.graphics.newColor(254,154,0),
      grid_hover = love.graphics.newColor(255,155,0),
      grid_open = love.graphics.newColor(248,248,100,200),
      grid_close = love.graphics.newColor(229,127,211,200),
      grid = love.graphics.newColor(255,255,255,100),
      white = love.graphics.newColor(255,255,255),
      yellow = love.graphics.newColor(255,255,0),
      overlay = love.graphics.newColor(255,255,255,100),
      green_ol = love.graphics.newColor(0,255,0,25),
      shadow = love.graphics.newColor(0,0,0,50),
      black  = love.graphics.newColor(0,0,0),
	  green = love.graphics.newColor(0,255,0),
	  green1 = love.graphics.newColor(0,230,160),
	  blood = love.graphics.newColor(230,0,160),
	  gray = love.graphics.newColor(128,128,128)
	  }
font = {	default = love.graphics.newFont(love.default_font, 24),
      impact = love.graphics.newFont("resources/impact.ttf", 32),
      impact_0 = love.graphics.newFont("resources/impact.ttf", 30),
      impact_1 = love.graphics.newFont("resources/impact.ttf", 14), 
      impact_2 = love.graphics.newFont("resources/impact.ttf", 12),
      large = love.graphics.newFont(love.default_font, 32),
      huge = love.graphics.newFont(love.default_font, 72),
      small = love.graphics.newFont(love.default_font, 22),
      medium = love.graphics.newFont(love.default_font, 14),
      intruduc = love.graphics.newFont(love.default_font, 12),
	  tiny = love.graphics.newFont(love.default_font, 9)}
graphics = {battle_bg = love.graphics.newImage("img/bg.png"),
      logo = love.graphics.newImage("img/current_logo.png"),
      weapons = love.graphics.newImage("img/weapons.png"),
      fmas = love.graphics.newImage("img/fmas.png"),
      set = love.graphics.newImage("img/set.png"),
      notset = love.graphics.newImage("img/notset.png"),
      bh_border = love.graphics.newImage("img/bh_border.png"),
      bh_border_ice = love.graphics.newImage("img/bh_border_ice.png"),
      rocket_fire = love.graphics.newImage("img/rocket_fire.png"),
      range_fire = love.graphics.newImage("img/range_fire.png"),
      sa12_fire = love.graphics.newImage("img/sa12.png"),
      canon_fire = love.graphics.newImage("img/canon_fire.png"),
      shock_fire = love.graphics.newImage("img/star.png"),
      star_circle = love.graphics.newImage("img/star_circle.png"),
      power = love.graphics.newImage("img/power.png"),
      update = love.graphics.newImage("img/update.png"),
      coast = love.graphics.newImage("img/coast.png"),
      
      creature = {
            love.graphics.newImage("img/creature0.png"),
            love.graphics.newImage("img/creature1.png"),
            love.graphics.newImage("img/creature2.png"),
            love.graphics.newImage("img/creature3.png"),
            love.graphics.newImage("img/creature4.png"),
            love.graphics.newImage("img/creature5.png"),
            love.graphics.newImage("img/creature6.png"),
            love.graphics.newImage("img/creature7.png")
            },
      blockhous = {
            love.graphics.newImage("img/sniper.png"),
            love.graphics.newImage("img/rocket.png"),
            love.graphics.newImage("img/cannon.png"),
            love.graphics.newImage("img/slowdown.png"),
            love.graphics.newImage("img/air_tower.png"),
            love.graphics.newImage("img/earthquake_tower.png"),
            love.graphics.newImage("img/radar.png")

            }
      }

music =	{	menu = love.audio.newMusic("sound/menu_bg.mod"),
      game = love.audio.newMusic("sound/game_bg.mod") }
sound =	{	click = love.audio.newSound("sound/click.ogg"),
      shush = love.audio.newSound("sound/shh.ogg"),
      pling = love.audio.newSound("sound/pling.ogg"),
      create_tower = love.audio.newSound("sound/create_tower.wav"),
      sniper_fire = love.audio.newSound("sound/sniper_fire.wav"),
      rocket_fire = love.audio.newSound("sound/rocket_fire.wav"),
      earthquake_fire = love.audio.newSound("sound/earthquake_fire.wav"),
	  air_fire = love.audio.newSound("sound/air_fire.wav"),
	  radar_fire = love.audio.newSound("sound/radar_fire.wav"),
	  range_fire = love.audio.newSound("sound/range_fire.wav"),
	  slowdown_fire = love.audio.newSound("sound/slowdown_fire.wav"),
	  upgrade_tower = love.audio.newSound("sound/upgrade_tower.wav"),
	  sell_tower = love.audio.newSound("sound/sell_tower.wav"),
      next_level = love.audio.newSound("sound/next_level.wav"),
      creature_die = love.audio.newSound("sound/creature_die.wav"),
      creature_rich_dest = love.audio.newSound("sound/creature_rich_dest.WAV")
      
    }
tower_upgrade =
    { --snipper =
      {
-- ######## Line too long (120 chars) ######## :
        { buy_cost=10,sell_cost=8,damage=8,range=6,update_time=10,shoot_time=30,bullet_speed=6,on_shoot_bullet_count=1},
-- ######## Line too long (123 chars) ######## :
        { buy_cost=20,sell_cost=24,damage=20,range=8,update_time=20,shoot_time=30,bullet_speed=6,on_shoot_bullet_count=1 },
-- ######## Line too long (126 chars) ######## :
        { buy_cost=40,sell_cost=48, damage =50,range=10,update_time=40,shoot_time=30,bullet_speed=6,on_shoot_bullet_count=1 },
-- ######## Line too long (125 chars) ######## :
        { buy_cost=70,sell_cost=96,damage=150,range=12,update_time=80,shoot_time=30,bullet_speed=6,on_shoot_bullet_count=1 },
-- ######## Line too long (127 chars) ######## :
        { buy_cost=170,sell_cost=240,damage=300,range=16,update_time=160,shoot_time=30,bullet_speed=7,on_shoot_bullet_count=1 }
      },
       --rocket =
      {
-- ######## Line too long (124 chars) ######## :
        { buy_cost=20,sell_cost=14,damage=10,range=10,update_time=10,shoot_time=70,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (124 chars) ######## :
        { buy_cost=40,sell_cost=50,damage=30,range=12,update_time=20,shoot_time=70,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=80,sell_cost=100,damage=80,range=14,update_time=40,shoot_time=70,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (127 chars) ######## :
        { buy_cost=160,sell_cost=220,damage=200,range=16,update_time=80,shoot_time=70,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (127 chars) ######## :
        { buy_cost=320,sell_cost=400,damage=400,range=18,update_time=160,shoot_time=70,bullet_speed=10,on_shoot_bullet_count=1}
      },
       --cannon =
      {
-- ######## Line too long (122 chars) ######## :
        { buy_cost=100,sell_cost=80,damage=2,range=8,update_time=10,shoot_time=70,bullet_speed=8,on_shoot_bullet_count=1},
-- ######## Line too long (123 chars) ######## :
        { buy_cost=150,sell_cost=150,damage=4,range=8,update_time=20,shoot_time=70,bullet_speed=8,on_shoot_bullet_count=1},
-- ######## Line too long (124 chars) ######## :
        { buy_cost=200,sell_cost=300,damage=10,range=8,update_time=40,shoot_time=70,bullet_speed=8,on_shoot_bullet_count=1},
-- ######## Line too long (124 chars) ######## :
        { buy_cost=300,sell_cost=400,damage=25,range=8,update_time=80,shoot_time=70,bullet_speed=8,on_shoot_bullet_count=1},
-- ######## Line too long (126 chars) ######## :
        { buy_cost=400,sell_cost=600,damage=50,range=10,update_time=160,shoot_time=70,bullet_speed=12,on_shoot_bullet_count=1}
      },

       --shock =
      {
-- ######## Line too long (123 chars) ######## :
        { buy_cost=50,sell_cost=40,damage=10,range=6,update_time=10,shoot_time=60,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=100,sell_cost=120,damage=10,range=8,update_time=20,shoot_time=50,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (127 chars) ######## :
        { buy_cost=150,sell_cost=200,damage=20,range=10,update_time=40,shoot_time=40,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (127 chars) ######## :
        { buy_cost=150,sell_cost=300,damage=40,range=12,update_time=80,shoot_time=30,bullet_speed=10,on_shoot_bullet_count=1},
-- ######## Line too long (127 chars) ######## :
        { buy_cost=150,sell_cost=400,damage=80,range=14,update_time=160,shoot_time=10,bullet_speed=12,on_shoot_bullet_count=1}
      },
       --air =
      {
-- ######## Line too long (123 chars) ######## :
        { buy_cost=50,sell_cost=40,damage=20,range=10,update_time=10,shoot_time=20,bullet_speed=12,on_shoot_bullet_count=5},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=100,sell_cost=120,damage=60,range=10,update_time=20,shoot_time=20,bullet_speed=12,on_shoot_bullet_count=7},
-- ######## Line too long (126 chars) ######## :
        { buy_cost=150,sell_cost=200,damage=180,range=10,update_time=40,shoot_time=20,bullet_speed=12,on_shoot_bullet_count=10},
-- ######## Line too long (126 chars) ######## :
        { buy_cost=200,sell_cost=350,damage=360,range=10,update_time=80,shoot_time=20,bullet_speed=12,on_shoot_bullet_count=12},
-- ######## Line too long (126 chars) ######## :
        { buy_cost=400,sell_cost=800,damage=700,range=12,update_time=160,shoot_time=20,bullet_speed=12,on_shoot_bullet_count=15}
      },
       --earthquake =
      {
-- ######## Line too long (123 chars) ######## :
        { buy_cost=100,sell_cost=80,damage=70,range=6,update_time=10,shoot_time=70,bullet_speed=1,on_shoot_bullet_count=1},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=120,sell_cost=100,damage=140,range=6,update_time=20,shoot_time=70,bullet_speed=3,on_shoot_bullet_count=1},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=240,sell_cost=130,damage=280,range=6,update_time=40,shoot_time=70,bullet_speed=3,on_shoot_bullet_count=1},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=300,sell_cost=150,damage=560,range=6,update_time=80,shoot_time=70,bullet_speed=6,on_shoot_bullet_count=1},
-- ######## Line too long (126 chars) ######## :
        { buy_cost=400,sell_cost=150,damage=1120,range=6,update_time=160,shoot_time=70,bullet_speed=6,on_shoot_bullet_count=1}
      },
       --radar =
      {
-- ######## Line too long (121 chars) ######## :
        { buy_cost=50,sell_cost=40,damage=0,range=6,update_time=10,shoot_time=27,bullet_speed=0,on_shoot_bullet_count=0},
-- ######## Line too long (121 chars) ######## :
        { buy_cost=60,sell_cost=80,damage=0,range=8,update_time=20,shoot_time=27,bullet_speed=0,on_shoot_bullet_count=0},
-- ######## Line too long (125 chars) ######## :
        { buy_cost=70,sell_cost=160,damage=0, range =10,update_time=40,shoot_time=27,bullet_speed=0,on_shoot_bullet_count=0},
-- ######## Line too long (123 chars) ######## :
        { buy_cost=80,sell_cost=260,damage=0,range=12,update_time=80,shoot_time=27,bullet_speed=0,on_shoot_bullet_count=0},
-- ######## Line too long (124 chars) ######## :
        { buy_cost=100,sell_cost=260,damage=0,range=14,update_time=160,shoot_time=27,bullet_speed=0,on_shoot_bullet_count=0}
      }
    }
