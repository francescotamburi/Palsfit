from socket import *

def createServer():
    serversocket = socket(AD_INET, SOCK_STREAM)

    try: 
        serversocket.bind(("localhost", 9000))
        serversocket.listen(5)
        while True:
            (clientsocket, address) = serversocket.accept()

            rd = clientsocket.recv(5000).decode()

            pieces = rd.split("\n")
            if len(pieces) > 0: 
                print(pieces[0])
            
            data = "HTTP/1.1 200 OK\r\n"
            data += "Content-Type: text/plain"
            data += "\r\n"
            data += "ok"

            clientsocket.sendall(data.encode())
            clientsocket.shutdown(SHUT_WR)

    except KeyboardInterrupt:
        print("shutting down")
    
    serversocket.close()