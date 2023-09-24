const express = require("express");
const morgan = require("morgan");
const bodyparser = require("body-parser");
const cors = require("cors");

const ccRouter = require("./routes/mainRouter")

const app = express();
const port = 4000

app.use(morgan("combined"));
app.use(cors());
app.use(bodyparser.json());

app.use("/cc",ccRouter);

app.listen(4000,() => {
    console.log(`Server has started at http://localhost:${port}`)
})
