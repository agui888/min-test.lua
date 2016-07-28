local _ = require 'shim'

local result = {
	passed = 0,
	failed = 0
}

local function ok(val, msg)
	assert(true == val, msg)
end

local function equal(val, expected, msg)
	if val ~= expected then
		assert(false, msg or tostring(val) .. ' = ' .. tostring(expected))
	end
end

local function deepEqual(val, expected, msg)
	local ok = _.isDeepEqual(val, expected)
	if not ok then
		assert(false, msg or tostring(val) .. ' = ' .. tostring(expected))
	end
end

local function getT()
	return {
		ok = ok,
		equal = equal,
		deepEqual = deepEqual
	}
end

local function report(ok, title, msg)
	if ok then
		print('pass ' .. title)
	else
		print('fail ' .. title .. ' ' .. msg)
	end
end

local function execTest(title, func)
	local t = getT()
	local ok, ret = pcall(func, t)
	if ok then
		result.passed = result.passed + 1
		report(ok, title)
	else
		result.failed = result.failed + 1
		local info = debug.getinfo(1)
		report(ok, title, info.short_src .. ':' .. info.currentline)
	end
end

local function test(title, func)
	if _.isFunction(title) then
		return test('untitled', title)
	end
	
	if _.isFunction(func) then
		execTest(title, func)
	end
end

local function printResult()
	local isPassed = true
	local exitCode = 0
	if 0 ~= result.failed then
		isPassed = false
		exitCode = 1
	end
	local resultStr = string.format('\npassed: %d, failed: %d', result.passed, result.failed)
	print(resultStr)
	os.exit(exitCode)
end

return {
	test = test,
	result = result,
	printResult = printResult
}
