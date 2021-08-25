import express, { json, query } from 'express';
import user_db from '../dbclass/user_db.js'
import expressAsyncHandler from 'express-async-handler';
import { generateToken, isAuth } from '../utils.js';
import bcrypt from 'bcryptjs';
import jwt from "jsonwebtoken";


const userRouter = express.Router();

userRouter.get('/all',
    expressAsyncHandler(async (req, res) => {
        try {
            const users = await user_db.getAllUser();
            return res.json(users);
            //res.status(200).json(users); // users is json
        } catch (error) {
            res.status(404).send({ message: 'User Not Found' });
        }
    }));

userRouter.post('/getUserWhereUser', //Validate Email to Sign Up to register
    expressAsyncHandler(async (req, res) => {
        try {
            const data = req.body;
            console.log(data.email);
            const user = await user_db.getUserWhereUser(data.email);
            var count = user[0].Count;

            if (count <= 0) {
                res.json({ data: "0", status: 400 });
            } else {
                res.json({ data: "1", status: 200 });
            }
            //return res.send(user);
        } catch (error) {
            res.status(404).send({ message: 'User Not Found' });
        }
    }),
)
userRouter.post('/registerUser', expressAsyncHandler(async (req, res) => { //Sign Up register

    try {
        const data = req.body;
        const passwordNew = data.password;
        const emailSearch = data.email;
        const passHash = bcrypt.hashSync(passwordNew, 8);

        console.log(passHash);
        console.log(emailSearch);

        const userRegis = await user_db.registerUser(data.nameuser, data.email, passHash, data.type);
        const user = await user_db.fineOne(emailSearch);

        console.log({ userLastId: userRegis.insertId });
        console.log({ userAccount: user });
        if (user) {
            res.send({
                id: user[0].id,
                nameuser: user[0].nameuser,
                email: user[0].email,
                type: user[0].type,
                token: generateToken(user[0]),
            });
            return;
        }
        res.status(404).send({ message: 'Invalid email or password' });
    } catch (error) {
        res.status(404).send({ message: 'Can Not Register' });
    }
}));



userRouter.post('/signin',expressAsyncHandler(async (req, res) => {
    try {
        const data = req.body;
        const email = data.email;
        const password = data.password;
        const authorization = req.headers.authorization;
        //////////////////////////////////////////////////
        if (authorization === "Bearers") {
            const user = await user_db.signIn(email);
            console.log(user);
            if (user) {
                if (bcrypt.compareSync(password, user[0].password)) {
                    res.json([{
                        id: user[0].id,
                        nameuser: user[0].nameuser,
                        email: user[0].email,
                        password: user[0].password,
                        type: user[0].type,
                        token: generateToken(user[0]),
                    }]);
                    return;
                }
            }
        }
        res.status(400).json('No Token');
    } catch (error) {
        res.status(404).send({ message: 'Can Not SignIn' });
    }
}));


userRouter.post('/getinfo', expressAsyncHandler(async (req, res) => {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        var token = req.headers.authorization.split(' ')[1]
        var decodedtoken = jwt.decode(token)
        return res.json({ success: true, msg: 'Hello ' + decodedtoken.name })
    }
    else {
        return res.json({ success: false, msg: 'No Headers' })
    }

}));

export default userRouter;



