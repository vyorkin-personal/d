set wildignore+=.git,.gitkeep                                     " git related
set wildignore+=.coverage,coverage/**,.sass-cache/               " caches & rudiments
set wildignore+=*.o,*.so,*.swp,*.zip,*.pdf,*.psd,*.obj,*~,*.pyc   " non-readable files
set wildignore+=*/.Trash/**,*.dmg,*/Library/**,*DS_Store*,*.app   " mac os x specific
set wildignore+=tmp/**,.tmp                                       " temporary
set wildignore+=*.png,*.jpg,*.gif,*.bpm,*.ico                     " images
set wildignore+=log/**,*.log                                      " logs
set wildignore+=.env,.env[0-9]+                                   " local environment files
set wildignore+=bower_modules/,node_modules/,*.min.js             " js specific
set wildignore+=*/.rbenv/**,.gem,vendor/**,rdoc/**                " ruby
set wildignore+=*.class,*.jar                                     " java
set wildignore+=target/**                                         " maven
set wildignore+=_site/**                                          " jekyll
set wildignore+=.idea/**                                          " intellij idea