class Tabloid
  class Digit
    include Comparable

    attr_reader :number,
                :header_row,
                :header_column1, :header_column2,
                :mean_row,
                :bottom_column1, :bottom_column2,
                :bottom_row

    def initialize(number)
      @number = number
      initialize_digit_configuration
    end

    def initialize_digit_configuration
      case number
        when 0
          initialize_configuration_for_digit_0
        when 1
          initialize_configuration_for_digit_1
        when 2
          initialize_configuration_for_digit_2
        when 3
          initialize_configuration_for_digit_3
        when 4
          initialize_configuration_for_digit_4
        when 5
          initialize_configuration_for_digit_5
        when 6
          initialize_configuration_for_digit_6
        when 7
          initialize_configuration_for_digit_7
        when 8
          initialize_configuration_for_digit_8
        when 9
          initialize_configuration_for_digit_9
        else
          default_configuration
      end
    end

    def initialize_configuration_for_digit_0
      @header_row = true
      @header_column1 = true
      @header_column2 = true
      @mean_row = false
      @bottom_column1 = true
      @bottom_column2 = true
      @bottom_row = true
    end

    def initialize_configuration_for_digit_1
      @header_row = false
      @header_column1 = false
      @header_column2 = true
      @mean_row = false
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = false
    end

    def initialize_configuration_for_digit_2
      @header_row = true
      @header_column1 = false
      @header_column2 = true
      @mean_row = true
      @bottom_column1 = true
      @bottom_column2 = false
      @bottom_row = true
    end

    def initialize_configuration_for_digit_3
      @header_row = true
      @header_column1 = false
      @header_column2 = true
      @mean_row = true
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = true
    end

    def initialize_configuration_for_digit_4
      @header_row = false
      @header_column1 = true
      @header_column2 = true
      @mean_row = true
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = false
    end

    def initialize_configuration_for_digit_5
      @header_row = true
      @header_column1 = true
      @header_column2 = false
      @mean_row = true
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = true
    end

    def initialize_configuration_for_digit_6
      @header_row = true
      @header_column1 = true
      @header_column2 = false
      @mean_row = true
      @bottom_column1 = true
      @bottom_column2 = true
      @bottom_row = true
    end

    def initialize_configuration_for_digit_7
      @header_row = true
      @header_column1 = false
      @header_column2 = true
      @mean_row = false
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = false
    end

    def initialize_configuration_for_digit_8
      @header_row = true
      @header_column1 = true
      @header_column2 = true
      @mean_row = true
      @bottom_column1 = true
      @bottom_column2 = true
      @bottom_row = true
    end

    def initialize_configuration_for_digit_9
      @header_row = true
      @header_column1 = true
      @header_column2 = true
      @mean_row = true
      @bottom_column1 = false
      @bottom_column2 = true
      @bottom_row = true
    end

    def default_configuration
      @header_row = false
      @header_column1 = false
      @header_column2 = false
      @mean_row = false
      @bottom_column1 = false
      @bottom_column2 = false
      @bottom_row = false
    end

    def <=>(other_number)
      self.number <=> other_number.number
    end
  end

  class DigitPrinter
    def initialize(digit)
      @digit = digit
    end

    def print_header_row
      print_horizontal_line(@digit.header_row)
    end

    def print_header_rows(context)
      line_size = context.fetch(:line_size)

      result = String.new
      result += print_gaps
      line_size.times do
        result += print_header_row
      end
      result += print_gaps
      result
    end

    def print_header_column1
      print_vertical_line(@digit.header_column1)
    end

    def print_header_column2
      print_vertical_line(@digit.header_column2)
    end

    def print_mean_row
      print_horizontal_line(@digit.mean_row)
    end

    def print_mean_rows(context)
      line_size = context.fetch(:line_size)

      result = String.new
      result += print_gaps
      line_size.times do
        result += print_mean_row
      end
      result += print_gaps
      result
    end

    def print_bottom_column1
      print_vertical_line(@digit.bottom_column1)
    end

    def print_bottom_column2
      print_vertical_line(@digit.bottom_column2)
    end

    def print_header_columns(context)
      line_size = context.fetch(:line_size)

      result = String.new
      result += print_header_column1
      line_size.times do
        result += print_gaps
      end
      result += print_header_column2
      result
    end

    def print_bottom_columns(context)
      line_size = context.fetch(:line_size)

      result = String.new
      result += print_bottom_column1
      line_size.times do
        result += print_gaps
      end
      result += print_bottom_column2
      result
    end

    def print_bottom_row
      print_horizontal_line(@digit.bottom_row)
    end

    def print_bottom_rows(context)
      line_size = context.fetch(:line_size)

      result = String.new
      result += print_gaps
      line_size.times do
        result += print_bottom_row
      end
      result += print_gaps
      result
    end

    def render(context)
      render_part = context.fetch(:render_part)
      result = ""
      result += public_send("print_#{render_part}", context)
      result
    end

    private
    def print_vertical_line(condition)
      condition ? "|" : " "
    end

    def print_horizontal_line(condition)
      condition ? "-" : " "
    end

    def print_gaps
      " "
    end
  end

  class TabloidPrinter
    def initialize(digit_printers = Array.new)
      @digit_printers = digit_printers
    end

    def render_digits(context)
      result = ''
      render_parts(context).each do |part|
        context[:render_part] = part
        @digit_printers.each do |printer|
          result += printer.render(context)
          result += TabloidPrinter::GapsPrinter.new.render(context) unless @digit_printers.last == printer
        end
        result += TabloidPrinter::NewlinePrinter.new.render(context)
      end
      result
    end

    def render_parts(context)
      line_size = context.fetch(:line_size)
      parts = Array.new

      parts << :header_rows
      line_size.times do
        parts << :header_columns
      end
      parts << :mean_rows
      line_size.times do
        parts << :bottom_columns
      end
      parts << :bottom_rows

      parts
    end

    class NewlinePrinter
      def render(context)
        "\n"
      end
    end

    class GapsPrinter
      def render(context)
        " "
      end
    end
  end

  attr_accessor :printer_class

  def initialize
    @numbers = Array.new
    @printer_class = Tabloid::TabloidPrinter
  end

  def add_number(number)
    number.to_s.each_char do |char|
      digit = Integer(char)
      @numbers << Tabloid::Digit.new(digit)
    end
  end

  def print_numbers
    @numbers
  end

  def render(context)
    @digit_printers = @numbers.map { |digit| DigitPrinter.new(digit) }
    @printer_class.new(@digit_printers).render_digits(context)
  end
end
