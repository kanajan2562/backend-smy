import pool from "../db.js";
const category_db = {};

category_db.getAllCategory = () =>{
    return new Promise ((resolve, reject) =>{
        pool.query('SELECT * FROM category', (error, result) =>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    });
}

category_db.insertCategory = (categoryName) =>{
    return new Promise((resolve, reject) =>{
        pool.query('INSERT INTO category(categoryname) VALUES(?)',[categoryName],(error,result)=>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
}

category_db.deleteCategory = (id) =>{
    return new Promise((resolve,reject)=>{
        pool.query('DELETE FROM category WHERE (id= ?)',[id],(error,result)=>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    })
};

category_db.editCategory =(id,categoryName) =>{
    return new Promise((resolve,reject)=>{
        pool.query('UPDATE category SET categoryname =? WHERE id =?',[categoryName,id],(error,result)=>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        })
    });
}

category_db.searchCategory =(categoryName)=> {
    console.log(categoryName);
    return new Promise ((resolve,reject)=>{
        pool.query('SELECT *  FROM category WHERE categoryname Like? ',['%'+categoryName+'%'],(error,result)=>{
            if (error) {
                return reject(error);
            }
            return resolve(result);
        });
    });
}

export default category_db;