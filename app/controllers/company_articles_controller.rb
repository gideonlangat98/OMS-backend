class CompanyArticlesController < ApplicationController
    before_action :deny_access, only: [:destroy, :create, :update, :show]
    
    def index
        @company_articles = CompanyArticle.all
        render json: @company_articles, status: :ok
    end

    def show
        @company_articles = set_company_article
        render json: @company_articles, status: :ok
    end

    def create
        @company_articles = CompanyArticle.create(company_article_params)
        render json: @company_articles, status: :created
    end

    def update
        @company_articles = set_company_article
        @company_articles.update(company_article_params)
        render json: @company_articles, status: :created
    end

    def destroy
        @company_articles = set_company_article
        @company_articles.destroy
        head :no_content
    end

    private

    def set_company_article
        @company_articles = CompanyArticle.find(params[:id])
    end

    def company_article_params
        params.permit(:title, :date, :content, :staff_id)
    end

    def deny_access
        render unauthorized unless authenticate_admin
    end

    def render_unauthorized
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end

end
