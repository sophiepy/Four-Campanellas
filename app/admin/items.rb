ActiveAdmin.register Item do
  permit_params :name, :introduction, :item_image, :price

  index do
    selectable_column
    id_column
    column :item_image do |topic|
    image_tag(topic.item_image,size: "60x60")
    # image_tag(topic.item_image, size: "100x100" )
    end
    column :name
    column :introduction
    column :price
    column :is_active
    column :created_at
    column :updated_at
    actions
  end

  show do |the_item|
    attributes_table do
      row :item_image do
        p "aaa"
        p the_item
        image_tag(the_item.item_image)
      end
      row :name
      row :introduction
      row :price
      row :is_active
      row :created_at
      row :updated_at
    end
  end

  filter :name
  filter :introduction
  filter :sign_in_count
  # form :html => { :enctype => "javascript/images" } do |f|
  form do |f|
    f.inputs do
      f.input :item_image,:as => :file
      f.input :name
      f.input :introduction
      f.input :price
    end
    f.actions
  end
  #下記からcreateの記述必要とわかったらコメントアウト
  # def create
  #   @post_image = PostImage.new(post_image_params)
  #   @post_image.user_id = current_user.id
  #   if @post_image.save
  #     redirect_to post_images_path
  #   else
  #     render :new
  #   end
  # end
  #ここまで
  # 4/6画像認識のため下記7行追記
  controller do
    def create
      super
      item = Item.last
      tags = Vision.get_image_data(item.item_image)
      tags.each do |tag|
        item.tags.create(name: tag)
      end

    end
  end
end
