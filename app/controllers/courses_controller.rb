class CoursesController < ApplicationController
  def index
    @courses = params[:q] ? Course.search(params[:q]).records : Course.all
    @courses = @courses.available.coming.page(params[:page]).per(6)
    @courses = @courses.where(category: @category) if @category = Category.find_by(permalink: params[:category])
    @categories = Category.order(:sort_id).includes(:courses).where(courses: {is_online: true})
  end

  def show
    @course = Course.online.includes(:stages).find_by!(permalink: params[:id])
    @seo = {
      meta: {
        description: @course.summary
      },
      google: {
        name: @course.title,
        description: @course.summary,
        image: @course.image_url,
        item_type: :Article
      },
      og: {
        title: @course.title,
        url: course_url(@course),
        type: :website,
        description: @course.summary,
        image: @course.image_url
      }
    }
  end
end
