def unique_count: group_by(.) | map([. | length, .[0]]);
def base64json: @base64d | fromjson;
def jwt:
  split(".") | { header: (.[0] | base64json), payload: (.[1] | base64json), signature: .[2] };

# https://github.com/nichtich/jq-jsonpointer/blob/master/jsonpointer.jq
def pointer_tokens:
  . as $pointer |
  if $pointer == "" then
    []
  else
    $pointer | split("/") | 
    if .[0] == "" then
      .[1:] | map(gsub("~1";"/";"g")|gsub("~0";"~";"g"))
    else
      error("Invalid JSON Pointer: \($pointer)")
    end
  end
;

def pointer_get(tokens):
  reduce (tokens | .[]) as $token (
    .;
    if type == "object" then
      .[$token]
    elif type != "array" then
      empty
    elif $token|test("^0$|^[1-9][0-9]*$") then
      .[$token|tonumber]
    else
      empty
    end
  )
;

def pointer(json_pointer):
  (json_pointer | pointer_tokens) as $tokens |
  pointer_get($tokens)
;
