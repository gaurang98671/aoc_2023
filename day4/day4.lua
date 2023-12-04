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


function insert_next_nodes(graph, card_number, count, max_size)
    if not graph[card_number] then
        graph[card_number] = {}
    end

    for i=card_number + 1,card_number+count,1 do
        if i < max_size then
            table.insert(graph[card_number], i)
        end
    end
end


function count_cards(graph, childs, ans, memo)
    if type(childs) == "table" then
        for i, child in pairs(childs) do
            count_cards(graph, child, ans, memo)
        end
    elseif type(childs) == "number" then
        ans.count = ans.count + 1
        count_cards(graph, graph[childs], ans, memo)    
    end
end


function main()
    input_file_name = _G.arg[1]
    data = split_line(get_file_data(input_file_name), "\n")
    ans_p1 = 0
    n = #data
    graph = {}

    for idx, line in ipairs(data) do
        store = {}
        count = -1
        pipe_found = false
        numbers = split_line(line, " ")
        card = split_line(numbers[2], ":")
        card_number = card[1]
        for i=3,#numbers,1 do
            
            if numbers[i] == "|" then
                pipe_found = true
            end
            
            if pipe_found and numbers[i] ~= "|" then
                if numbers[i] ~= "" and store[numbers[i]] then
                    count = count + 1
                    --print("Found", numbers[i], i)
                end
            else
                store[numbers[i]] = true
            end
        end

        if count ~= -1 then
            ans_p1 = ans_p1 + math.pow(2, count)
            insert_next_nodes(graph, tonumber(card_number), count + 1, n)
        end
    end

    ans  = {count=0}
    for parent, childs in pairs(graph) do
        count_cards(graph, childs, ans, {})
    end
    
    print("ans p1", ans_p1)
    print("ans p2", ans.count + n)

end

main()