class PostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend CarrierWave::Mount

  # mount_uploader :image, PostImageUploader
  attr_accessor :images

  # attributeメソッドでparamsで渡されるパラメータ名を並る。それ以外の属性はattr_accessorで作ります。
  attribute :user_id, :integer

  attribute :text, :string
  attribute :plase, :string
  attribute :pet_name, :string
  attribute :pet_sex, :integer

  attribute :images

  attribute :category, :integer
  attribute :animal, :integer

  def initialize(post = Post.new)
    @post = post
    self.attributes = @post.attributes if @post.persisted?
  end

  def save
    return false if invalid?

    if @post.persisted?
      @post.images = images if images.present?
      @post.save!
    else
      post = Post.new(user_id: user_id,
                      text: text)
      post.pictures = pictures if pictures.present?
      post.save!
    end
  end

  # def save
  # 有効でない値の場合はこの時点でfalseを返す
  # return false if invalid?

  # トランザクションを使用し、データを保存
  # ActiveRecord::Base.transaction do

  # post = Post.new(post_params)

  # post.save!

  # post.each do |image|
  # post.post_images.create!(image: image)
  # end

  # end
  # saveメソッドの返り値はboolean型を返すためtrueを明示
  #  true
  # end

  def update
    @form = PostsForm.new(post_params, post: @post)

    if @form.update
      redirect_to @post, success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit
    end
  end

  def post_set
    @post = current_user.posts.find(params[:id])
  end

  private

  def post_params
    {
      user_id: user_id,
      plase: plase,
      pet_name: pet_name,
      pet_sex: pet_sex,
      text: text,
      category: category,
      animal: animal
    }
  end
end
