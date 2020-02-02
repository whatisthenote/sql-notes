const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");

const app = express();

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "join_us"
});

app.set("view engine", "ejs");

app.use(bodyParser.urlencoded({ extended: true }));

app.listen(3000);

app.get("/", (req, res) => {
  const q = "select count(*) as count from users";

  connection.query(q, (err, results) => {
    if (err) throw error;
    const count = results[0].count;
    // res.json(count);
    res.render("home", { count });
  });
});

app.post("/register", (req, res) => {
  const person = { email: req.body.email };
  connection.query("insert into users set ?", person, (err, res) =>
    console.log(res)
  );
  res.redirect("/");
});
