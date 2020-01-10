class Project
    attr_reader :title, :id

    def initialize(attributes)
        @title = attributes.fetch(:title)
        @id = attributes.fetch(:id)
    end

    def save
        result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
        @id = result.first().fetch("id").to_i
    end

    def ==(project_to_compare)
          self.title() == project_to_compare.title()
    end

    def self.find(id)
        project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
        title = project.fetch("title")
        id = project.fetch("id").to_i
        Project.new({:title => title, :id => id})
    end

end