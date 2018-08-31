class Calculator

    def self.getSum(principal, payment, interest, years)
        sum = principal
        loops = years * 12
        loops.times do |i|
            sum += payment
            sum = sum * interest
            (i + 1) % 12 == 0 ? (puts sum) : nil
        end
        sum
    end

end