if status --is-login
        set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home
        set -gx PATH $PATH ~/bin $JAVA_HOME ~/bin /usr/local/git/bin
end

function fish_greeting
fortune -a | cowsay
end
funcsave fish_greeting
