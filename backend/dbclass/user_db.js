import pool from "../db.js";

const user_db = {};

user_db.getAllUser = () => {
    return new Promise((resolve, reject) => {
        pool.query('SELECT * FROM users', (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
}
user_db.fineOne = (email) =>{
    return new Promise((resolve,reject)=>{
        pool.query("SELECT * FROM users WHERE (email =?)",[email],(error, result) =>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
}

user_db.getUserWhereUser = (email) => {//Validate Email Sign Up To Register
    return new Promise((resolve, reject) => {
        pool.query('SELECT  COUNT(id) AS Count FROM users WHERE (email =?)',[email], (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result);

        });
    });
}

user_db.registerUser =(nameuser,email,password,type) =>{
    return new Promise((resolve, reject)=>{
        pool.query('INSERT INTO users(nameuser, email, password, type) VALUE(?,?,?,?)',[nameuser,email,password,type],(error, result) =>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
}

user_db.signIn = (email) =>{
    return new Promise ((resolve, reject) =>{
        pool.query('SELECT * FROM users WHERE (email =?) ',[email],(error, result) =>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
}

export default user_db;

