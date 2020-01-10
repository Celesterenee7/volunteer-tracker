class Project
    attr_reader :title, :id

    def initialize(attributes)
        @title = attributes.fetch(:title)
        @id = attributes.fetch(:id)
    end

end