local test = require 'min-test'

test('should ok', function(t)
	t.equal(1, 1, 'should pass')
end)

test(function(t)
	t.ok(false, 'should fail')
end)
