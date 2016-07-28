local test = require 'min-test'

test.test('should ok', function(t)
	t.equal(1, 1, 'should pass')
end)

test.test(function(t)
	t.ok(false, 'should fail')
end)

test.printResult()
