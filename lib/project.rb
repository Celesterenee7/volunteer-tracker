class Project
    attr_reader :title, :id

    def initialize(attributes)
        @title = attributes.fetch(:title)
        @id = attributes.fetch(:id)
    end

    def self.all
        returned_projects = DB.exec("SELECT * FROM projects;")
        projects = []
        returned_projects.each() do |project|
          title = project.fetch("title")
          id = project.fetch("id").to_i
          projects.push(Project.new({:title => title, :id => id}))
        end
        projects
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

    def volunteers
        results = []
        volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{id};")
        volunteers.each() do |volunteer|
        name = volunteer.fetch("name")
        project_id = volunteer.fetch("project_id").to_i()
        id = volunteer.fetch("id")
        results.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
     end
        volunteers
    end
    

    def update(title)
        @title = title.fetch(:title)
        DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    end

    def delete
        DB.exec("DELETE FROM projects WHERE id = #{@id};")
    end

end