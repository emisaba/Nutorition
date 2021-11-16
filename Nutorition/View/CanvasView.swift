import UIKit

class CanvasView: UIView {
    
    // MARK: - Property
    
    private let viewFrame: CGRect
    private lazy var viewCenterPoint = CGPoint(x: viewFrame.width / 2, y: viewFrame.height / 2 - 120)
    private lazy var radiusLength = (viewFrame.width - 100) / 2
    private let diagonalRadiusLength: CGFloat = 102.5
    
    private let idealProteinAmount: CGFloat = 50
    private let idealCalciumAmount: CGFloat = 650
    private let idealIronAmount: CGFloat = 6.5
    private let idealVitaminaAmount: CGFloat = 650
    private let idealVitamindAmount: CGFloat = 8.5
    private let idealVitamineAmount: CGFloat = 5
    private let idealVitaminbAmount: CGFloat = 20
    private let idealVitamincAmount: CGFloat = 100
    
    var amountData: [String: Double] = [:] {
        didSet {
            drawGraphByUsingFoodData()
            setNeedsDisplay()
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        self.viewFrame = frame
        
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setBaseBorder()
        drawGraphByUsingFoodData()
    }
    
    // MARK: - Helpers
    
    func setBaseBorder() {
        let line1endPoint = CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y - radiusLength)
        createBorder(startPoint: nil, endPoint: line1endPoint, base: true)
        
        let line2endPoint = CGPoint(x: viewCenterPoint.x + diagonalRadiusLength, y: viewCenterPoint.y - diagonalRadiusLength)
        createBorder(startPoint: nil, endPoint: line2endPoint, base: true)
        
        let line3endPoint = CGPoint(x: viewCenterPoint.x + radiusLength, y: viewCenterPoint.y)
        createBorder(startPoint: nil, endPoint: line3endPoint, base: true)
        
        let line4endPoint = CGPoint(x: viewCenterPoint.x + diagonalRadiusLength, y: viewCenterPoint.y + diagonalRadiusLength)
        createBorder(startPoint: nil, endPoint: line4endPoint, base: true)
        
        let line5endPoint = CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y + radiusLength)
        createBorder(startPoint: nil, endPoint: line5endPoint, base: true)
        
        let line6endPoint = CGPoint(x: viewCenterPoint.x - diagonalRadiusLength, y: viewCenterPoint.y + diagonalRadiusLength)
        createBorder(startPoint: nil, endPoint: line6endPoint, base: true)
        
        let line7endPoint = CGPoint(x: viewCenterPoint.x - radiusLength, y: viewCenterPoint.y)
        createBorder(startPoint: nil, endPoint: line7endPoint, base: true)
        
        let line8endPoint = CGPoint(x: viewCenterPoint.x - diagonalRadiusLength, y: viewCenterPoint.y - diagonalRadiusLength)
        createBorder(startPoint: nil, endPoint: line8endPoint, base: true)
        
        createBorder(startPoint: line1endPoint, endPoint: line2endPoint, base: true)
        createBorder(startPoint: line2endPoint, endPoint: line3endPoint, base: true)
        createBorder(startPoint: line3endPoint, endPoint: line4endPoint, base: true)
        createBorder(startPoint: line4endPoint, endPoint: line5endPoint, base: true)
        createBorder(startPoint: line5endPoint, endPoint: line6endPoint, base: true)
        createBorder(startPoint: line6endPoint, endPoint: line7endPoint, base: true)
        createBorder(startPoint: line7endPoint, endPoint: line8endPoint, base: true)
        createBorder(startPoint: line8endPoint, endPoint: line1endPoint, base: true)
        
        for i in stride(from: CGFloat(0), to: CGFloat(1), by: CGFloat(0.2)) {
            
            let line1scale = CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y - (radiusLength * i))
            let line2scale = CGPoint(x: viewCenterPoint.x + (diagonalRadiusLength * i), y: viewCenterPoint.y - (diagonalRadiusLength * i))
            createBorder(startPoint: line1scale, endPoint: line2scale, base: true)
            
            let line3scale = CGPoint(x: viewCenterPoint.x + (radiusLength * i), y: viewCenterPoint.y)
            createBorder(startPoint: line2scale, endPoint: line3scale, base: true)
            
            let line4scale = CGPoint(x: viewCenterPoint.x + (diagonalRadiusLength * i), y: viewCenterPoint.y + (diagonalRadiusLength * i))
            createBorder(startPoint: line3scale, endPoint: line4scale, base: true)
            
