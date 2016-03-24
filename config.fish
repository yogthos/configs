if status --is-login
        set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0.jdk
        set -gx PATH $PATH ~/bin $JAVA_HOME ~/bin /usr/local/git/bin
        set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
end

function fish_greeting
fortune -a | cowsay
end
funcsave fish_greeting
