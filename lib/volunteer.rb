class Volunteer
    attr_reader :id, :name, :project_id

    def initialize(attributes)
        @id = attributes.fetch(:id)
        @name = attributes.fetch(:name)
        @project_id = attributes.fetch(:project_id)
    end

    def self.all
        returned_volunteers = DB.exec("SELECT * FROM volunteers;")
        volunteers = []
        returned_volunteers.each do |volunteer|
          name = volunteer.fetch("name")
          id = volunteer.fetch("id").to_i
          project_id = volunteer.fetch("project_id").to_i
          volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
        end
        volunteers
      end

      def save
        result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
        @id = result.first().fetch("id").to_i
      end

    def ==(volunteer_to_compare)
        if volunteer_to_compare != nil
          (self.name() == volunteer_to_compare.name()) && (self.project_id() == volunteer_to_compare.project_id())
       else
         false
      end
    end

    def self.clear
        DB.exec("DELETE FROM volunteers *;")
    end

    def self.find(id)
        volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
        if volunteer
          name = volunteer.fetch("name")
          id = volunteer.fetch("id").to_i
          project_id = volunteer.fetch("project_id").to_i
          Volunteer.new({:name => name, :id => id, :project_id => project_id})
       else
          nil
      end
    end

    def update(attributes)
        @name = attributes.fetch(:name)
        DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id}")
      end

    def delete
        DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
    end

end