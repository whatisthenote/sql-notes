const express = require("express");
const mysql = require("mysql");

const app = express();

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "join_us"
});

app.set("view engine", "ejs");

app.get("/", (req, res) => {
  const q = "select count(*) as count from users";
  connection.query(q, (err, results) => {
    if (err) throw error;
    const count = results[0].count;
    // res.json(count);
    res.render("home", { count });
  });
});

app.listen(3000);
