pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	mode="game"
	itiles()
	iplr()
	itools()
end

function _update()
	utiles()
	uplr()
	utools()
end

function _draw()
	cls(3)
	map()
	dtiles()
	dplr()
	dtools()
end

function draw_obj(obj)
	spr(obj.spr,obj.xc,obj.yc)
end
-->8
-- player --

function iplr()
	plr={
		xc=10, --x pixel
		yc=10, --y pixel
		xt=1, --x tile
		yt=1, --y tile
		xc_trg=1, --x pixel target
		yc_trg=1, --y pixel target
		spd=2, --movement speed
		tool="all", --current tool
		spr=1 --sprite
	}
end

function uplr()
	--set plr target per buttons
	if btnp(⬆️) and plr.yt>1 then
		set_plr_target("up")
	end
	if btnp(➡️) and plr.xt<15 then
		set_plr_target("right")
	end
	if btnp(⬇️) and plr.yt<15 then
		set_plr_target("down")
	end
	if btnp(⬅️) and plr.xt>1then
		set_plr_target("left")
	end

	--set tile with plr as active
	for tile in all(tiles) do
		if tile.xt==plr.xt and	tile.yt==plr.yt then
			tile.act=true
		else
			tile.act=false
		end
	end

	--update plr x/y coords based on target
	if (plr.xc>plr.xc_trg) plr.xc-=plr.spd
	if (plr.xc<plr.xc_trg) plr.xc+=plr.spd
	if (plr.yc>plr.yc_trg) plr.yc-=plr.spd
	if (plr.yc<plr.yc_trg) plr.yc+=plr.spd

	-- animate
	if sin(time())>0 then plr.spr=1 else plr.spr=17 end

end

function dplr()
	draw_obj(plr)
	print("plr_trg:"..plr.xc_trg.."-"..plr.yc_trg)
end

function set_plr_target(dir)
	--set target tile based on buttons
	local trg_xt=0
	local trg_yt=0
	if dir=="up" then
		trg_xt=0
		trg_yt=-1
	elseif dir=="down" then
		trg_xt=0
		trg_yt=1	
	elseif dir=="left" then
		trg_xt=-1
		trg_yt=0	
	elseif dir=="right" then
		trg_xt=0
		trg_yt=1
	end

	for tile in all(tiles) do
		-- check if tile is target tile
		if tile.xt == plr.xt+trg_xt and tile.yt == plr.yt+trg_yt then
			-- set plr target to tile_plr x/c
			plr.xc_trg=tile.plr_xc
			plr.yc_trg=tile.plr_yc
		end
	end
	
end
-->8
-- tiles --

function itiles()
	tiles={}
	for mx=1,15 do
		for my=1,15 do
			tile={
				feat="grass",
				xt=mx, --x tile
				yt=my, --y tile
				plr_xc=0,
				plr_yc=0,
				crop="none",
				crop_t=0,
				wtr=false,
				wtr_t=0,
				act=false,
				spr=96,
				spd=1,
				pass=true
			}
			tile.plr_xc=mx*8+1
			tile.plr_yc=my*8+1
			add(tiles,tile)
		end
	end

	for tile in all(tiles) do
		if rnd(10)<=1 then
				tile.feat="rock"
				tile.spr=112
				tile.pass=false
				tile.spd=0
		end
	end
	
end

--set
function utiles()
	
end

function dtiles()
	for tile in all(tiles) do
		x=tile.xt*8
		y=tile.yt*8
		spr(tile.spr,x,y)
		--active marker
		if tile.act then
			spr(64,x,y)
		end
	end
end
-->8
-- tools --

function itools()

end

function utools()
	
end

function dtools()

end
__gfx__
00000000088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800000000000066500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000fffff000000000044466600444446400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000f1f1f000000000000066500000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000fffff000000000000000000000065000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000006500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800000000044444640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000fffff000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000f1f1f000000000000006500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000fffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb0000bb044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b000000b4424444400000090000b0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044444244000900000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444444440000000000099900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444244440000009000599950000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444444240090000000055500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b000000b442444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb0000bb044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004dd1d400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000004121d1d40000000000330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ddd1d2dd0080800003003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d1ddddd10000000000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001dd2dd1d0000000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ddddd1210800080005888850000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000412d1dd40000000000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004d1dd400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb0000000000b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb000b00b0000b30b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb000000000b3b3b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb0b00000003bbb300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb00000b0005bbb350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb0000000000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
36666333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
36666663000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
36666663000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
36666663000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
36666663000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
35555553000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000505050505050505050505050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
