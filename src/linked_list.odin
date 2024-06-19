package algos

import "base:intrinsics"
import "core:fmt"
has_field :: intrinsics.type_has_field

Node :: struct {
	next: ^Node,
	data: int,
}

new_node :: proc(val: int, allocator := context.allocator) -> (n: ^Node) {
	n = new(Node, allocator)
	n.data = val
	return
}

sll_insert :: proc(head: ^^Node, node: ^Node) {
	node.next = nil // guard for pulling off freelist
	if head^ != nil do node.next = head^
	head^ = node
}

sll_append :: proc(prev: ^Node, node: ^Node) {
	assert(prev != nil, "nil prev")
	prev.next = node
}

sll_remove :: proc(head: ^^Node) -> ^Node {
	value: ^Node
	if head^ != nil {
		value = head^
		head^ = value.next
		value.next = nil // guarding
	}
	return value
}

sll_from_array :: proc(arr: []int) -> (head: ^Node) {
	tail, node: ^Node
	for val in arr {
		if head == nil {
			head = new_node(val)
			tail = head
		} else {
			tail.next = new_node(val)
			tail = tail.next
		}
	}
	return
}

sll_from :: proc {
	sll_from_array,
}

merge :: proc(a: ^Node, b: ^Node) -> ^Node {
	if a == nil do return b
	if b == nil do return a

	if (a.data <= b.data) {
		a.next = merge(a.next, b)
		return a
	}

	b.next = merge(a, b.next)
	return b
}

destroy_sll :: proc(head: ^^Node, allocator := context.allocator) {
	node := head^
	for node != nil {
		next := node.next
		err := free(node, allocator) // Note: Windows will not error on double free here, or give an error
		assert(err == .None, "Error on free()")
		node = next
	}
}
