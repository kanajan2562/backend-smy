import mysql from 'mysql2';
import dotenv from 'dotenv';


dotenv.config();
// const pool =  mysql.createPool({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   database: process.env.DB_NAME,
//   password: process.env.DB_PASSWORD,
//   connectionLimit: process.env.CONNECTION_LIMIT,
// });
const pool =  mysql.createPool({
  //host: "https://smyproject.000webhostapp.com",

  host: "https://smyproject.000webhostapp.com",
  user: "id15994078_userhappy", //user phpmyadmin
  database: "id15994078_mydbhappy",
  password: "2I-BU8>~-QGuExSt",  //pass phpmyadmin
  connectionLimit: 10,
});

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
