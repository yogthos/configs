if status --is-login
        set -gx JAVA_HOME (/usr/libexec/java_home -v 1.8)
        set -gx PATH $PATH $JAVA_HOME ~/bin /usr/local/git/bin
        set -gx NODE_PATH "/usr/local/lib/node_modules"
end

function fish_greeting
fortune -a | cowsay
end
funcsave fish_greeting
