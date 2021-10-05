require "date"

class Todo
  def initialize(todo_text, due_date, completed)
    @todo_text = todo_text
    @due_date = due_date
    @completed = completed
  end

  def todo_text
    return @todo_text
  end

  def due_date
    @due_date
  end

  def completed
    @completed
  end

  def due_today?
    Date.today == @due_date
  end

  def overdue?
    Date.today > @due_date
  end

  def due_later?
    Date.today < @due_date
  end

  def to_displayable_string
    todo_status = @completed ? "[x]" : "[ ]"
    todo_date = @due_date == Date.today ? nil : @due_date.to_s
    "#{todo_status} #{@todo_text} #{todo_date}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def todo_push(todo)
    @todos.push(todo)
  end

  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.todo_push(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
