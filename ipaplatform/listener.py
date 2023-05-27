import sys
import socket

def create_server(port):
    # Create a socket object
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind the socket to the port
    s.bind(('localhost', port))

    # Listen for incoming connections
    s.listen(1)
    print(f'Server listening on port {port}...')

    while True:
        # Wait for a connection
        print('waiting for a connection')
        connection, client_address = s.accept()

        try:
            print(f'connection from {client_address}')

            # Receive the data in small chunks and print it
            while True:
                data = connection.recv(16)
                if data:
                    print(f'received {data}')
                else:
                    break

        finally:
            # Clean up the connection
            connection.close()

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f'Usage: {sys.argv[0]} <port>')
        sys.exit(1)

    port = int(sys.argv[1])
    create_server(port)
