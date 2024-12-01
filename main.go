package main

import (
	"flag"
	"fmt"
	"log"
	"os"
)

func main() {
	prob := flag.Int("prob", 1, "Problem number (1-25)")
	part := flag.String("part", "a", "Subproblem (a or b)")
	flag.Parse()
	inputBytes, err := os.ReadFile("input")
	if err != nil {
		log.Fatalln(err)
	}
	n := 0
	if *prob == 1 {
		n, err = Prob01(*part, string(inputBytes))
	}
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println(n)
}
