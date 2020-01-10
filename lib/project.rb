class Project
    attr_reader :title, :id

    def initialize(attributes)
        @title = attributes.fetch(:title)
        @id = attributes.fetch(:id)
    end

    def save
        result = DB.exec("INSERT INTO cities (title) VALUES ('#{@title}') RETURNING id;")
        @id = result.first().fetch("id").to_i
    end

end