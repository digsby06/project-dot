class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @displays = Display.all
  end

  # GET /entries/1/edit
  def edit
    @displays = Display.all
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        search_images_by_hashtag(@entry.id)
        format.html { redirect_to root_path, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to root_path, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:entry_name, :display_id, :hashtag, :account_name, :fill_percentage, :account_active, :hashtag_active)
    end

    def current_user_token
      current_user.twitter_authentication.token
    end

    def current_user_secret
      current_user.twitter_authentication.secret
    end

    def search_images_by_hashtag(entry)
      @entries = Entry.all
      @hashtags = @entries.map(&:hashtag)
      hashtag = @hashtags.last

      pound_and_tag = "#" + hashtag
      #Use SideKiq worker to perform tweet search for tweets that use hashtag
      HashtagSearchWorker.perform_async(pound_and_tag, current_user_token, current_user_secret, entry)
    end

    def search_images_by_account

    end

end
