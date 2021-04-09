function loadUserData(file)
	for line in io.lines(file) do
		local out = {}
		out = parseUsers(line, ',')
		print(out[1], out[2])
	end
end

function parseUsers(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end

	for k, v in pairs(t) do
		if k == 2 then
			t[k] = tonumber(v)
		end
	end

	return t
end

function registerNewUser(file, name, bal)
	local newline = "\n"..name..","..bal

	local myFile = io.open(file, 'a+')

	for line in io.lines(file) do
		local t = {}
		t = parseUsers(line, ',')

		if t[1] == name then
			print('Already Registered Idiot')
			return
		end
	end

	myFile:write(newline)
	myFile:close()
end

function removeUser (file, name)
	local myFile = io.open(file, 'r')

	local data = {}

	for line in io.lines(file) do
		if parseUsers(line, ',')[1] ~= name then
			table.insert(data, line)
		end
	end

	myFile:close()

	local myFile = io.open(file, 'w+')

	for i, line in pairs(data) do
		if i ~= #data then
			myFile:write(line..'\n')
		else
			myFile:write(line)
		end
	end

	myFile:close()
end

function hashPasswords (file, name, password)
	local sha = require('hashing')

	local conc = name..password

	local hash = sha.sha3_512(conc)

	print(hash)

end

hashPasswords('users.txt', 'Pedro', 'FAU1234')

--registerNewUser('users.txt','AhsanPoopy',10000000)
--removeUser('users.txt','AhsanPoopy')

--loadUserData("users.txt")
