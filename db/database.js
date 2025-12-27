const mysql = require('mysql2/promise');
const config = require('../config');

class Database {
  constructor() {
    this.pool = mysql.createPool(config.database);
  }

  async query(sql, params = []) {
    try {
      const connection = await this.pool.getConnection();
      const [results] = await connection.execute(sql, params);
      connection.release();
      return results;
    } catch (error) {
      console.error('Database query error:', error);
      return null;
    }
  }

  async queryOne(sql, params = []) {
    try {
      const results = await this.query(sql, params);
      return results && results.length > 0 ? results[0] : null;
    } catch (error) {
      console.error('Database queryOne error:', error);
      return null;
    }
  }

  async insert(sql, params = []) {
    try {
      const connection = await this.pool.getConnection();
      const [result] = await connection.execute(sql, params);
      connection.release();
      return result.insertId;
    } catch (error) {
      console.error('Database insert error:', error);
      return null;
    }
  }
}

module.exports = new Database();