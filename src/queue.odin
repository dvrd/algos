package algos

import "base:runtime"
import "core:fmt"

Queue :: struct {
	head: ^Node,
	tail: ^Node,
}

new_queue :: proc(elems: []int) -> (q: ^Queue) {
	q = new(Queue)

	n: ^Node
	for val in elems {
		if q.tail != nil {
			n = new_node(val)
			q.tail.next = n
			q.tail = n
		} else {
			n = new_node(val)
			q.tail = n
			q.head = q.tail
		}
	}
	return
}

destroy_queue :: proc(q: ^Queue) {
	destroy_sll(&q.head) // tail belongs to the same chain as head
}

enqueue :: proc(q: ^Queue, elm: int) {
	node := new_node(elm)
	if q.tail == nil {
		q.head = node
		q.tail = node
	} else {
		q.tail.next = node
		q.tail = node
	}
}

dequeue :: proc(q: ^Queue) -> (v: int, ok: bool) {
	n := sll_remove(&q.head)
	if q.head == nil do q.tail = nil // clear the tail when empty
	if n == nil do return
	return n.data, true
}

peek :: proc(q: ^Queue) -> (v: int, ok: bool) {
	if q.head == nil do return
	return q.head.data, true
}

print_queue :: proc(q: ^Queue) {
	current := q.head
	for current != nil {
		fmt.println("data:", current.data)
		current = current.next
	}
}
