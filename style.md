Style Guide
=====
[CSS](#css-)   |  [Git](#git-)  |  [Javascript](#javascript-)  |  [Ruby](#ruby-)  |  [Review](#review-)



## CSS <a id="css"></a> 

Follow [Github's guide](https://github.com/styleguide/css) for all cases. Key points shown below.

#### Key Points 

* Use soft-tabs with a two space indent.
* Put spaces after : in property declarations.
* Put spaces before { in rule declarations.
* Use hex color codes #000 unless using rgba.
* Use // for comment blocks (instead of /* */).
* Document styles with [KSS](https://github.com/kneath/kss).


* Here is good example syntax:

  ```CSS
    // This is a good example!
    .styleguide-format {
      border: 1px solid #0f0;
      color: #000;
      background: rgba(0,0,0,0.5);
    }
  ```

## Git <a id="git"></a> 

Commit messages uppercase, present tense.

    # bad - not capital
    added README.md
    add README.md

    # bad - not present tense
    Added README.md

    # good
    Add README.md


## Javascript <a id="javascript"></a> 

Follow Crockford's [JS guide](http://javascript.crockford.com/code.html).

#### Key Points

* Use ```===``` not ```==```
* Blank spaces should be used in the following circumstances:
      * A keyword followed by ```(``` (left parenthesis) should be separated by a space.
      
        ```while (true) {```

      * A blank space should not be used between a function value and its ( (left parenthesis). This helps to distinguish between keywords and function invocations.

      * All binary operators except ```.``` (period) and ```(``` (left parenthesis) and ```[``` (left bracket) should be separated from their operands by a space.

      * No space should separate a unary operator and its operand except when the operator is a word such as typeof.

      * Each ```;``` (semicolon) in the control part of a for statement should be followed with a space.

      * Whitespace should follow every ```,``` (comma).

## Ruby <a id="ruby"></a> 

Follow complete Ruby [Style Guide](https://github.com/bbatsov/ruby-style-guide) for all cases.

#### Key Points

* Use two **spaces** per indentation level. No hard tabs.

    ```Ruby
    # bad - four spaces
    def some_method
        do_something
    end

    # good
    def some_method
      do_something
    end
    ```

* Use spaces around operators, after commas, colons and semicolons, around `{`
  and before `}`. Whitespace might be (mostly) irrelevant to the Ruby
  interpreter, but its proper use is the key to writing easily
  readable code.

    ```Ruby
    sum = 1 + 2
    a, b = 1, 2
    1 > 2 ? true : false; puts 'Hi'
    [1, 2, 3].each { |e| puts e }
    ```

    The only exception, regarding operators, is the exponent operator:

    ```Ruby
    # bad
    e = M * c ** 2

    # good
    e = M * c**2
    ```

    `{` and `}` deserve a bit of clarification, since they are used
    for block and hash literals, as well as embedded expressions in
    strings. For hash literals two styles are considered acceptable.

    ```Ruby
    # good - space after { and before }
    { one: 1, two: 2 }

    # good - no space after { and before }
    {one: 1, two: 2}
    ```

    The first variant is slightly more readable (and arguably more
    popular in the Ruby community in general). The second variant has
    the advantage of adding visual difference between block and hash
    literals. Whichever one you pick - apply it consistently.

    As far as embedded expressions go, there are also two acceptable
    options:

    ```Ruby
    # good - no spaces
    "string#{expr}"

    # ok - arguably more readable
    "string#{ expr }"
    ```

    The first style is extremely more popular and you're generally
    advised to stick with it. The second, on the other hand, is
    (arguably) a bit more readable. As with hashes - pick one style
    and apply it consistently.

* No spaces after `(`, `[` or before `]`, `)`.

    ```Ruby
    some(arg).other
    [1, 2, 3].length
    ```

## Review <a id="review"></a> 

Single-peer review for all pull requests. Third members makes call on split decisions.

- [ ] Code has comprehensive test suite and passes all tests
- [ ] Code follows defined style guides for Ruby, JS, and CSS
- [ ] Commit message follows commit guidelines
- [ ] Commit message is descriptive and robust
- [ ] Branch naming convention accurately conveys work done

