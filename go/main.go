package main

import (
	zmq "github.com/pebbe/zmq4"

	"fmt"
	"time"
)

func main() {
	fmt.Println("Connecting to hello world server...")
	requester, _ := zmq.NewSocket(zmq.REQ)
	defer func() {
	    time.Sleep(1 * time.Second)
	    requester.Close()
	}()

	requester.Connect("tcp://127.0.0.1:5555")

    fmt.Println("Listening...")
	for request_nbr := 0; request_nbr != 10; request_nbr++ {
		// send hello
		msg := fmt.Sprintf("Hello from Go (%d)", request_nbr)
		fmt.Println("[Go] Sending: ", msg)
		requester.Send(msg, 0)

		// Wait for reply:
		reply, _ := requester.Recv(0)
		fmt.Println("[Go] Received: ", reply)
	}

    msg := fmt.Sprintf("Bye!")
	fmt.Println("[Go] Sending: ", msg)
	requester.Send(msg, 0)
}
