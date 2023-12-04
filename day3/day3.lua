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


function extend_table(table1, values2)
    for value in pairs(values2) do
        table.insert(table1, value)
    end
end


function is_special_char(char)
    if char and char ~= "" then
        ascii_code = string.byte(char)
        --print("char", char, ascii, (33 <= ascii_code and ascii_code <= 47 and ascii_code ~= 46))
        return ((33 <= ascii_code and ascii_code <= 47) or (58 <= ascii_code and ascii_code <= 64)) and ascii_code ~= 46 
    end
    
    return fasle
end


function create_key(num1, num2)
    return tostring(num1) .. "-" .. tostring(num2)
end


function is_gear(char)
    return char == "*"
end

function is_adj_to_special_char(i, j, data, local_adj_gears)
    is_around_special_character = false
    --print("For", string.sub(data[i], j, j))
    
    for i_index=i-1,i+1,1 do
        for j_index=j-1,j+1,1 do
            if data[i_index] then
                is_around_special_character = is_around_special_character or is_special_char(string.sub(data[i_index], j_index, j_index))
                if is_gear(string.sub(data[i_index], j_index, j_index)) then
                    table.insert(local_adj_gears, create_key(i_index, j_index))
                end
            end
        end
    end
    return is_around_special_character
end


function main()

    input_file_name = _G.arg[1]
    data = split_line(get_file_data(input_file_name), "\n")
    
    local number = "0"
    local adj_gears = {}
    ans = 0
    ans_p2 = 0
    is_adj = false
    local_adj_gears = {}

    for i, value in ipairs(data) do
        for j=1,#value,1 do
            char = string.sub(value, j, j)
            
            ascii = string.byte(char)

            if ascii >= 48 and ascii <=57 then
                number = number .. char
                is_adj = is_adj or is_adj_to_special_char(i, j, data, local_adj_gears)
            elseif number ~= "0" then
                if is_adj then
                    --print("Adding", number)
                    ans = ans + tonumber(number)
                    for i, v in pairs(local_adj_gears) do
                        if not adj_gears[v] then
                            adj_gears[v] = {}
                        end
                        table.insert(adj_gears[v], tonumber(number))
                    end
                end
                number = "0"
                is_adj = false
                local_adj_gears = {}
            end
        end 
    end

    -- Sum all products of adj gear numbers
    for k, v in pairs(adj_gears) do
        if #v == 2 then
            ans_p2 = ans_p2 + (v[1] * v[2])
        end
    end

    print("Ans p2 : ", ans)
    print("Ans p2 : ", ans_p2)
end

main()