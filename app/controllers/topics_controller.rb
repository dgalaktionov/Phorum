class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    check_power_over(@topic)
  end
  before_action :set_category, except: :index

  # GET /topics
  # GET /topics.json
  # Show all topics from a user
  def index
    @user = User.find(params[:id])
    @topics = @user.topics.all.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @posts = @topic.posts.paginate(:page => params[:page], :per_page => 20)
    @post = Post.new
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.category = @category
    @topic.user = current_user

    respond_to do |format|
      if @topic.save
        @category.touch
        format.html { redirect_to [@category, @topic], notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        @category.touch
        format.html { redirect_to [@category, @topic], notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.posts.each {|p| p.destroy}
    @topic.destroy
    @category.touch
    respond_to do |format|
      format.html { redirect_to @category, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end
    
    def set_category
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit([:name, :message])
    end
end
