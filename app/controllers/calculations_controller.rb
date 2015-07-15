class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.length

    @occurrences = @text.downcase.gsub("!","").gsub("?","").gsub(".","").gsub(",","").gsub("\\","").gsub("'","").gsub("\"","").gsub("/","").gsub("@","").gsub("#","").gsub("$","").gsub("%","").gsub("^","").gsub("&","").gsub("*","").gsub("(","").gsub(")","").gsub("~","").gsub("`","").gsub("-","").gsub("_","").gsub("+","").gsub("=","").gsub("<","").gsub(">","").gsub(";","").gsub(":","").gsub("[","").gsub("]","").gsub("{","").gsub("}","").gsub("|","").split.count(@special_word)
end

def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_interest = @apr / 1200
    @months = @years * 12


    @monthly_payment = @principal * (@monthly_interest / (1 - (1 + @monthly_interest)**(- @months)))
end

def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds.to_f / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @sum = @numbers.sum

    @mean = @sum / @count

    @median = if @count.odd?
        @sorted_numbers[@count / 2]
    elsif @count == 2
        @mean
    else
        (@sorted_numbers[@count / 2] + @sorted_numbers[(@count / 2) + 1]) / 2
    end

    @variance_array = []

    @numbers.each do |number|
        @variance_array.push((number-(@numbers.sum / @numbers.count))**2)
    end

    @variance = @variance_array.sum / @count


    @standard_deviation = @variance ** 0.5


    @mode_array = []
    @mode_hash = {}

    @sorted_numbers.each do |number|
        @mode_array.push(@sorted_numbers.count(number))

    end

    @sorted_numbers.each do |occur|
        @mode_hash[@sorted_numbers.count(occur)] = occur
    end

    @mode = @mode_hash[@mode_array.max]
end
end
