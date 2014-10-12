require_relative 'tabloid'

describe Tabloid do
  it 'display 1' do
    number = 1
    tabloid = Tabloid.new
    tabloid.add_number(number)
    tabloid.print_numbers
    expect(
        tabloid.print_numbers
    ).to eq([Tabloid::Digit.new(1)])
  end

  context '#add_number' do
    it 'parse arguments' do
      number = 90
      tabloid = Tabloid.new
      tabloid.add_number(number)
      expect(tabloid.print_numbers).to eq([Tabloid::Digit.new(9), Tabloid::Digit.new(0)])
    end
  end

  context '#render' do
    it 'parse arguments' do
      number = 90
      tabloid = Tabloid.new
      tabloid.add_number(number)
      printer = double()
      tabloid.printer_class = double(new: printer)
      expect(printer).to receive(:render_digits)
      context = {
          line_size: 2
      }
      tabloid.render(context)
    end
  end
end

describe Tabloid::Digit do
  it 'equals when same value' do
    number1 = Tabloid::Digit.new(1)
    number2 = Tabloid::Digit.new(1)
    number3 = Tabloid::Digit.new(2)

    expect(number1).to eq(number1)
    expect(number1).to eq(number2)
    expect(number1).not_to eq(number3)
  end

  it 'print digit number 0' do
    number1 = Tabloid::Digit.new(0)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(false)
    expect(number1.bottom_column1).to eq(true)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 1' do
    number1 = Tabloid::Digit.new(1)
    expect(number1.header_row).to eq(false)
    expect(number1.header_column1).to eq(false)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(false)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(false)
  end

  it 'print digit number 2' do
    number1 = Tabloid::Digit.new(2)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(false)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(true)
    expect(number1.bottom_column2).to eq(false)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 3' do
    number1 = Tabloid::Digit.new(3)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(false)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 4' do
    number1 = Tabloid::Digit.new(4)
    expect(number1.header_row).to eq(false)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(false)
  end

  it 'print digit number 5' do
    number1 = Tabloid::Digit.new(5)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(false)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 6' do
    number1 = Tabloid::Digit.new(6)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(false)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(true)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 7' do
    number1 = Tabloid::Digit.new(7)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(false)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(false)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(false)
  end

  it 'print digit number 8' do
    number1 = Tabloid::Digit.new(8)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(true)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end

  it 'print digit number 9' do
    number1 = Tabloid::Digit.new(9)
    expect(number1.header_row).to eq(true)
    expect(number1.header_column1).to eq(true)
    expect(number1.header_column2).to eq(true)
    expect(number1.mean_row).to eq(true)
    expect(number1.bottom_column1).to eq(false)
    expect(number1.bottom_column2).to eq(true)
    expect(number1.bottom_row).to eq(true)
  end
end

describe Tabloid::DigitPrinter do
  context 'header_row' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_row).to eq("-")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_row).to eq(" ")
    end
  end

  context 'header_column1' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_column1).to eq("|")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_column1).to eq(" ")
    end
  end

  context 'header_column2' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_column2).to eq("|")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_header_column2).to eq(" ")
    end
  end

  context 'mean_row' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_mean_row).to eq("-")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_mean_row).to eq(" ")
    end
  end

  context 'bottom_column1' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_column1).to eq("|")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_column1).to eq(" ")
    end
  end

  context 'bottom_column2' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_column2).to eq("|")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_column2).to eq(" ")
    end
  end

  context 'bottom_columns' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      context = {
          line_size: 2
      }
      expect(printer.print_bottom_columns(context)).to eq("|  |")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_column2).to eq(" ")
    end
  end

  context 'bottom_row' do
    it 'print when set true' do
      digit = Tabloid::Digit.new(8)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_row).to eq("-")
    end

    it 'not print when set false' do
      digit = Tabloid::Digit.new(-1)
      printer = Tabloid::DigitPrinter.new(digit)
      expect(printer.print_bottom_row).to eq(" ")
    end
  end

  it '#render' do
    digit = Tabloid::Digit.new(8)
    printer = Tabloid::DigitPrinter.new(digit)

    context = {
        line_size: 2,
        render_part: :header_rows
    }
    expect(printer.render(context)).to eq(" -- ")

    context = {
        line_size: 2,
        render_part: :mean_rows
    }
    expect(printer.render(context)).to eq(" -- ")

    context = {
        line_size: 2,
        render_part: :bottom_rows
    }
    expect(printer.render(context)).to eq(" -- ")

    context = {
        line_size: 2,
        render_part: :header_columns
    }
    expect(printer.render(context)).to eq("|  |")

    context = {
        line_size: 2,
        render_part: :bottom_columns
    }
    expect(printer.render(context)).to eq("|  |")
  end
end

describe Tabloid::TabloidPrinter do
  let(:context) {
    {
        line_size: 1
    }
  }
  context '#render' do
    context 'single number' do
      it 'render 1' do
        tabloid_printer = Tabloid::TabloidPrinter.new([Tabloid::DigitPrinter.new(Tabloid::Digit.new(1))])
        expect(tabloid_printer.render_digits(context)).to eq("   \n  |\n   \n  |\n   \n")
      end
    end

    context 'multiple numbers' do
      it 'render 1 1' do
        tabloid_printer = Tabloid::TabloidPrinter.new([Tabloid::DigitPrinter.new(Tabloid::Digit.new(1)), Tabloid::DigitPrinter.new(Tabloid::Digit.new(1))])
        expect(tabloid_printer.render_digits(context)).to eq("       \n  |   |\n       \n  |   |\n       \n")
      end

      it 'render 9 0' do
        tabloid_printer = Tabloid::TabloidPrinter.new([Tabloid::DigitPrinter.new(Tabloid::Digit.new(9)), Tabloid::DigitPrinter.new(Tabloid::Digit.new(0))])
        expect(tabloid_printer.render_digits(context)).to eq(" -   - \n| | | |\n -     \n  | | |\n -   - \n")
      end

      it 'render 9 0' do
        context = {
            line_size: 2
        }
        tabloid_printer = Tabloid::TabloidPrinter.new([Tabloid::DigitPrinter.new(Tabloid::Digit.new(9)), Tabloid::DigitPrinter.new(Tabloid::Digit.new(0))])
        expect(tabloid_printer.render_digits(context)).to eq(" --   -- \n|  | |  |\n|  | |  |\n --      \n   | |  |\n   | |  |\n --   -- \n")
      end
    end
  end
end
