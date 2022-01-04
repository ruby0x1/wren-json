

//Handles actual stringification,
//it calls out to the provided callback to handle "writing"
//which means you can e.g write to a file directly, or into a buffer, 
//which is often significantly faster than concatenating strings
class JsonStringify {

  static stringify(value, whitespace, out) {

    if(!(value is Map || value is List)) {
      Fiber.abort("Json stringify requires a Map or a List as input")
    }

    if(value is Map) {
      stringify_map(value, whitespace, 0, out)
    } else {
      stringify_value(value, whitespace, 0, out)
    }

  } //stringify

  static stringify_map(map, whitespace, depth, out) {

    if(!(map is Map)) Fiber.abort("Expected a Map, received %(map.type) as %(map)")
    if(map.count == 0) return out.call("{}")

    out.call("{\n")

      var index = 0
      var count = map.count
      for(key in map.keys) {

        out.call(whitespace * (depth + 1))
        out.call("\"%(key)\" : ")

        var value = map[key]
        stringify_value(value, whitespace, depth + 1, out)

        var last = index == count-1
        out.call(last ? "\n" : ",\n")

        index = index + 1

      } //each key

    out.call(whitespace * depth)
    out.call("}")

} //stringify_map

  static stringify_primitive(value, out) {

    if(value is String) {
      var string = "%(value)"
        //basic json escaping. todo: this isn't extensive
        string = string.replace("\\", "\\\\") // double backslash must be first
        string = string.replace("\"", "\\\"") // then replace single 
        string = string.replace("\n", "\\n")  
      out.call("\"%(string)\"")
    } else if(value is Num || value is Null || value is Bool) {
      out.call("%(value)")
    } else {
      Fiber.abort("Can't stringify type %(value.type)!")
    }

  } //stringify_primitive

  static stringify_list(list, whitespace, depth, out) {

    if(!(list is List)) Fiber.abort("Expected a List, received %(list.type) as %(list)")

      //clearer output if empty, simpler code
    if(list.count == 0) return out.call("[]")

    out.call("[\n")

      var index = 0
      var count = list.count
      for(item in list) {
        out.call(whitespace * (depth + 1))
        stringify_value(item, whitespace, depth + 1, out)
        var last = index == count - 1
        out.call(last ? "\n" : ",\n")
        index = index + 1
      } //each item

    out.call(whitespace * depth)
    out.call("]")

  } //stringify_list

  static stringify_value(value, whitespace, depth, out) {
    if(value is Map) {
      stringify_map(value, whitespace, depth, out)
    } else if(value is List) {
      stringify_list(value, whitespace, depth, out)
    } else {
      stringify_primitive(value, out)
    }
  } //stringify_value

} //JsonStringify