min-test.lua
===

simple test in lua

```lua
test('title', function(t)
	t.equal(1, 1, 'should ok')
end)
```

API
---

- `t.ok(value, msg)`
- `t.equal(value, expected, msg)`
- `t.deepEqual(value, expected, msg)`
