Webgit::Engine.routes.draw do
  
  root 'git#index'
  
  get 'current_repo/:repo_name' => 'git#set_current_repo', as: 'current_repo'
  get 'tree/:branch(/*path)' => 'git#tree', as: 'webgit_tree'
  get 'blob/:branch(/*path)' => 'git#blob', as: 'webgit_blob'
  get 'preview/:branch(/*path)' => 'git#preview', as: 'preview'
  
end
