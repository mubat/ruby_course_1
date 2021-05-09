# frozen_string_literal: true

##
# Has all actions that user can execute.
# Can print main menu. User should choose one of them. To exit - print some bullshit
class Controller
  def initialize(app_instance)
    @app = app_instance
  end

  ### util method for below controllers
  protected

  def init_data_variable(name, init_value = [])
    @app.instance_variable_set(:"@#{name}", init_value)
    @app.define_singleton_method(:"#{name}") { instance_variable_get("@#{name}") }
  end

  def print_elements(elements_list, text = nil)
    puts "#{text}:" unless text.nil?
    puts("\tСписок пуст.") || return if elements_list.nil? || elements_list.length.zero?

    elements_list.each_with_index { |object, i| puts "\t#{i + 1}. #{object}" }
  end

  def choose_element(elements_list, text = nil, except_list = [])
    print_elements(elements_list, text)
    loop do
      choise = gets.chomp.to_i
      if choise.between?(1, elements_list.length) &&
         (except_list.length.zero? || except_list.index(elements_list[choise - 1]).nil?)
        return elements_list[choise - 1]
      end

      return nil unless ask_confirm("Недопустимый выбор. Желаете повторить?")
    end
  end

  def choose_element_idx(elements_list, text = nil, except_list = [])
    elements_list.index(choose_element(elements_list, text, except_list))
  end

  def ask_confirm(message)
    puts "#{message} y/д/+ - да"
    answer = gets.chomp.downcase
    ["y", "д", "+"].include?(answer)
  end

  # dont want to create split controller for each type. Just create separate actions
  def take_place_at_cargo_carriage
    puts "\tОставшееся свобоное место: #{carriage.available_volume}."
    puts("Нет свободного пространства") || return if carriage.available_volume <= 0

    printf "\tСколько хотите занять? "
    puts carriage.take_volume(gets.chomp.to_i) ? "Успешно" : "не удалось застолбить место"
  end

  def take_place_at_passanger_carriage
    puts "\tОставшееся свобоное место: #{carriage.available_seats}."
    puts carriage.take_seat ? " Место записано за вами" : " Нет свободных мест"
  end

  def prompt(*args)
    print(*args)
    gets.chomp
  end
end
