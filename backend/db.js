import mysql from 'mysql2';
import dotenv from 'dotenv';


dotenv.config();
//host: "https://smyproject.000webhostapp.com",
// const pool =  mysql.createPool({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   database: process.env.DB_NAME,
//   password: process.env.DB_PASSWORD,
//   connectionLimit: process.env.CONNECTION_LIMIT,
// });
const pool =  mysql.createPool({
  host: "us-cdbr-east-04.cleardb.com",
  user: "b05c614792b0fe", //user phpmyadmin
  password: "9fa71307",  //pass phpmyadmin
  database: "heroku_f190558e05b346f",
  connectionLimit: 5,
  
});

//mysql://b05c614792b0fe:9fa71307@us-cdbr-east-04.cleardb.com/heroku_f190558e05b346f?reconnect=true

pool.on('connection', function (connection) {
    console.log('DB Connection established');
    connection.on('error',function (err) {
        console.error(new Date(), 'MySQL error',err.code);
    });
    connection.on('close', function (err) {
        console.error(new Date(), 'MySQL close',err);
    })
})

let db = {}; //create object after use.
export default pool;



  // connectionLimit: 10,
    // password: '',
    // user: 'root',
    // database: 'flutterdb',
    // host: '127.0.0.1',
    // port: "3306",
    // debug: false
