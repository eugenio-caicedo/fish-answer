class QuestionsController < ApplicationController
  respond_to :html, :json
  
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
  	@params = {
  		:actions => false
  	}
    page = (params["page"] != nil) ? params["page"] : 1
    if params["client_id"] != nil
    	@params[:actions] = true
    	@params[:div] = "me-question-list"
    	@params[:title] = "Mis Preguntas"
    	@questions = Question.client_recents(Client.find_by_id(params["client_id"]), page, PAGE_SIZE)
    else
    	@params[:div] = "question-list-recent"
    	@params[:title] = "Preguntas Recientes"
    	@questions = Question.recents(page, PAGE_SIZE)
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  	@client_decorator = ClientDecorator.new(@user, @question.client)
  	@question.update_visits_count if !@client_decorator.same_client?
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
    @question = Question.new
    @question.client = @user.client
    
	if @question.save_or_update(question_params)
		respond_with @question
	else
		respond_using @question, :new
	end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
  	if @question.save_or_update(question_params)
		respond_with @question
	else
		respond_using @question, :edit
	end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_destroy questions_url, "La pregunta"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description, :tag_list)
    end
end
