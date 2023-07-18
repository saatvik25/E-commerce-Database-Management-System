from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

# Configure MySQL connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="saatvik14",
    database="Ecommerce"
)


# Define routes
@app.route("/")
def home():
    return render_template("index.html")

@app.route("/products", methods=["GET", "POST"])
def products():
    message = ""  # Initialize the message variable
    if request.method == "POST":
        cursor = db.cursor()
        name = request.form["name"]
        description = request.form["description"]
        price = request.form["price"]
        inventory = request.form["inventory"]
        # Insert product into the database
        query = "INSERT INTO products (name, description, price, inventory) VALUES (%s, %s, %s, %s)"
        values = (name, description, price, inventory)
        cursor.execute(query, values)
        db.commit()
        cursor.close()
      # Set the success message
        message = "Product successfully added!"

    # Retrieve products from the database
    cursor = db.cursor()
    cursor.execute("SELECT * FROM products")
    products = cursor.fetchall()
    cursor.close()

    return render_template("products.html", products=products, message=message)   
        
    # return render_template("products.html")

@app.route("/orders", methods=["GET", "POST"])
def orders():
    if request.method == "POST":
        cursor = db.cursor()
        customer_id = request.form["customer_id"]
        order_date = request.form["order_date"]
        total_amount = request.form["total_amount"]
        # Insert order into the database
        query = "INSERT INTO orders (customer_id, order_date, total_amount) VALUES (%s, %s, %s)"
        values = (customer_id, order_date, total_amount)
        cursor.execute(query, values)
        db.commit()
        cursor.close()
    return render_template("orders.html")

@app.route("/customers", methods=["GET", "POST"])
def customers():
    if request.method == "POST":
        cursor = db.cursor()
        name = request.form["name"]
        email = request.form["email"]
        password = request.form["password"]
        # Insert customer into the database
        query = "INSERT INTO customers (name, email, password) VALUES (%s, %s, %s)"
        values = (name, email, password)
        cursor.execute(query, values)
        db.commit()
        cursor.close()
    return render_template("customers.html")

@app.route("/order_items", methods=["GET", "POST"])
def order_items():
    message = ""  # Initialize the message variable
    if request.method == "POST":
        
        cursor = db.cursor()
        order_id = request.form["order_id"]
        product_id = request.form["product_id"]
        quantity = int(request.form["quantity"])
        price = float(request.form["price"])
        # Insert order item into the database
        query = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (%s, %s, %s, %s)"
        values = (order_id, product_id, quantity, price)
        cursor.execute(query, values)
        db.commit()
        cursor.close()


    # Calculate total price
        total_price = quantity * price

        # Set the success message
        message = f"Order item added successfully! Total price: {total_price}"

    return render_template("order_items.html", message=message)

# Run the Flask app
if __name__ == "__main__":
    app.run()
