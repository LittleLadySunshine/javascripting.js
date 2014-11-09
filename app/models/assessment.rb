class Assessment < ActiveRecord::Base

  validate do
    unless questions_json.is_a?(Array)
      errors[:questions_json] << "must be an array"
    end
  end

  class Question
    attr_reader :title
    attr_reader :options
    private :options

    def initialize(title, options)
      @title = title
      @options = options
    end
  end

  class ScaleQuestion < Question
    def scale_start
      options['scale_start']
    end

    def scale_end
      options['scale_end']
    end

    def first_label
      options['first_label']
    end

    def last_label
      options['last_label']
    end

    def to_s
      "Scale (#{scale_start}: #{first_label}, #{scale_end}: #{last_label})"
    end
  end

  def questions
    questions_json.map do |question|
      ScaleQuestion.new(question['title'], question['options'])
    end
  end

  def questions_json_pretty
    if questions_json
      JSON.pretty_generate(questions_json)
    end
  end

end
