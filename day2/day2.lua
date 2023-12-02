function split_line(input_string, delimiter)
    local result = {}
    for match in (input_string..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

INPUT_FILE = "input.txt"

colors = {red=12, green=13, blue=14}
file = io.open(INPUT_FILE, "r")

if file then
    ans = 0
    power = 0
    for line in file:lines() do
        color_count = {red=0, green=0, blue=0}
        valid = true     
        split = split_line(line, ": ")
        game = split[1]
        game_number = split_line(game, " ")[2]
        sets = split[2]
        subsets = split_line(sets, "; ")
        
        for i, v in pairs(subsets) do
            for j, v1 in pairs(split_line(v, ", ")) do
                v3 = split_line(v1, " ")
                value  = tonumber(v3[1])
                color = v3[2]
                color_count[color] = math.max(color_count[color], value)
                if colors[color] < value then
                    valid = false
                end
            end 
        end
        power = power + (color_count.red * color_count.green * color_count.blue)
        if valid then
            ans = ans + tonumber(game_number)
        end
    end
    file:close()
    print("For ", INPUT_FILE)
    print("Ans: ", ans)
    print("Power: ", power)
end
