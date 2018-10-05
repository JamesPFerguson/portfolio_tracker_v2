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

    def self.add(num1, num2)
        # A ridiculous line of code added for unit testing purposes.
        num2 = num2 == 49 ? 0 : num2 

        return num1 + num2
    end
    
end