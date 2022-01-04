
import "io" for File
import "./json" for Json

System.print("\n")
System.print("relaxed json")
var relaxed_json = File.read("test.2.json")
var relaxed_result = Json.parse(relaxed_json)
System.print("  - %(relaxed_result)")

System.print("\n")
System.print("strict json")
var strict_json = File.read("test.1.json")
var strict_result = Json.parse(strict_json)
System.print("  - %(strict_result)")

var relaxed_string = Json.stringify(relaxed_result)
System.print("\n")
System.print("stringify relaxed json")
System.print(relaxed_string)

//pretty noisy, so uncomment to test
var strict_string = Json.stringify(strict_result)
System.print("\n")
System.print("stringify strict json")
// System.print(strict_string)
