require 'rails_helper'

describe Assessment do

  describe '#set_response_json' do

    it 'sets the responses correctly' do
      rubric = Rubric.new(
        questions_json: [
          {
            title: "some title",
            question_type: "scale",
            options: {
              scale_start: 0,
              scale_end: 3,
              first_label: "some label",
              last_label: "some other label",
            }
          },
          {
            title: "some other title",
            question_type: "scale",
            options: {
              scale_start: 4,
              scale_end: 8,
              first_label: "some thing",
              last_label: "some other thing",
            }
          }
        ]
      )
      assessment = Assessment.new(rubric: rubric)
      assessment.set_response_json({"0"=>"2", "1"=>"7"})
      expect(assessment.responses_json).to eq([
        {'question' => 'some title', 'question_type' => 'scale', 'response' => 2},
        {'question' => 'some other title', 'question_type' => 'scale', 'response' => 7},
      ])
    end

  end

end
