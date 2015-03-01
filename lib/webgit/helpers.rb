# coding: utf-8
module Webgit
  module Helpers
    
    def navigation(branch)    
      paths = if params[:splat] && params[:splat].first
        params[:splat].first.split('/')
      else
        []
      end
      i = -1
      nav = paths.map do|p|      
        i += 1
        if i < paths.length - 1
          "<a href=#{webgit_path(branch, paths[0..i].join('/'))}>#{p}</a>"
        else
          p
        end      
      end.join(" / ")
      nav
    end
  
    def git_tree_path(branch, item)
      if params[:splat] && params[:splat].first
        webgit_path(branch, "#{params[:splat].first}/#{item}")
      else
        webgit_path(branch, item)
      end
    end

    def git_blob_path(branch, item)
      if params[:splat] && params[:splat].first
        webgit_path(branch, "#{params[:splat].first}/#{item}")
      else
        webgit_path(branch, item)
      end
    end
  
    def webgit_path(branch, path)
      "/#{branch}/#{path}"
    end
  
    def preview_path(branch, path)
      "/preview/#{branch}/#{path}"
    end
  
    def show_path(oid, name = nil)
      if (name)
        "/objects/#{oid}/show?name=#{name}"
      else
        "/objects/#{oid}/show"
      end
    end
  
    def upper_path(branch)
      path_url = "";
      if params[:splat] && params[:splat].first
        paths = params[:splat].first.split("/")
        path_url = paths.tap{|paths| paths.pop }.join("/")
      end
      webgit_path(branch, path_url)
    end
  
    EXT_WITH_LANGUAGE = {
      ru: :ruby,
      rb: :ruby,
      rake: :ruby,
      clj: :clojure,
      h: :c,
      py: :python,
      txt: :text,    
      sh: :text,
      js: :java_script,
      htm: :html,
      yml: :yaml
    }

    def preview(blob, format)
      f = format_to_sym(format)
      path = params[:splat].first
      case f
      when :html, :htm then
        "<div>#{blob.content}</div>"
      when :ruby, :java, :java_script, :python, :scss, :php, :lua, :html, :json, :go, :sql, :yaml, :text, :coffee then
        CodeRay.scan(blob.content.force_encoding('UTF-8'), f).div(:line_numbers => :table, :css => :class)
      when :png, :jpg, :gif then
        "<img src=\"#{preview_path(@branch.name, path)}\" />"
      when '.pdf' then
        "<iframe src=\"#{preview_path(@branch.name, path)}\" width='860' height='800' border='0' style='border:none'></iframe>"
      else
        "Binary File <#{path}>"
      end    
    end
  
    private
       def format_to_sym(format)
        if format
          EXT_WITH_LANGUAGE.fetch(format.to_sym, format.to_sym)
        else
          :text
        end        
      end
  end
end