            let line5scale = CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y + (radiusLength * i))
            createBorder(startPoint: line4scale, endPoint: line5scale, base: true)
            
            let line6scale = CGPoint(x: viewCenterPoint.x - (diagonalRadiusLength * i), y: viewCenterPoint.y + (diagonalRadiusLength * i))
            createBorder(startPoint: line5scale, endPoint: line6scale, base: true)
            
            let line7scale = CGPoint(x: viewCenterPoint.x - (radiusLength * i), y: viewCenterPoint.y)
            createBorder(startPoint: line6scale, endPoint: line7scale, base: true)
            
            let line8scale = CGPoint(x: viewCenterPoint.x - (diagonalRadiusLength * i), y: viewCenterPoint.y - (diagonalRadiusLength * i))
            createBorder(startPoint: line7scale, endPoint: line8scale, base: true)
            createBorder(startPoint: line8scale, endPoint: line1scale, base: true)
        }
    }
    
    func             drawGraphByUsingFoodData() {
        
        let protain = CGFloat(amountData["protain"] ?? 0)
        let calcium = CGFloat(amountData["calcium"] ?? 0)
        let iron = CGFloat(amountData["iron"] ?? 0)
        let vitamina = CGFloat(amountData["vitamina"] ?? 0)
        let vitamind = CGFloat(amountData["vitamind"] ?? 0)
        let vitamine = CGFloat(amountData["vitamine"] ?? 0)
        let vitaminb = CGFloat(amountData["vitaminb"] ?? 0)
        let vitaminc = CGFloat(amountData["vitaminc"] ?? 0)
        
        let proteineBorderLength = radiusLength * (protain / idealProteinAmount)
        let proteinY = viewCenterPoint.y - proteineBorderLength
        let proteinPoint = CGPoint(x: viewCenterPoint.x, y: proteinY)

        let calciumBorderLength = diagonalRadiusLength * (calcium / idealCalciumAmount)
        let calciumX = viewCenterPoint.x + calciumBorderLength
        let calciumY = viewCenterPoint.y - calciumBorderLength
        let calciumPoint = CGPoint(x: calciumX, y: calciumY)
        
        createTriangle(point1: proteinPoint, point2: calciumPoint)
        createCircle(point: proteinPoint)
        createCircle(point: calciumPoint)
        createBorder(startPoint: proteinPoint, endPoint: calciumPoint, base: false)
        
        let ironBorderLength = radiusLength * (iron / idealIronAmount)
        let ironX = viewCenterPoint.x + ironBorderLength
        let ironPoint = CGPoint(x: ironX, y: viewCenterPoint.y)
        
        createTriangle(point1: calciumPoint, point2: ironPoint)
        createCircle(point: ironPoint)
        createBorder(startPoint: calciumPoint, endPoint: ironPoint, base: false)
        
        let vitaminaBorderLength = diagonalRadiusLength * (vitamina / idealVitaminaAmount)
        let vitaminaX = viewCenterPoint.x + vitaminaBorderLength
        let vitaminaY = viewCenterPoint.y + vitaminaBorderLength
        let vitaminaPoint = CGPoint(x: vitaminaX, y: vitaminaY)
        
        createTriangle(point1: ironPoint, point2: vitaminaPoint)
        createCircle(point: vitaminaPoint)
        createBorder(startPoint: ironPoint, endPoint: vitaminaPoint, base: false)
        
        let vitamindBorderLength = radiusLength * (vitamind / idealVitamindAmount)
        let vitamindY = viewCenterPoint.y + vitamindBorderLength
        let vitamindPoint = CGPoint(x: viewCenterPoint.x, y: vitamindY)
        
        createTriangle(point1: vitaminaPoint, point2: vitamindPoint)
        createCircle(point: vitamindPoint)
        createBorder(startPoint: vitaminaPoint, endPoint: vitamindPoint, base: false)
        
        let vitamineBorderLength = diagonalRadiusLength * (vitamine / idealVitamineAmount)
        let vitamineX = viewCenterPoint.x - vitamineBorderLength
        let vitamineY = viewCenterPoint.y + vitamineBorderLength
        let vitaminePoint = CGPoint(x: vitamineX, y: vitamineY)
        
        createTriangle(point1: vitamindPoint, point2: vitaminePoint)
        createCircle(point: vitaminePoint)
        createBorder(startPoint: vitamindPoint, endPoint: vitaminePoint, base: false)
        
        let vitaminbBorderLength = radiusLength * (vitaminb / idealVitaminbAmount)
        let vitaminbX = viewCenterPoint.x - vitaminbBorderLength
        let vitaminbPoint = CGPoint(x: vitaminbX, y: viewCenterPoint.y)
        
        createTriangle(point1: vitaminePoint, point2: vitaminbPoint)
        createCircle(point: vitaminbPoint)
        createBorder(startPoint: vitaminePoint, endPoint: vitaminbPoint, base: false)
        
        let vitamincBorderLength = diagonalRadiusLength * (vitaminc / idealVitamincAmount)
        let vitamincX = viewCenterPoint.x - vitamincBorderLength
        let vitamincY = viewCenterPoint.y - vitamincBorderLength
        let vitamincPoint = CGPoint(x: vitamincX, y: vitamincY)
        
        createTriangle(point1: vitaminbPoint, point2: vitamincPoint)
        createCircle(point: vitamincPoint)
        createBorder(startPoint: vitaminbPoint, endPoint: vitamincPoint, base: false)
        
        createTriangle(point1: vitamincPoint, point2: proteinPoint)
        createBorder(startPoint: vitamincPoint, endPoint: proteinPoint, base: false)
    }
    
    func createBorder(startPoint: CGPoint?, endPoint: CGPoint, base: Bool) {
        let line = UIBezierPath()
        let borderColor = base ? UIColor.systemGray.withAlphaComponent(0.1) : UIColor.systemPink
        
        line.move(to: startPoint == nil ? viewCenterPoint : startPoint ?? viewCenterPoint)
        line.addLine(to: endPoint)
        line.lineWidth = 2
        borderColor.setStroke()
        line.stroke()
    }
    
    func createCircle(point: CGPoint) {
        if point == viewCenterPoint { return }
        
        let circle = UIBezierPath(arcCenter: point,
                                  radius: 3,
                                  startAngle: 0,
                                  endAngle: .pi * 2,
                                  clockwise: true)
        UIColor.systemPink.setFill()
        circle.fill()
    }
    
    func createTriangle(point1: CGPoint, point2: CGPoint) {
        
        let triangle = UIBezierPath()
        triangle.move(to: CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y))
        triangle.addLine(to: point1)
        
        triangle.addLine(to: point2)
        triangle.addLine(to: CGPoint(x: viewCenterPoint.x, y: viewCenterPoint.y))
        triangle.close()
        
        UIColor.systemPink.withAlphaComponent(0.2).setFill()
        
        triangle.fill()
    }
}
