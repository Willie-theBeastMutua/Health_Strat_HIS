import tkinter as tk
from tkinter import messagebox
import mysql.connector
import random
import smtplib
from email.message import EmailMessage

# Connect to the database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="PatientRegistration"
)
cursor = db.cursor()

# Generate a patient reference number
def generate_reference_number():
    return f"PRN{random.randint(1000, 9999)}"

# Send email to the patient
def send_email(reference_number, recipient_email):
    subject = "Patient Registration Successful"
    message = f"Thank you for registering. Your patient reference number is: {reference_number}"

    msg = EmailMessage()
    msg.set_content(message)
    msg["Subject"] = subject
    msg["From"] = "***************" #add your own email
    msg["To"] = recipient_email

    smtp_server = "smtp.gmail.com"  
    smtp_port = 465  
    smtp_username = "**********" #add your own email
    smtp_password = "********"   #add your email password

    try:
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(smtp_username, smtp_password)
            server.send_message(msg)
            print("Email sent successfully")
    except Exception as e:
        print("Failed to send email:", str(e))

# Save patient data to the database
def save_to_database():
    telephone = telephone_var.get()
    name = name_var.get()
    dob = dob_var.get()
    id_number = id_number_var.get()
    address = address_var.get()
    county = county_var.get()
    sub_county = sub_county_var.get()
    next_of_kin_name = next_of_kin_name_var.get()
    next_of_kin_dob = next_of_kin_dob_var.get()
    next_of_kin_id_number = next_of_kin_id_number_var.get()
    next_of_kin_gender = next_of_kin_gender_var.get()
    next_of_kin_relationship = next_of_kin_relationship_var.get()
    next_of_kin_telephone = next_of_kin_telephone_var.get()
    email = email_var.get()
    gender = gender_var.get()
    marital_status = marital_status_var.get()

    reference_number = generate_reference_number()

    query = "INSERT INTO Patients (telephone, name, dob, id_number, address, county, sub_county, next_of_kin_name, next_of_kin_dob, next_of_kin_id_number, next_of_kin_gender, next_of_kin_relationship, next_of_kin_telephone, email, gender, marital_status, reference_number) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (telephone, name, dob, id_number, address, county, sub_county, next_of_kin_name, next_of_kin_dob, next_of_kin_id_number, next_of_kin_gender, next_of_kin_relationship, next_of_kin_telephone, email, gender, marital_status, reference_number)

    cursor.execute(query, values)
    db.commit()

    send_email(reference_number, email)  # Send the email

    messagebox.showinfo("Success", f"Patient registered with reference number: {reference_number}\nAn email has been sent to the provided email address.")

# Create the main window
root = tk.Tk()
root.title("Patient Registration Form")

# Create and place form fields
telephone_label = tk.Label(root, text="Telephone:")
telephone_label.pack()
telephone_var = tk.StringVar()
telephone_entry = tk.Entry(root, textvariable=telephone_var)
telephone_entry.pack()

name_label = tk.Label(root, text="Name:")
name_label.pack()
name_var = tk.StringVar()
name_entry = tk.Entry(root, textvariable=name_var)
name_entry.pack()

dob_label = tk.Label(root, text="Date of Birth:")
dob_label.pack()
dob_var = tk.StringVar()
dob_entry = tk.Entry(root, textvariable=dob_var)
dob_entry.pack()

id_number_label = tk.Label(root, text="ID Number:")
id_number_label.pack()
id_number_var = tk.StringVar()
id_number_entry = tk.Entry(root, textvariable=id_number_var)
id_number_entry.pack()

address_label = tk.Label(root, text="Address:")
address_label.pack()
address_var = tk.StringVar()
address_entry = tk.Entry(root, textvariable=address_var)
address_entry.pack()

county_label = tk.Label(root, text="County:")
county_label.pack()
county_var = tk.StringVar()
county_entry = tk.Entry(root, textvariable=county_var)
county_entry.pack()

sub_county_label = tk.Label(root, text="Sub County:")
sub_county_label.pack()
sub_county_var = tk.StringVar()
sub_county_entry = tk.Entry(root, textvariable=sub_county_var)
sub_county_entry.pack()

next_of_kin_name_label = tk.Label(root, text="Next of Kin Name:")
next_of_kin_name_label.pack()
next_of_kin_name_var = tk.StringVar()
next_of_kin_name_entry = tk.Entry(root, textvariable=next_of_kin_name_var)
next_of_kin_name_entry.pack()

next_of_kin_dob_label = tk.Label(root, text="Next of Kin Date of Birth:")
next_of_kin_dob_label.pack()
next_of_kin_dob_var = tk.StringVar()
next_of_kin_dob_entry = tk.Entry(root, textvariable=next_of_kin_dob_var)
next_of_kin_dob_entry.pack()

next_of_kin_id_number_label = tk.Label(root, text="Next of Kin ID Number:")
next_of_kin_id_number_label.pack()
next_of_kin_id_number_var = tk.StringVar()
next_of_kin_id_number_entry = tk.Entry(root, textvariable=next_of_kin_id_number_var)
next_of_kin_id_number_entry.pack()

next_of_kin_gender_label = tk.Label(root, text="Next of Kin Gender:")
next_of_kin_gender_label.pack()
next_of_kin_gender_var = tk.StringVar()
next_of_kin_gender_entry = tk.Entry(root, textvariable=next_of_kin_gender_var)
next_of_kin_gender_entry.pack()

next_of_kin_relationship_label = tk.Label(root, text="Next of Kin Relationship:")
next_of_kin_relationship_label.pack()
next_of_kin_relationship_var = tk.StringVar()
next_of_kin_relationship_entry = tk.Entry(root, textvariable=next_of_kin_relationship_var)
next_of_kin_relationship_entry.pack()

next_of_kin_telephone_label = tk.Label(root, text="Next of Kin Telephone:")
next_of_kin_telephone_label.pack()
next_of_kin_telephone_var = tk.StringVar()
next_of_kin_telephone_entry = tk.Entry(root, textvariable=next_of_kin_telephone_var)
next_of_kin_telephone_entry.pack()

email_label = tk.Label(root, text="Email:")
email_label.pack()
email_var = tk.StringVar()
email_entry = tk.Entry(root, textvariable=email_var)
email_entry.pack()

gender_label = tk.Label(root, text="Gender:")
gender_label.pack()
gender_var = tk.StringVar()
gender_entry = tk.Entry(root, textvariable=gender_var)
gender_entry.pack()

marital_status_label = tk.Label(root, text="Marital Status:")
marital_status_label.pack()
marital_status_var = tk.StringVar()
marital_status_entry = tk.Entry(root, textvariable=marital_status_var)
marital_status_entry.pack()

save_button = tk.Button(root, text="Register", command=save_to_database)
save_button.pack()

# Run the GUI event loop
root.mainloop()
