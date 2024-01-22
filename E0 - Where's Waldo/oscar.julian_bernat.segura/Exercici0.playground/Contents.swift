var i: Int, j:Int
var array = ["Wenda", "Odlaw", "Odlaw", "Wilma", "Whitebeard", "Wenda", "Wilma", "Woof", "Wilma", "Whitebeard", "Waldo", "Wenda", "Odlaw", "Odlaw", "Wenda", "Wilma", "Wenda", "Woof", "Wenda", "Wenda", "Woof", "Odlaw", "Wenda", "Odlaw", "Odlaw", "Wilma", "Woof", "Odlaw", "Odlaw"]
var dicRepes = [String : Int]()
for i in 0..<array.count {
    if array[i] == "Waldo" {
        print(i)
    }
    dicRepes[array[i], default: 0] += 1
}
var uniqueArray = Set(array)
print(uniqueArray.count)

print(dicRepes.sorted(by: {$0.value > $1.value}))
