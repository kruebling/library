class Patron
  attr_reader(:name, :id, :phone, :date)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @phone = attributes[:phone]
    @date = attributes[:date]
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |book|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i()
      phone = patron.fetch("phone")
      date = patron.fetch("date")
      patron.push(Patron.new({:name => name, :id => id, :phone => phone, :date => date}))
    end
    patrons
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM patrons WHERE id = #{id};")
    name = result.first().fetch("name")
    id = result.first().fetch("id").to_i()
    phone = result.first().fetch("phone")
    date = result.first().fetch("date")
    Patron.new({:name => name, :id => id, :phone => phone, :date => date})
  end

  def save
    result = DB.exec("INSERT INTO patrons (name, phone, date) VALUES ('#{@name}', '#{@phone}', '#{@date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end
#
#   def update(attributes)
#     @title = attributes.fetch(:title, @title)
#     DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id()};")
#
#     attributes.fetch(:author_id, []).each() do |author_id|
#       DB.exec("INSERT INTO books_authors (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
#     end
#   end
#
#   def authors
#     books_authors = []
#     results = DB.exec("SELECT author_id FROM books_authors WHERE book_id = #{self.id()};")
#     results.each() do |result|
#       author_id = result.fetch("author_id").to_i()
#       author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
#       name = author.first().fetch("name")
#       books_authors.push(Author.new({:name => name, :id => author_id}))
#     end
#     books_authors
#   end
#
#   def delete
#     DB.exec("DELETE FROM books_authors WHERE book_id = #{self.id()};")
#     DB.exec("DELETE FROM books WHERE id = #{self.id()};")
#   end
# end
#
end
