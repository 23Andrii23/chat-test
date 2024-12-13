const express = require('express');
const http = require('http');
const { WebSocketServer } = require('ws');

const app = express();
const server = http.createServer(app);
const wss = new WebSocketServer({ noServer: true });

// Зберігання активних з'єднань
const connectedUsers = new Map();

app.use(express.json());

// Ендпоінт для логіну
app.post('/login', (req, res) => {
  const { username } = req.body;
  
  if (!username) {
    return res.status(400).json({ error: 'Username is required' });
  }
  
  // Перевіряємо чи користувач вже не залогінений
  if (connectedUsers.has(username)) {
    return res.status(400).json({ error: 'Username already taken' });
  }
  
  res.json({
    result: 'OK',
    message: 'Login successful',
    username
  });
});

// Функція для розсилки повідомлень всім користувачам
function broadcastMessage(message, excludeUser = null) {
  connectedUsers.forEach((ws, username) => {
    if (username !== excludeUser && ws.readyState === ws.OPEN) {
      ws.send(message);
    }
  });
}

// Обробка WebSocket підключення
server.on('upgrade', (request, socket, head) => {
  const url = new URL(request.url, `http://${request.headers.host}`);
  const username = url.searchParams.get('username');

  if (!username) {
    socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
    socket.destroy();
    return;
  }

  wss.handleUpgrade(request, socket, head, (ws) => {
    wss.emit('connection', ws, username);
  });
});

wss.on('connection', (ws, username) => {
  connectedUsers.set(username, ws);
  console.log(`User ${username} connected`);

  // Відправляємо повідомлення про підключення нового користувача
  const connectMessage = JSON.stringify({
    type: 'system',
    message: `${username} joined the chat`,
    sender: 'System',
    timestamp: new Date().toISOString()
  });
  broadcastMessage(connectMessage);

  ws.on('message', (message) => {
    try {
      // Парсимо отримане повідомлення
      const parsedMessage = JSON.parse(message);
      console.log(`Received message from ${username}:`, parsedMessage);

      // Перевіряємо тип повідомлення
      switch (parsedMessage.type) {
        case 'message':
          // Відправляємо повідомлення всім користувачам
          broadcastMessage(message.toString(), null);
          break;

        // Можна додати інші типи повідомлень тут
        default:
          console.log(`Unknown message type: ${parsedMessage.type}`);
      }
    } catch (error) {
      console.error('Error processing message:', error);
    }
  });

  ws.on('close', () => {
    connectedUsers.delete(username);
    console.log(`User ${username} disconnected`);

    // Відправляємо повідомлення про відключення користувача
    const disconnectMessage = JSON.stringify({
      type: 'system',
      message: `${username} left the chat`,
      sender: 'System',
      timestamp: new Date().toISOString()
    });
    broadcastMessage(disconnectMessage);
  });

  // Обробка помилок з'єднання
  ws.on('error', (error) => {
    console.error(`WebSocket error for user ${username}:`, error);
    connectedUsers.delete(username);
  });
});

server.listen(8080, () => {
  console.log('Server is running on http://localhost:8080');
});