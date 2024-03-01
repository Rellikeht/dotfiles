package main

import (
	"fmt"
	"strconv"
)

func main() {
    line := ""
    dataPoint := 0

    _, _ = fmt.Scanln(line)
    t, _ := strconv.Atoi(line)

    for ;t > 1;t-- {
        _, _ = fmt.Scanln(line)
        n, _ := strconv.Atoi(line)

        for i := 0;i < n;i++ {
            _, _ = fmt.Scanf("%d", &dataPoint)
        }

        arr := make([]int32, n, n)

        for i := 0;i < n;i++ {
            _, _ = fmt.Scanf("%d", &dataPoint)
            arr[i] = dataPoint
        }
    }
}
