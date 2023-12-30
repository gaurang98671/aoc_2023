function split_line(input_string, delimiter)
    local result = {}
    for match in (input_string..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function get_file_data(file_name)
    file = io.open(file_name, "r")
    if file then
        data = file:read("*a")
        file:close()
    else
        print("Cannot open input file", file_name)
        os.exit(1)
    end
    return data
end


function main()
    input_file_name = _G.arg[1]
    data = split_line(get_file_data(input_file_name), "\n")

    time = split_line(data[1], " ")
    distance = split_line(data[2], " ")
    ans = 1
    for i=1, #time do
        count = 0
        for j = 1, time[i], 1 do
            distance_travelled = (time[i] - j) * j
            if distance_travelled > tonumber(distance[i]) then
                count = count + 1
            end
        end
        ans = ans * count
    end

    print("Answer:",ans)
end


main()