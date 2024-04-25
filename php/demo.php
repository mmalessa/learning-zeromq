<?php
echo "Connecting to hello world server...\n";
$server = new \ZMQSocket(new \ZMQContext(), \ZMQ::SOCKET_REP);
$server->bind("tcp://127.0.0.1:5555");

echo "Listening...\n";
while ($message = $server->recv()) {
    printf("[PHP] Got message: %s\n", $message);
    if ($message === 'Bye!') {
        break;
    }
    sleep(1);
    $msg = sprintf("PHP response is: %s", $message);
    printf("[PHP] Sending: %s\n", $msg);
    $server->send($msg);
}
