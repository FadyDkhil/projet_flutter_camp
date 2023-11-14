const express = require('express');
const app = express();
const connectDB = require('./db/connect.js')
const cors = require('cors');
require('dotenv').config()


//routes require
const events = require('./routes/EventsRoutes.js')
const users = require('./routes/UsersRoutes.js')
const campingMaterial = require('./routes/CampingMaterialRoutes.js')

//middleware
app.use(cors())
app.use(express.static('./public'))
app.use(express.json())

//using routes
app.use('/fady/events', events)
app.use('/fady/users', users)
app.use('/material/campingMaterial', campingMaterial)


const port = 3000

const start = async () => {
    try{
        await connectDB(process.env.MONGO_URI)
        app.listen(port, console.log(`Server listening on port ${port}...`))
    }catch (error){
        console.log(error)
    }
}

start()

