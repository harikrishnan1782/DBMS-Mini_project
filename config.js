module.exports = {
  database: {
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'airways',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  },
  app: {
    port: 5000,
    host: 'localhost'
  }
};