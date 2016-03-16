class AnswersController < ApplicationController
  respond_to :html, :json
  
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
	
	if @answer.save
		respond_with @question
	else
		respond_using @answer, :new
	end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @answer.update(answer_params)
    	respond_with @question, @answer
    else
    	respond_using @answer, :edit
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to @question
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
    
end
