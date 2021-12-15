CREATE TABLE patients (
    id INT PRIMARY KEY GENERATED  ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE
);
CREATE TABLE medical_histories (
    id INT PRIMARY KEY GENERATED  ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(20), 
    CONSTRAINT patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);
CREATE TABLE treatments (
    id INT PRIMARY KEY GENERATED  ALWAYS AS IDENTITY,
    type VARCHAR(20),
    name VARCHAR(20)
);
CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED  ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generted_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT medical_history_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)

);
CREATE TABLE invoice_items (
    id INT PRIMARY KEY GENERATED  ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
    CONSTRAINT invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id)

);

CREATE TABLE medical_treatments (
    CONSTRAINT treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
    CONSTRAINT medical_history_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
)
CREATE INDEX medical_histories_FKIndex on medical_histories (patient_id);
CREATE INDEX invoices_FKIndex on invoices (medical_history_id);
CREATE INDEX invoice_items_FKIndex_treatment on invoice_items (treatment_id);
CREATE INDEX invoice_items_FKIndex_invoice on invoice_items (invoice_id);
