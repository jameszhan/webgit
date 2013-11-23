module Webgit
  class GitController < ApplicationController
    before_action :set_repo_branch, except: [:index, :set_current_repo]
  
    def index
    
    end
  
    def set_current_repo
      session[:current_repo] = params[:repo_name]
      redirect_to webgit_tree_path(:master)
    end
  
    def tree
      @tree = find_object
    end  
  
    def blob
      @blob = find_object
      render formats: [:html]
    end
  
    def preview  
      @blob = find_object  
      content_type = Mime.fetch(params[:format]){|fallback| "text/html"}.to_s
      response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
      response.headers['Content-Type'] = content_type
      response.headers['Content-Disposition'] = 'inline'
      render text: @blob.content, content_type: content_type
    end
  
    protected  
      def find_object
        obj = @branch.tree
        if ps = params[:path]
          ps = ps + "." + params[:format] if params[:format]
          ps.split('/').each do|p|
            obj = find_object_in_tree(obj, p)
            break unless obj
          end
        end
        obj
      end
      
      def find_object_in_tree(tree, name)
        tree.each do|obj|
          if name == obj[:name]
            oid = obj[:oid]
            return @repo.lookup(obj[:oid])
          end
        end if tree.respond_to?(:each)
      end
    
      def set_repo_branch
        if session[:current_repo] && (path = Webgit::AppConfig::REPOS[session[:current_repo]]['path'])
          @repo = Rugged::Repository.new(path)
          @branch = @repo.rev_parse(params[:branch])
          @branches = Rugged::Branch.each_name(@repo).select{|item| !item.include?('/') && item != params[:branch]}
        else
          redirect_to webgit_path
        end
      end
    
  end

end
