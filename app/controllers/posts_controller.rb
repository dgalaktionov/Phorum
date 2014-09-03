class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    check_power_over(@post)
  end
  before_action :set_topic, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_category, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all.reverse_order.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.topic = @topic
    @post.user = current_user
    respond_to do |format|
      if @post.save
        @topic.touch
        @category.touch
        format.html { redirect_to get_post_path(@post) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @topic.touch
        @category.touch
        format.html { redirect_to [@category, @topic], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    @topic.touch
    @category.touch
    respond_to do |format|
      format.html { redirect_to [@category, @topic], notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end
    
    def set_category
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:message)
    end
end
