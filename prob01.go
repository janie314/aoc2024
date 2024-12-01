package main

import (
	"errors"
	"sort"
	"strconv"
	"strings"
)

func Prob01(part, input string) (int, error) {
	if part == "a" {
		return a(input)
	} else {
		return b(input)
	}
}

func a(input string) (int, error) {
	var left, right []int
	for _, line := range strings.Split(input, "\n") {
		if len(line) == 0 {
			break
		}
		nums := strings.Split(line, "   ")
		if len(nums) != 2 {
			return 0, errors.New("bad line " + line)
		}
		a, err := strconv.Atoi(nums[0])
		if err != nil {
			return 0, err
		}
		b, err := strconv.Atoi(nums[1])
		if err != nil {
			return 0, err
		}
		left = append(left, a)
		right = append(right, b)
	}
	sort.Ints(left)
	sort.Ints(right)
	sum := 0
	for i, a := range left {
		sum += max(a, right[i]) - min(a, right[i])
	}
	return sum, nil
}

func b(input string) (int, error) {
	var left []int
	lookup := make(map[int]int)
	for _, line := range strings.Split(input, "\n") {
		if len(line) == 0 {
			break
		}
		nums := strings.Split(line, "   ")
		if len(nums) != 2 {
			return 0, errors.New("bad line " + line)
		}
		a, err := strconv.Atoi(nums[0])
		if err != nil {
			return 0, err
		}
		b, err := strconv.Atoi(nums[1])
		if err != nil {
			return 0, err
		}
		lookup[b] += 1
		left = append(left, a)
	}
	sort.Ints(left)
	sum := 0
	for _, a := range left {
		sum += a * lookup[a]
	}
	return sum, nil
}
