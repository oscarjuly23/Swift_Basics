
//Exercici 1

let employeeCost : Float = 90000
let externalInversion : Float = 500000000

class Variant {
    var name : String
    var percent : Float
    var basePriceIncrement : Float
    var priceIncOverProd : Float
    init(name : String, percent : Float, basePriceIncrement : Float, priceIncOverProd : Float) {
        self.name = name
        self.percent = percent
        self.basePriceIncrement = basePriceIncrement
        self.priceIncOverProd = priceIncOverProd
    }
    func getTotalCost(productionCostUnit: Float, capacity: Float) -> Float {
        return ((productionCostUnit + ((priceIncOverProd / 100 ) * productionCostUnit)) * capacity)
    }
    func getBenefici(estimatedSales: Float, price: Float) -> Float {
        var priceUnit = (price + ((basePriceIncrement / 100 ) * price))
        var totalBenefici = priceUnit * ((percent / 100 ) * estimatedSales)
        return totalBenefici
    }
}

class Campaign {
    var name : String
    var numEmployees : Float
    var costs : Float
    var car : Variant
    
    init(numEmployees : Float, name : String, costs : Float, car : Variant) {
        self.numEmployees = numEmployees
        self.name = name
        self.costs = costs
        self.car = car
    }
    
    func getTotalCost () -> Float {
        return (numEmployees * employeeCost) + costs
    }
}

class Project {
    var name : String
    var numEmployees : Float
    var invest : Float
    init(numEmployees : Float, name : String, invest : Float) {
        self.numEmployees = numEmployees
        self.name = name
        self.invest = invest
    }
    
    func getTotalCost() -> Float {
        return invest
    }
}

class Car {
    var name : String
    var capacity : Float
    var estimatedSales : Float
    var numEmployees : Float
    var price : Float
    var productionCostUnit : Float
    var variants : [Variant]
    
    init(numEmployees : Float, name : String, capacity : Float, estimatedSales : Float, price : Float, productionCostUnit : Float, variants : [Variant]) {
        self.numEmployees = numEmployees
        self.name = name
        self.capacity = capacity
        self.estimatedSales = estimatedSales
        self.price = price
        self.productionCostUnit = productionCostUnit
        self.variants = variants
    }
    func getTotalCost() -> Float {
        var totalVariants : Float = 0
        for variant in variants {
            totalVariants += variant.getTotalCost(productionCostUnit: productionCostUnit, capacity: capacity)
        }
        totalVariants += (numEmployees * employeeCost)
        return totalVariants
    }
    func getBenefici() -> Float {
        var totalVariants : Float = 0
        for variant in variants {
            totalVariants += variant.getBenefici(estimatedSales: estimatedSales, price: price)
        }
        return totalVariants
    }

}

class Tesla {
    var cars : [Car] = []
    var campaigns : [Campaign] = []
    var projects : [Project] = []
    
    init() {
        cars = [model1, model2]
        campaigns = [campaign1, campaign2]
        projects = [project1, project2]
    }
    
    func generateAnualReport () {
        
        //Marketing
        var totalMarketing : Float = 0
        for campaign in campaigns {
            totalMarketing += campaign.getTotalCost()
        }
        print("El cost total del depatament de Marketing es: \(totalMarketing)")
        
        //I + D
        var totalProjects : Float = 0
        for project in projects {
            totalProjects = project.getTotalCost()
        }
        print("El cost total del depatament de I + D es: \(totalProjects)")
        
        //Cars
        var totalCar : Float = 0
        for car in cars {
            totalCar += car.getTotalCost()
        }
        
        //Resum
        print("Balanç total de Tesla:")
        
        //Costs
        var totalCost = totalCar + totalProjects + totalMarketing
        print("Costos totals: \(totalCost)")
        
        //Beneficis
        var beneficiCar : Float = 0
        for car in cars {
            beneficiCar += car.getBenefici()
        }
        print("Benefici total: \(beneficiCar)")
        
        //Balanç
        print("El balanç de tesla: \(beneficiCar - totalCost)")
    }
}

var variant1M1 = Variant(name: "Variant1", percent: 60, basePriceIncrement: 0, priceIncOverProd: 0)
var variant2M1 = Variant(name: "Variant2", percent: 30, basePriceIncrement: 25000, priceIncOverProd: 2000)
var variant3M1 = Variant(name: "Variant3", percent: 10, basePriceIncrement: 45000, priceIncOverProd: 4000)

var model1 = Car(numEmployees: 120, name: "Model1", capacity: 80000, estimatedSales: 120000, price: 100000, productionCostUnit: 18000, variants: [variant1M1, variant2M1, variant3M1])

var variant1M2 = Variant(name: "Variant1", percent: 60, basePriceIncrement: 0, priceIncOverProd: 0)
var variant2M2 = Variant(name: "Variant2", percent: 40, basePriceIncrement: 30000, priceIncOverProd: 5000)

var model2 = Car(numEmployees: 80, name: "Model2", capacity: 45000, estimatedSales: 45000, price: 120000, productionCostUnit: 30000, variants: [variant1M2, variant2M2])

var project1 = Project(numEmployees: 170, name: "Project1", invest: 50000000)
var project2 = Project(numEmployees: 230, name: "Project2", invest: 10000000)

var campaign1 = Campaign(numEmployees: 50, name: "Campaign1", costs: 4000000, car: model1.variants[0])

var campaign2 = Campaign(numEmployees: 20, name: "Campaign2", costs: 2000000, car: model2.variants[1])

let tesla = Tesla()
tesla.generateAnualReport()
