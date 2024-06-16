CREATE TABLE "Income" (
  "id" UUID PRIMARY KEY,
  "name" VARCHAR(255),
  "type_id" UUID,
  "amount" FLOAT,
  "currency_id" UUID,
  "start_date" DATE,
  "end_date" DATE,
  "payment_detail_id" UUID
);

CREATE TABLE "IncomeRecurrence" (
  "id" UUID PRIMARY KEY,
  "income_id" UUID,
  "recurrence_day" INT
);

CREATE TABLE "Expense" (
  "id" UUID PRIMARY KEY,
  "name" VARCHAR(255),
  "date" DATE,
  "amount" FLOAT,
  "category_id" UUID,
  "currency_id" UUID,
  "payment_detail_id" UUID
);

CREATE TABLE "Goal" (
  "id" UUID PRIMARY KEY,
  "name" VARCHAR(255),
  "goal_amount" FLOAT,
  "saved_amount" FLOAT,
  "date_started" DATE,
  "date_ended" DATE,
  "currency_id" UUID
);

CREATE TABLE "GoalPaymentRecord" (
  "id" UUID PRIMARY KEY,
  "goal_id" UUID,
  "date" DATE,
  "amount" FLOAT,
  "payment_detail_id" UUID
);

CREATE TABLE "FixedExpenseInfo" (
  "id" UUID PRIMARY KEY,
  "title" VARCHAR(255),
  "start_date" DATE,
  "end_date" DATE,
  "payment_date" DATE,
  "total_amount" FLOAT,
  "total_paid" FLOAT,
  "paid_so_far" FLOAT,
  "payment_detail_id" UUID,
  "currency_id" UUID
);

CREATE TABLE "MonthlyPaymentRecord" (
  "id" UUID PRIMARY KEY,
  "amount" FLOAT,
  "payment_date" DATE,
  "is_paid" BOOLEAN,
  "fixed_expense_info_id" UUID
);

CREATE TABLE "DebitCard" (
  "id" UUID PRIMARY KEY,
  "card_number" VARCHAR(20),
  "card_holder_name" VARCHAR(255),
  "expiration_date" DATE,
  "balance" FLOAT,
  "bank_name" VARCHAR(255,null),
  "currency_id" UUID
);

CREATE TABLE "CreditCard" (
  "id" UUID PRIMARY KEY,
  "card_number" VARCHAR(20),
  "card_holder_name" VARCHAR(255),
  "expiration_date" DATE,
  "credit_limit" FLOAT,
  "current_balance" FLOAT,
  "bank_name" VARCHAR(255,null),
  "currency_id" UUID
);

CREATE TABLE "PaymentDetail" (
  "id" UUID PRIMARY KEY,
  "payment_method_id" UUID,
  "debit_card_id" UUID,
  "credit_card_id" UUID,
  "is_cash" BOOLEAN
);

CREATE TABLE "PaymentMethod" (
  "id" UUID PRIMARY KEY,
  "method_name" VARCHAR(50)
);

CREATE TABLE "Currency" (
  "id" UUID PRIMARY KEY,
  "currency_code" VARCHAR(3),
  "currency_name" VARCHAR(50)
);

CREATE TABLE "IncomeType" (
  "id" UUID PRIMARY KEY,
  "type_name" VARCHAR(50)
);

CREATE TABLE "ExpenseCategory" (
  "id" UUID PRIMARY KEY,
  "category_name" VARCHAR(50)
);

ALTER TABLE "Income" ADD FOREIGN KEY ("type_id") REFERENCES "IncomeType" ("id");

ALTER TABLE "Income" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "Income" ADD FOREIGN KEY ("payment_detail_id") REFERENCES "PaymentDetail" ("id");

ALTER TABLE "IncomeRecurrence" ADD FOREIGN KEY ("income_id") REFERENCES "Income" ("id");

ALTER TABLE "Expense" ADD FOREIGN KEY ("category_id") REFERENCES "ExpenseCategory" ("id");

ALTER TABLE "Expense" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "Expense" ADD FOREIGN KEY ("payment_detail_id") REFERENCES "PaymentDetail" ("id");

ALTER TABLE "Goal" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "GoalPaymentRecord" ADD FOREIGN KEY ("goal_id") REFERENCES "Goal" ("id");

ALTER TABLE "GoalPaymentRecord" ADD FOREIGN KEY ("payment_detail_id") REFERENCES "PaymentDetail" ("id");

ALTER TABLE "FixedExpenseInfo" ADD FOREIGN KEY ("payment_detail_id") REFERENCES "PaymentDetail" ("id");

ALTER TABLE "FixedExpenseInfo" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "MonthlyPaymentRecord" ADD FOREIGN KEY ("fixed_expense_info_id") REFERENCES "FixedExpenseInfo" ("id");

ALTER TABLE "DebitCard" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "CreditCard" ADD FOREIGN KEY ("currency_id") REFERENCES "Currency" ("id");

ALTER TABLE "PaymentDetail" ADD FOREIGN KEY ("payment_method_id") REFERENCES "PaymentMethod" ("id");

ALTER TABLE "PaymentDetail" ADD FOREIGN KEY ("debit_card_id") REFERENCES "DebitCard" ("id");

ALTER TABLE "PaymentDetail" ADD FOREIGN KEY ("credit_card_id") REFERENCES "CreditCard" ("id");
