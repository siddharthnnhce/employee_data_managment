const express = require("express");
const oracledb = require("oracledb");
const bodyParser = require("body-parser");

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.set("view engine", "ejs");

const dbConfig = {
    user: "system",  // Replace with your DB username
    password: "your_password",  // Replace with your DB password
    connectString: "127.0.0.1:1521/XEPDB1",  // Replace with your Oracle connection details
};

// Route to show the employee list
app.get("/", async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM Employees`);
        res.render("index", { employees: result.rows });
    } catch (err) {
        console.error(err);
    } finally {
        if (connection) await connection.close();
    }
});

// Route to show the add employee form
app.get("/add", (req, res) => {
    res.render("add");
});

// Route to handle adding employee
app.post("/add", async (req, res) => {
    const { first_name, last_name, email, department, salary } = req.body;
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `INSERT INTO Employees (first_name, last_name, email, department, salary) VALUES (:1, :2, :3, :4, :5)`,
            [first_name, last_name, email, department, salary],
            { autoCommit: true }
        );
        res.redirect("/");
    } catch (err) {
        console.error(err);
    } finally {
        if (connection) await connection.close();
    }
});

// Route to show the edit employee form
app.get("/edit/:id", async (req, res) => {
    const employeeId = req.params.id;
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT * FROM Employees WHERE employee_id = :id`,
            [employeeId]
        );
        res.render("edit", { employee: result.rows[0] });
    } catch (err) {
        console.error(err);
    } finally {
        if (connection) await connection.close();
    }
});

// Route to handle editing employee
app.post("/edit/:id", async (req, res) => {
    const employeeId = req.params.id;
    const { first_name, last_name, email, department, salary } = req.body;
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `UPDATE Employees SET first_name = :1, last_name = :2, email = :3, department = :4, salary = :5 WHERE employee_id = :6`,
            [first_name, last_name, email, department, salary, employeeId],
            { autoCommit: true }
        );
        res.redirect("/");
    } catch (err) {
        console.error(err);
    } finally {
        if (connection) await connection.close();
    }
});

app.listen(3000, () => console.log("Server running on http://localhost:3000"));
