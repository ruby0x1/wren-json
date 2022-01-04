# wren-json
Simple JSON parse/stringify for the Wren programming language.

- Parses strict json and relaxed json
  - Comments
  - Unquoted keys
  - Trailing commas
- Stringify emits strict json
- Not 100% complete or to spec as a json parser or stringifier, nor meant to be

## API
The API is all static. See test.wren for some basic examples.

  ### Json.parse(string)
  > Parses a string and returns a Wren Map or List dependening on the contents.
  > It's an error if the string is null. Parsing errors call Fiber.abort (use fiber try).

  ### Json.parse(source_id, source_string)
  > Parse like above, but with a source identifier for error messages. For example the json file name.

  ### Json.stringify(value)
  > Returns a string representation of the wren Map or List handed to it.
  > Only handles Wren primitives (Bool, Num, Null, String) and List and Map, no custom types.
  > Uses two space for indentation.

  ### Json.stringify(value, whitespace)
  > Returns a string representation of the wren Map or List handed to it but with a custom whitespace.
  > e.g if whitespace was "    " it would be 4 spaces for indentation,
  > or for example "\t" for a single tab.

  ### Json.stringify(value, whitespace, callback)
  > Similar to stringify, but does NOT return a value. 
  > Instead a callback is called which is handed iterative string results.
  > When writing json to a file or buffer, it can be a LOT more efficient to write directly,
  > rather than allocate a huge amount of strings first and then write that instead.
  > The callback is `{|data| write(data) }` (see the stringify implementation).

## Extra

### Running the test file

Grab [wren-cli](https://github.com/wren-lang/wren-cli/releases) and run it:

  `wren-cli test.wren`

### notes

- Several todos, PRs welcome
- There may be bugs, issues etc.
- `test.1.json` is made up, generated from https://www.mockaroo.com/

This code was written long ago, and was used extensively in [luxe](https://luxeengine.com) for a long while, now ported to this repo as a standalone copy.
