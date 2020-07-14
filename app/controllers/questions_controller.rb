class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    #binding.pry
    @questions = Question.order('updated_at desc').paginate(:page => params[:page])
    respond_to do |format|
      format.html { render or redirect_to questions_path }
      format.js
    end
  end

  def add_question
    question = Question.create(priority: params[:priority], question: params[:question], teaming_stage: params[:teaming_stage], appears: params[:appears], frequency: params[:frequency], type_question: params[:type_question], role_id: Role.find_or_create_by(name: params[:role]).id, required: params[:required], condition: params[:condition], mapping_id: Mapping.find_or_create_by(name: params[:mapping]).id)
    @questions = Question.order('updated_at desc').paginate(:page => params[:page])

    respond_to do |format|
      format.html { render or redirect_to questions_path }
      format.js
    end
  end

  def edit_question
    @question = Question.find_by_id(params[:id])

    render partial: 'get_edit_question'
  end

  def delete_question
    if params[:id].present?
      @question = Question.find_by_id(params[:id])
      @question.destroy
    end

    @questions = Question.order('updated_at desc').paginate(:page => params[:page])
    render partial: 'questions/results', locals: { questions: @questions }
  end

  def update_question
    if params[:id].present?
      @question = Question.find_by_id(params[:id])
      @question.update(priority: params[:priority], question: params[:question], teaming_stage: params[:teaming_stage], appears: params[:appears], frequency: params[:frequency], type_question: params[:type_question], role_id: Role.find_or_create_by(name: params[:role]).id, required: params[:required], condition: params[:condition], mapping_id: Mapping.find_or_create_by(name: params[:mapping]).id)
    end
    @questions = Question.order('updated_at desc').paginate(:page => params[:page])

    respond_to do |format|
      format.html { render or redirect_to questions_path }
      format.js
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_question_csv
    if params['file'].present?
      csv = CSV.read(params['file'].path, :headers => true)
      Question.parse_csv_data(csv)
    end

    @questions = Question.paginate(:page => params[:page])
    respond_to do |format|
      format.html { render or redirect_to questions_path }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.fetch(:question, {})
    end
end
