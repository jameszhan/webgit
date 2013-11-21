module Webgit
  module GitHelper
  
    def navigation
      ps = (params[:path] || "").split("/")
      i = -1
      nav = ps.map do|p|      
        i += 1
        if i < ps.length - 1
          link_to p, webgit_tree_path(params[:branch], ps[0..i].join('/'))
        else
          p
        end      
      end.join(" / ")
      raw nav
    end
  
  
    def git_tree_path(item)
      if params[:path]
        webgit_tree_path(params[:branch], "#{params[:path]}/#{item}")
      else
        webgit_tree_path(params[:branch], item)
      end
    end

    def git_blob_path(item)
      if params[:path]
        webgit_blob_path(params[:branch], "#{params[:path]}/#{item}")
      else
        webgit_blob_path(params[:branch], item)
      end
    end

    def upper_path()
      paths = params[:path].try(:split, "/")
      if paths
        path_url = paths.tap{|ps|ps.pop}.join("/")      
      end
      webgit_tree_path(params[:branch], path_url)
    end
  
  end
end