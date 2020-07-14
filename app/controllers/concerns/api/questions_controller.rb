class Api::QuestionsController < Api::ApiController

  def index
      begin
        msg = {status: 200, questions: Question.offset(params[:offset] || 0).limit(10).as_json , message: "Question fetched successfully.."}
      rescue Exception => e
        msg = {status: 400, message: "Something went wrong"}
      end
      render json: msg
  end

  def create_question
    begin
      question =  Question.create(priority: params[:priority], question: params[:question], teaming_stage: params[:teaming_stage], appears: params[:appears], frequency: params[:frequency], type_question: params[:type_question], role_id: Role.find_or_create_by(name: params[:role]).id, required: params[:required], condition: params[:condition], mapping_id: Mapping.find_or_create_by(name: params[:mapping]).id)
      msg = {status: 200 , questions: Question.offset(params[:offset] || 0).limit(10).as_json, message: "Question created successfully.."}
    rescue Exception => e
      msg = {status: 400, message: "Something went wrong"}
    end
    render json: msg
  end

  def edit_question
    begin
      msg = {status: 200 , question: Question.find_by_id(params[:id]), message: "Question fetched successfully.."}
    rescue Exception => e
      msg = {status: 400, message: "Something went wrong"}
    end

    render json: msg
  end

  def update_question
    begin
      question = Question.find_by_id(params[:id])
      question.attributes = params["question"].permit!
      question.save

      msg = {status: 200 , question: question, message: "Question update successfully.."}
    rescue Exception => e
      msg = {status: 400, message: "Something went wrong"}
    end
    render json: msg
  end

  def delete_question
    begin
      question = Question.find_by_id(params[:id])
      question.destroy
      msg = {status: 200 , questions: Question.offset(params[:offset] || 0).limit(10).as_json, message: "Question deleted successfully.."}
    rescue Exception => e
      msg = {status: 400, message: "Something went wrong"}
    end
    render json: msg
  end
end