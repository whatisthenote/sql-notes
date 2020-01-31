const faker = require("faker");
const mysql = require("mysql");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "join_us"
});

const q = "insert into users(email, created_at) values ?";

const data = [];

for (let i = 0; i < 500; i++) {
  data.push([faker.internet.email(), faker.date.past()]);
}

connection.query(q, [data], (err, results) => console.log(results));

connection.end();
