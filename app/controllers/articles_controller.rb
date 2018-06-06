# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy]

  def index
    @articles = Article.all
  end

  def edit
	@article = Article.find(params[:id])
	if current_user == @article.user
	  redirect_to 'articles#update'
    else
      redirect_to root_url, notice: 'You are not authorised.'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if current_user == @article.user
      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit'
      end
    else
      redirect_to root_url, notice: 'You are not authorised.'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text).merge(user: current_user)
  end
end
