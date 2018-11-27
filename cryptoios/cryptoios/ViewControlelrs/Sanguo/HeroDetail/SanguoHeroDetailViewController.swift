
import UIKit
import Charts

class SanguoHeroDetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, ChartViewDelegate {
    let activities = ["统御", "武力", "智力", "政治", "魅力",]

    var hero : [String:Any]?
    let AttKeys = [
        "特技",
        "势力",
        "统御",
        "武力",
        "智力",
        "政治",
        "魅力",
        "统武和",
        "统武智和",
        "综合",
        "性别",
        "性格",
        "出生",
        "死亡",
        "枪兵",
        "戬兵",
        "弩兵",
        "骑兵",
        "武器",
        "水军",
        "出身",
    ]
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var heroImage: UIImageView!
  
    @IBOutlet var radarChartView: RadarChartView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var AttCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "武将详情"
        
        AttCollectionView.register(UINib(nibName: "HeroAttCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        AttCollectionView.isHidden = true
        descLabel.isHidden = false
        
        descLabel.layer.borderWidth = 1
        descLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        heroImage.layer.cornerRadius = 5;
        heroImage.layer.masksToBounds = true
        
        setupHero()
        
        radarChartView.delegate = self
        radarChartView.chartDescription?.enabled = false
        radarChartView.webLineWidth = 1
        radarChartView.innerWebLineWidth = 1
        radarChartView.webColor = .lightGray
        radarChartView.innerWebColor = .lightGray
        radarChartView.webAlpha = 1
        
        let xAxis = radarChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .black
        
        let yAxis = radarChartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false

        radarChartView.legend.enabled = false
        radarChartView.isUserInteractionEnabled = false
        
        self.updateChartData()
    }
    
    func updateChartData(){
        
        var entries:[RadarChartDataEntry] = []
        for key in activities {
            let v = hero?[key] as! Int
            entries.append(RadarChartDataEntry(value: Double(v)))
        }
        
        let set1 = RadarChartDataSet(values: entries, label: nil)
        set1.setColor(UIColor.red)
        set1.drawFilledEnabled = false
        set1.drawHighlightCircleEnabled = true

        let data = RadarChartData(dataSets: [set1])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        
        data.setValueTextColor(.white)
        
        radarChartView.data = data
    }
    
    func setupHero()
    {
        nameLabel.text = hero?["姓名"] as? String
        let image_name = hero?["image_name"] as! String
        heroImage.image = UIImage(named: "sanguo/heroes/\(image_name)")
        descLabel.text = hero?["生平"] as? String   
    }

    @IBAction func segmentChanged(_ sender: Any)
    {
        let idx = (sender as! UISegmentedControl).selectedSegmentIndex
        
        AttCollectionView.isHidden = idx != 1
        descLabel.isHidden = idx != 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AttKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeroAttCollectionViewCell;
        let key = AttKeys[indexPath.item]
        cell.nameLabel.text = key
        if let v = hero?[key] as? String{
            cell.valueLabel.text = v

        } else if let v = hero?[key] as? Int {
            cell.valueLabel.text = String(v)
        }
        
        return cell
    }
}

extension SanguoHeroDetailViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}
