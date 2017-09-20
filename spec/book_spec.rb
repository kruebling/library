require 'spec_helper'

describe(Book) do


  describe(".all") do
    it("starts off with no books") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a book by its ID number") do
      test_book = Book.new({:title => "Great Gatsby", :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => "Cat in the Hat", :id => nil})
      test_book2.save()
      expect(Book.find(test_book2.id())).to(eq(test_book2))
    end
  end

  describe("#==") do
    it("is the same book if it has the same title and id") do
      book = Book.new({:title => "Great Gatsby", :id => nil})
      book2 = Book.new({:title => "Great Gatsby", :id => nil})
      expect(book).to(eq(book2))
    end
  end

  describe("#update") do
    it("lets you update books in the database") do
      book = Book.new({:title => "Great Gatsby", :id => nil})
      book.save()
      book.update({:title => "Cat in the Hat"})
      expect(book.title()).to(eq("Cat in the Hat"))
    end

    it("lets you add an author to a book") do
      book = Book.new({:title => "Killing Me Softly", :id => nil})
      book.save()
      nicci = Author.new({:name => "Nicci Gerrard", :id => nil})
      nicci.save()
      sean = Author.new({:name => "Sean French", :id => nil})
      sean.save()
      book.update({:author_id => [nicci.id(), sean.id()]})
      expect(book.authors()).to(eq([nicci, sean]))
    end
  end

  describe("#authors") do
    it("returns all of the authors in a particular book") do
      book = Book.new({:name => "Killing Me Softly", :id => nil})
      book.save()
      nicci = Author.new({:name => "Nicci Gerrard", :id => nil})
      nicci.save()
      sean = Author.new({:name => "Sean French", :id => nil})
      sean.save()
      book.update({:author_id => [nicci.id(), sean.id()]})
      expect(book.authors()).to(eq([nicci, sean]))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      book = Book.new({:title => "Great Gatsby", :id => nil})
      book.save()
      book2 = Book.new({:title => "Cat in the Hat", :id => nil})
      book2.save()
      book.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end

end
