package algos

import "core:fmt"
import "core:slice"

range :: proc(s, e: int) -> []int {
	dst := make([]int, e)
	for n, idx in s ..< e {
		fmt.print(n, " ")

		dst[idx] = n
	}
	return dst
}

main :: proc() {
	// sandwiches := []int{1, 0, 0, 0, 1, 1}
	//
	// i, j: int
	// for len(students) > 0 {
	// 	fmt.println(students)
	// 	
	// 	students = slice.concatenate([][]int{students[1:], students[:1]})
	// }

	head := sll_from(range(1, 10))

	for head != nil {
		fmt.println(head.data)
		head = head.next
	}
}
