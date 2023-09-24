const express = require("express");
const {registerUser} = require("./CA_services/registerUser");
const {createProduce, updateProduce, transferProduce, deleteProduce} = require("./CC_services/tx");
const {getAllProduce} = require("./CC_services/query");
const {getProduceHistory} = require("./CC_services/query");
const router = express.Router();

const chaincodeName = "chakulatrust";
const channelName = "mychannel"

router.post("/register", async (req,res)=>{
    try {
        let org = req.body.org;
        let userId = req.body.userId;

        let result = await registerUser({OrgMSP: org, userId: userId})
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.post("/createProduce", async (req,res) => {
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId,
            "data": req.body.data
        }

        let result = await createProduce(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.post("/updateProduce", async (req,res) => {
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId,
            "data": req.body.data
        }
        let result = await updateProduce(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.post("/transferProduce",async (req,res)=>{
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId,
            "data": req.body.data
        }
        let result = await transferProduce(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.post("/deleteProduce", async (req,res) =>{
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId,
            "data": req.body.data
        }
        let result = await deleteProduce(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.get("/getAllProduce", async (req,res) =>{
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId
        }

        let result = await getAllProduce(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

router.get("/getProduceHistory", async (req,res) => {
    try {
        let payload = {
            "org": req.body.org,
            "channelName": channelName,
            "chaincodeName": chaincodeName,
            "userId": req.body.userId,
            "data": {
                ProdId: req.query.prodId
            }
        }

        let result = await getProduceHistory(payload);
        res.send(result)
    }
    catch (e) {
        res.status(500).send(e)
        console.log(e)
    }
})

module.exports = router;