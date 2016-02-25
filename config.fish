if status --is-login
        set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0.jdk
        set -gx MAVEN_HOME /Developer/Applications/maven
        set -gx ANT_HOME /Developer/Applications/ant
        set -gx ADT_HOME /Developer/Applications/adt
	set -gx PATH $PATH ~/bin $JAVA_HOME $MAVEN_HOME $ANT_HOME/bin $ADT_HOME/sdk/tools /usr/local/git/bin
        set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
end

function fish_greeting
fortune -a | cowsay
end
funcsave fish_greeting
