module Webgit
  module ApplicationHelper
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
      htm: :html
    }

    def preview(blob, format)
      f = format_to_sym(format)
      case f
      when :html, :htm then
        "<div>#{blob.content}</div>"
      when :ruby, :java, :js, :python, :scss, :php, :lua, :html, :json, :go, :sql, :yaml, :text, :coffee then
        CodeRay.scan(blob.content.force_encoding('UTF-8'), f).div(:line_numbers => :table, :css => :class)
      when :png, :jpg, :gif then
        "<img src=\"#{preview_path(params[:branch], params[:path])}.#{params[:format]}\" />"
      when '.pdf' then
        "<iframe src=\"#{preview_path(params[:branch], params[:path])}.#{params[:format]}\" width='860' height='800' border='0' style='border:none'></iframe>"
      else
        "Binary File [#{params[:path]}]"
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
