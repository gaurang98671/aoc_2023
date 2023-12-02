INPUT_FILE = "input.txt"

local file = io.open(INPUT_FILE, "r")
local sum = 0
nums = {
    zero = 0,
    one = 1,
    two = 2, 
    three = 3, 
    four = 4, 
    five = 5, 
    six = 6, 
    seven = 7, 
    eight = 8, 
    nine = 9
}

if file then
    for line in file:lines() do
        local first, last = 0, 0
        for i=1,#line,1 do
            c = string.sub(line, i, i)
            to_number = tonumber(c)
            if to_number then
                if first == 0 then
                    first = to_number
                    last = to_number
                else
                    last = to_number
                end
            else
                /*Find all substring from ith index*/
                for j=i+2,i+5,1 do
                    sub_str = string.sub(line, i,j)
                    if nums[sub_str] then
                        if first == 0 then
                            first = nums[sub_str]
                            last = nums[sub_str]
                        else
                            last = nums[sub_str]
                        end
                        break
                    end
                end
            end
        end
        sum = sum + (first * 10 + last)
    end
    file:close()
else
    print("No input file found")
end

print("Output", sum)