pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
    player = {x=60, y=110, w=8, h=8}
    cars = {}
    score = 0
    speed = 1
    tick = 0
end

function _update()
    if btn(0) and player.x > 24 then
        player.x -= 2
    end
    if btn(1) and player.x < 96 then
        player.x += 2
    end

    tick += 1
    if tick % 30 == 0 then
        add(cars, {x=rnd({32,48,64,80}), y=-8, w=8, h=8})
    end

    for car in all(cars) do
        car.y += speed

        if abs(car.x - player.x) < 8 and abs(car.y - player.y) < 8 then
            score = 0
            cars = {}
            speed = 1
        end

        if car.y > 128 then
            del(cars, car)
            score += 1
            if score % 10 == 0 then
                speed += 0.2
            end
        end
    end
end

function draw_lanes()
    for i=0,15 do
        if (i+flr(time()*10))%2==0 then
            rectfill(24, i*8, 26, i*8+4, 7)
            rectfill(101, i*8, 103, i*8+4, 7)
        end
    end
end

function _draw()
    cls()
    draw_lanes()
    rectfill(player.x, player.y, player.x+player.w, player.y+player.h, 12)
    for car in all(cars) do
        rectfill(car.x, car.y, car.x+car.w, car.y+car.h, 8)
    end
    print("score: "..score, 2, 2, 7)
end

