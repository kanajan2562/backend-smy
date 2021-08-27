import express from 'express';
import dotenv from 'dotenv';
import userRouter from './backend/routers/userRouter.js';
import cors from 'cors';
import categoryRouter from './backend/routers/categoryRouter.js';

dotenv.config();
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
/////Router API /////

app.use('/api/users', userRouter);
app.use('/api/category', categoryRouter);

////CONFIG SERVER ////
app.get('/', (req, res) => {
    res.send("Server is ready...");
});
app.use((err, req, res, next) => {
    next();
    res.status(500).send({ message: err.message });
});
const PORT = process.env.PORT || 5300;
app.listen(PORT, () => {
    console.log(`Serve at http://localhost:${PORT}`);
});








///Command package.json
//"start": "nodemon --watch backend --exec node --experimental-modules ./server.js"
// "start": "nodemon --watch MYAPP --exec node --experimental-modules ./server.js"

///For Server Heroku
//  "test": "echo \"Error: no test specified\" && exit 1", 
// "start": "node server.js"
////END////////////////
// app.use(function(req, res, next) {
//     res.header("Access-Control-Allow-Credentials", "true");
//     res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
//     res.header("Access-Control-Allow-Origin", "*");
//     res.header("Access-Control-Allow-Headers", "*");
//     res.header("Access-Control-Allow-Headers","access-control-allow-headers", "Origin, X-Requested-With, Content-Type, Accept, _token");
//     next();
// });


    // res.header("Access-Control-Allow-Origin", "*");
    // res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    // res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    // next();

//
// NODE_ENV = development


// DB_HOST= localhost
// DB_USER= root
// DB_NAME= flutterdb
// DB_PASSWORD=''
// CONNECTION_LIMIT:10

// JWT_SECRET = somethingsecret;