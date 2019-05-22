{:user {:plugins [[lein-ancient "0.6.15"]
                  [walmartlabs/vizdeps "0.1.6"]
                  [venantius/ultra "0.5.4"]
                  [lein-count "1.0.9"]]
        
        :ultra {:repl         false
                :stacktraces  true
                :tests        true
                :java         true
                :quiet-lint   false}

        :injections [(require 'clojure.pprint)
                     (defn tee
                       ([thing]
                        (print (with-out-str (clojure.pprint/pprint thing)))
                        thing)
                       ([prefix thing]
                        (println prefix)
                        (print (with-out-str (clojure.pprint/pprint thing)))
                        thing))
                     (intern 'clojure.core 'tee tee)]}}
