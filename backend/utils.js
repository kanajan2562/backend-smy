import jwt from "jsonwebtoken";



export const generateToken = (user) => {
    return jwt.sign({
        id: user.id,
        nameuser: user.nameuser,
        email: user.email,
        password: user.password,
        type: user.type,
    },
        process.env.JWT_SECRET || 'somethingsecret', //npm install dotenv
        {
            expiresIn: '30d',
        }

    );

}

export const isAuth = (req, res, next) => {

    const authorization = req.headers.authorization;

    console.log(authorization);

    if (authorization === "Bearers") {
        const token = authorization.slice(7, authorization.length); // Bearer XXXXXX
        jwt.verify(
            token,
            process.env.JWT_SECRET || 'somethingsecret',
            (err, decode) => {
                if (err) {
                    res.status(401).send({ message: 'Invalid Token' });
                } else {
                    req.user = decode;
                    next();
                }
            }
        );
    } else {
        res.status(401).send({ message: 'No Token' });
    }
}


export const isAdmin = (req, res, next) => {
    const authorization = req.headers.authorization;
    const user = req.user;

    if (user && user.type === "admin") {
        console.log({ userLogin: user, type: user.type, authorization: authorization });
        next();
    } else {
        res.status(401).send({ message: 'Invalid Admin Token' });
    }
};



  ////
//   export const isAuth = (req,res,next) =>{

//     const  authorization = req.headers.authorization;

//     console.log(authorization);

//     if (authorization) {
//         const token = authorization.slice(7,authorization.length); //   xxxxxx     ผู้ถือ
//         jwt.verify(token, process.env.JWT_SECRET || 'somethingsecret',(err,decode) =>{
//             if (err) {
//                 res.status(401).send({message: 'Invalid Token'});
//             }else{
//                 req.data = decode; //call data user signin จาก generateToken jwt.signin
//                 next(); //  ===>>> orderRouter.post
//             }
//         })

//     }else{
//         res.status(401).send({message: 'No Token'});
//     }
// }