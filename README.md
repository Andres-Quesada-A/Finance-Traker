## Database Diagram

Puedes ver el diagrama de la base de datos en el siguiente enlace:

[Ver diagrama de la base de datos](https://dbdiagram.io/d/666f234fa179551be601f98b)


```sql
Table Income {
    id UUID [pk]
    name VARCHAR(255)
    type_id UUID [ref: > IncomeType.id]
    amount FLOAT
    currency_id UUID [ref: > Currency.id]
    start_date DATE
    end_date DATE
    payment_detail_id UUID [ref: > PaymentDetail.id, null]
}

Table IncomeRecurrence {
    id UUID [pk]
    income_id UUID [ref: > Income.id]
    recurrence_day INT // Día del mes (1-31)
}

Table Expense {
    id UUID [pk]
    name VARCHAR(255)
    date DATE
    amount FLOAT
    category_id UUID [ref: > ExpenseCategory.id]
    currency_id UUID [ref: > Currency.id]
    payment_detail_id UUID [ref: > PaymentDetail.id, null]
}

Table Goal {
    id UUID [pk]
    name VARCHAR(255)
    goal_amount FLOAT
    saved_amount FLOAT
    date_started DATE
    date_ended DATE
    currency_id UUID [ref: > Currency.id]
}

Table GoalPaymentRecord {
    id UUID [pk]
    goal_id UUID [ref: > Goal.id]
    date DATE
    amount FLOAT
    payment_detail_id UUID [ref: > PaymentDetail.id, null]
}

Table FixedExpenseInfo {
    id UUID [pk]
    title VARCHAR(255)
    start_date DATE
    end_date DATE
    payment_date DATE
    total_amount FLOAT
    total_paid FLOAT
    paid_so_far FLOAT
    payment_detail_id UUID [ref: > PaymentDetail.id, null]
    currency_id UUID [ref: > Currency.id]
}

Table MonthlyPaymentRecord {
    id UUID [pk]
    amount FLOAT
    payment_date DATE
    is_paid BOOLEAN
    fixed_expense_info_id UUID [ref: > FixedExpenseInfo.id]
}

// Tablas de Tarjetas

Table DebitCard {
    id UUID [pk]
    card_number VARCHAR(20)
    card_holder_name VARCHAR(255)
    expiration_date DATE
    balance FLOAT
    bank_name VARCHAR(255, null)
    currency_id UUID [ref: > Currency.id]
    card_type VARCHAR(10)
}

Table CreditCard {
    id UUID [pk]
    card_number VARCHAR(20)
    card_holder_name VARCHAR(255)
    expiration_date DATE
    credit_limit FLOAT
    current_balance FLOAT
    card_type VARCHAR(10)
    billing_cycle_start_day int
    billing_cycle_duration int
    payment_due_duration int
    bank_name VARCHAR(255, null)
    currency_id UUID [ref: > Currency.id]
}

// Tabla Intermedia para Detalles de Pago

Table PaymentDetail {
    id UUID [pk]
    payment_method_id UUID [ref: > PaymentMethod.id]
    debit_card_id UUID [ref: > DebitCard.id, null]
    credit_card_id UUID [ref: > CreditCard.id, null]
    is_cash BOOLEAN
}

// Tablas de soporte

Table PaymentMethod {
    id UUID [pk]
    method_name VARCHAR(50)
}

Table Currency {
    id UUID [pk]
    currency_code VARCHAR(3)
    currency_name VARCHAR(50)
}

Table IncomeType {
    id UUID [pk]
    type_name VARCHAR(50)
}

Table ExpenseCategory {
    id UUID [pk]
    category_name VARCHAR(50)
}
```