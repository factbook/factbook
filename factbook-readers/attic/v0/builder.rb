

## old section regex (before cleanup)

title_regex= /<h2
               (?:\s[^>]+)?  ## allow optional attributes in h2
               >
               \s*
                 ([^<>]+?)  ## note: use non-greedy; do NOT allow tags inside for now
               \s*
               (?:\s::\s
                 .+?       ## note: use non-greedy; allows tags inside
               )?          ## strip optional name (e.g.  :: AUSTRIA)
              <\/h2>
            /xim

## old subsection regex (before cleanup)

title_regex= /<div \s id='field'
                               \s class='category'>
                             \s*
                             (.+?)                ## note: use non-greedy; allows tags inside - why? why not
                             \s*
                           <\/div>
                         /xim
