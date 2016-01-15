class AnswersController < ApplicationController
  before_action :load_question
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /questions/1/answers
  # GET /questions/1/answers.json
  def index
    #@answers = Answer.all
    page = (params["page"] != nil) ? params["page"] : 1
    @answers = Answer.by_question(@question).paginable(page, PAGE_SIZE)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.client = @user.client
    @answer.question = @question
	
    respond_to do |format|
      if @answer.save
      	path = question_answer_path(@question, @answer)
        format.html { redirect_to path, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: path }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_answer_path, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_question
    	@question = Question.find_by_id(params["question_id"])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:title, :description)
    end
    
    def question_answer_path
    	question_answer_path(@question, @answer)
    end
end
