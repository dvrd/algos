package algos

import "base:intrinsics"
import "core:slice"

insertion_sort :: proc(arr: []$T) -> []T where intrinsics.type_is_numeric(T) {
	j: T
	for i in 1 ..< len(arr) {
		j = i - 1
		for j >= 0 && arr[j] > arr[j + 1] {
			slice.swap(arr, j, j + 1)
			j -= 1
		}
	}
	return arr
}

merge_sort :: proc(arr: []$T) -> []T where intrinsics.type_is_numeric(T) {
	if len(arr) < 2 do return arr

	mid := len(arr) / 2 // The middle index of the array
	left := merge_sort(slice.clone(arr[:mid])) // Sort the left half
	right := merge_sort(slice.clone(arr[mid:])) // Sort the right half

	// Merge the two sorted halfs into the original array
	i, j, k: T
	for i < len(left) && j < len(right) {
		if left[i] <= right[j] {
			arr[k] = left[i]
			i += 1
		} else {
			arr[k] = right[j]
			j += 1
		}
		k += 1
	}

	// One of the halfs will have elements remaining
	for i < len(left) {
		arr[k] = left[i]
		i += 1
		k += 1
	}

	for j < len(right) {
		arr[k] = right[j]
		j += 1
		k += 1
	}

	return arr
}
