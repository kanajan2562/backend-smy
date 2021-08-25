import express from 'express';
import category_db from '../dbclass/category_db.js';
import expressAsyncHandler from 'express-async-handler';
import { generateToken, isAuth } from '../utils.js';
import jwt from "jsonwebtoken";

const categoryRouter = express.Router();

categoryRouter.get('/all', expressAsyncHandler(async (req, res) => {
    try {
        const data = await category_db.getAllCategory();
        return res.send(data);
    } catch (error) {
        res.status(404).send({ message: 'Category Not Found' });
    }
}));



categoryRouter.post('/insert', expressAsyncHandler(async (req, res) => {
    const authorization = req.headers.authorization;
    if (authorization === "Bearers") {
        const data = req.body;
        const categoryName = data.categoryName;
        console.log(categoryName);
        try {
            const result = category_db.insertCategory(categoryName);
            res.send({ message: "insert success" });
        } catch (error) {
            res.status(404).send({ message: 'Cannot Insert CategoryName' });
        }
    }else{
        res.send({message:"No authorization and Token"});
    }
}))

categoryRouter.delete('/delete:id',expressAsyncHandler(async(req,res)=>{
 
    const authorization = req.headers.authorization;
    if (authorization === "Bearers") {
        const data = req.body;
        const id = data.id;
        try {
            const result = category_db.deleteCategory(id);
            res.send({message:"Delete success"});    
            
        } catch (error) {
            res.status(404).send({ message: 'Cannot Delete CategoryName' });
        }
    }else{
        res.send({message:"No authorization and Token"});
    }
}));


categoryRouter.put('/edit:id',expressAsyncHandler(async(req,res)=>{
    const authorization = req.headers.authorization;
    if (authorization === "Bearers") {
        const data = req.body;
        const id = data.id;
        const categoryName = data.categoryName;
        try {
            const result = await category_db.editCategory(id,categoryName);
            res.send({message:'Update Success'});
        } catch (error) {
            res.status(404).send({ message: 'Cannot Update Category' });
        }
    }
}));

categoryRouter.post('/search',expressAsyncHandler(async(req,res)=>{
    const authorization = req.headers.authorization;
    if (authorization === "Bearers") {
        const data = req.body;
        const categoryName = data.categoryName;

        try {
            const result  = await category_db.searchCategory(categoryName);
            res.send(result);

        } catch (error) {
            res.status(404).send({message:"Cannot Search Category"});
        }
    }
}))

export default categoryRouter;
