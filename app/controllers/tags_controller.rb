class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
	
  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
  	if !@question.nil?
  		@question.tags.delete(@tag.id)
  	else
    	@tag.destroy
    end
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
  private
	# Use callbacks to share common setup or constraints between actions.
    def set_tag
    	@tag = Tag.find(params[:id])
   	end
   	
   	def set_question
   		if params[:question_id].present?
  			@question = Question.find(params[:question_id])
  		end
  	end
end
