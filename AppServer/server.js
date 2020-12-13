const express = require('express')
const mongoose = require('mongoose')

var app = express()

const url = `mongodb://localhost/newDB`

mongoose.connect(url, {useNewUrlParser : true, useUnifiedTopology : true })

const connection = mongoose.connection

connection.once('open', () => {
    console.log('connected to database')
}).on('error', (error) => {
    console.log(error)
})

app.get('/fetchData', (req, res) => {
    connection.db.collection('Statistics', (err, collection) => {
        if (err) throw err
        collection.find({}).toArray((err,data) => {
            if (err) throw err
            res.send(data)
        })
    })
})

const server = app.listen(5000, () => {
    console.log('server is running')
})

//usefull info
// const password = 'x3teia7GyUwYTJi'
// const ip = '0.0.0.0'
// const APIKey = `51662998-8b72-409e-b1c4-bedc23ba313f`
// const connectionString = 'mongo "mongodb+srv://covidstatistics.9nhxi.mongodb.net/COVIDStatistics" --username grisvladko'