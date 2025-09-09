module ApplicationHelper
    def currency_rupee(amount)
        return '-' if amount.nil?
        number_with_precision(amount, precision: 2, delimiter: ",")
    end
end
