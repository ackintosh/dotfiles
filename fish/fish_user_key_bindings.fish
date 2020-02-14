# キーバインドの設定については下記を参照
# http://fish.rubikitch.com/bind/

function fish_user_key_bindings
    # Ctrl + ] : ghq
    bind \c] __ghq_crtl_g
    # Ctrl + f : カーソルを前にすすめる (デフォルトはファイル検索)
    bind \cf forward-char 
    # Ctrl + t : ファイル検索
    bind \ct __fzf_find_file
end
