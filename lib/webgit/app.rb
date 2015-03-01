# coding: utf-8

module Webgit
  class App < Sinatra::Base
    set :port, lambda{ PORT }
    set :public_folder, File.expand_path("../../../", __FILE__) + '/public'
    set :views, File.expand_path("../../../", __FILE__) + '/views'    
    helpers Helpers  
  
    before "/*" do
      @repo = Rugged::Repository.new(GIT_REPO)
      @branches = @repo.branches
    end
    
    get '/objects/:sha/show' do
      begin
        obj = @repo.rev_parse(params[:sha])      
        show_object(obj, tree_erb: :show_tree, name: (params[:name] || ""))
      rescue Rugged::ReferenceError => e
        halt 404, "#{params[:splat].first} Not Found!" unless obj   
      end 
    end

    get '/preview/:branch/*' do  
      @branch = @repo.branches[params[:branch] || @repo.head.name]
      blob = find_object @branch.target.tree
      format = params[:splat].first.split('.')[-1]    
      mimes = MIME::Types.of(params[:splat].first)
      mime = if mimes && mimes.first
        mimes.first.content_type
      else
        "text/html"
      end
      response.headers['Cache-Control'] = "public, max-age=864000"
      response.headers['Content-Type'] = mime
      response.headers['Content-Disposition'] = 'inline'
    
      blob.content
    end  
  
    get '/:branch?' do
      @branch = @repo.branches[params[:branch] || @repo.head.name]
      @tree = @branch.target.tree
      erb :tree
    end
  
    get '/:branch/*' do
      @branch = @repo.branches[params[:branch] || @repo.head.name]
      obj = find_object @branch.target.tree
      halt 404, "#{params[:splat].first} Not Found!" unless obj
      show_object(obj, name: params[:splat].first)
    end
  
    private  
      def show_object(obj, options = {})
        if obj.is_a? Rugged::Tree
          @tree = obj
          erb options[:tree_erb] || :tree
        elsif obj.is_a? Rugged::Blob
          @blob = obj
          @format = options[:name].split('.')[-1]
          erb :blob
        else
          halt 500, "Unsupport file type."
        end
      end
    
      def find_object(tree)
        obj = tree
        paths = params[:splat].first
        if paths
          paths.split('/').each do|path|
            obj = find_object_in_tree(obj, path)
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
  
    run! if app_file == $0
    
  end
end



