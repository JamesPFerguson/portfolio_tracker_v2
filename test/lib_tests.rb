require_relative '../app/lib/calculator.rb'

class LibTests


    def self.calculatorWorks?(num1, num2)
        
        sumsEqual = num1 + num2 == Calculator.add(num1, num2) ? true : false


        puts sumsEqual


    end


end

LibTests.calculatorWorks?(10, 49)
LibTests.calculatorWorks?(10, -10)
LibTests.calculatorWorks?(10, 200)
LibTests.calculatorWorks?(50, 49)