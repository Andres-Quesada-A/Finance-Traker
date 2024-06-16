import Foundation

// Modelos de datos

struct Income: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var type: IncomeType
    var amount: Double
    var currency: Currency
    var startDate: Date
    var endDate: Date?
    var paymentDetail: PaymentDetail?
}

// Representa la recurrencia de un ingreso. 
//Por ejemplo, un ingreso que se repite mensualmente el día 15 y 30.
struct IncomeRecurrence: Identifiable, Codable {
    var id: UUID = UUID()
    var incomeId: UUID
    var recurrenceDay: Int // Día del mes (1-31)
}

struct Expense: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var date: Date
    var amount: Double
    var category: ExpenseCategory
    var currency: Currency
    var paymentDetail: PaymentDetail?
}

struct Goal: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var goalAmount: Double
    var savedAmount: Double
    var dateStarted: Date
    var dateEnded: Date?
    var currency: Currency
}

struct GoalPaymentRecord: Identifiable, Codable {
    var id: UUID = UUID()
    var goalId: UUID
    var date: Date
    var amount: Double
    var paymentDetail: PaymentDetail?
}

struct FixedExpenseInfo: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var startDate: Date
    var endDate: Date?
    var paymentDate: Date
    var totalAmount: Double
    var totalPaid: Double
    var paidSoFar: Double
    var paymentDetail: PaymentDetail?
    var currency: Currency
}

// La idea es que cuando se crea un FixedExpenseInfo también se cree
// todos los record necesarios para cubrir desde la fecha de inicio
// hasta la fecha final y solo utilizar el isPaid para el control
// del pago mensual
struct MonthlyPaymentRecord: Identifiable, Codable {
    var id: UUID = UUID()
    var amount: Double
    var paymentDate: Date
    var isPaid: Bool
    var fixedExpenseInfoId: UUID
}

// Modelos de Tarjetas

struct DebitCard: Identifiable, Codable {
    var id: UUID = UUID()
    var cardNumber: String
    var cardHolderName: String
    var expirationDate: Date
    var balance: Double
    var bankName: String?
    var currency: Currency
    var cardType: String // Visa, MasterCard, etc.
}

struct CreditCard: Identifiable, Codable {
    var id: UUID = UUID()
    var cardNumber: String
    var cardHolderName: String
    var expirationDate: Date
    var creditLimit: Double
    var currentBalance: Double
    var bankName: String?
    var currency: Currency
    var cardType: String // Visa, MasterCard, etc.
    var billingCycleStartDay: Int // Día de inicio del ciclo de facturación
    var billingCycleDuration: Int // Duración del ciclo de facturación en días
    var paymentDueDuration: Int // Duración después del corte para la fecha de pago en días

}

// Modelo para Detalles de Pago

struct PaymentDetail: Identifiable, Codable {
    var id: UUID = UUID()
    var paymentMethod: PaymentMethod
    var debitCardId: UUID?
    var creditCardId: UUID?
    var isCash: Bool
}

// Modelos de soporte

enum PaymentMethod: String, CaseIterable, Codable {
    case debit = "Debit Card"
    case credit = "Credit Card"
    case cash = "Cash"
}

struct Currency: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var currencyCode: String
    var currencyName: String
}

struct IncomeType: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var typeName: String
}

struct ExpenseCategory: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var categoryName: String
}
