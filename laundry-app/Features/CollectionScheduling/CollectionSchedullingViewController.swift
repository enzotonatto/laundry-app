// CollectionSchedullingViewController.swift
// laundry-app
// Created by Antonio Costa on 20/06/25.

import UIKit

class CollectionSchedullingViewController: UIViewController {
    private var laundry = OrderFlowViewModel.shared.selectedLaundry
    private var selectedChunk: String?

    
    private lazy var currentLaundry: Laundry! = {
        let laundries = LaundryPersistence.shared.getAllLaundries()
        guard let laundry = laundries.first(where: { $0.name == "Gumgum Lavanderias" }) else {
            fatalError("❌ Lavanderia iWash não encontrada no banco!")
        }
        return laundry
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escolha o dia e horário da sua coleta"
        label.font = Fonts.title3
        return label
    }()
    
    private lazy var daysStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    private lazy var timeChunksScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var timeChunksStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
//        sv.distribution = .fill
        sv.spacing = 12
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var nextButton: GradientButton = {
        let btn = GradientButton()
        btn.title = "Próxímo"
        btn.addTarget(self, action: #selector(goToOrderSummaryVC), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()



    private var dayButtons: [SchedulingDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = "Voltar"
        title = "Agendamento da Coleta"
        setup()
        generateDayButtons()
        if let date = selectedDate {
            displayChunks(for: date)
        }
    }
    private var selectedDate: Date?
    
    private func displayChunks(for date: Date) {
        timeChunksStackView.arrangedSubviews.forEach {
            timeChunksStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard let open = currentLaundry.openHour,
              let close = currentLaundry.closeHour else { return }

        let calendar = Calendar.current
        let targetDay = calendar.startOfDay(for: date)

        let openHour  = calendar.component(.hour, from: open)
        let closeHour = calendar.component(.hour, from: close)

        var openDate = calendar.date(bySettingHour: openHour, minute: 0, second: 0, of: targetDay)!
        if calendar.component(.minute, from: open) > 0 {
            openDate = calendar.date(byAdding: .hour, value: 1, to: openDate)!
        }

        let closeDate = calendar.date(bySettingHour: closeHour, minute: 0, second: 0, of: targetDay)!

        var currentStart = openDate
        if calendar.isDateInToday(targetDay) {
            let now = Date()
            let nextHour = calendar.nextDate(after: now,
                                             matching: DateComponents(minute: 0, second: 0),
                                             matchingPolicy: .nextTime)!
            currentStart = max(openDate, nextHour)
        }

        while currentStart < closeDate {
            let end = calendar.date(byAdding: .hour, value: 1, to: currentStart)!
            let chunk = TimeChunks(chunkStart: currentStart, chunkEnd: end)
            chunk.delegate = self
            chunk.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                chunk.heightAnchor.constraint(equalToConstant: 54)
            ])
            timeChunksStackView.addArrangedSubview(chunk)
            currentStart = end
        }
    }
    
    private func generateDayButtons() {
        let calendar = Calendar.current
        let localeBR = Locale(identifier: "pt_BR")
        let today = calendar.startOfDay(for: Date())

        for offset in 0..<5 {
            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else { continue }

            let dayString = date.formatted(.dateTime.day(.defaultDigits))
            let rawWeek: String = {
                switch offset {
                case 0: return "hoje"
                case 1: return "amanhã"
                default:
                    let full = date.formatted(.dateTime.weekday(.wide).locale(localeBR))
                    return full.replacingOccurrences(of: "-feira", with: "")
                }
            }()
            let weekString = rawWeek.capitalized(with: localeBR)

            let button = SchedulingDay()
            button.configure(day: dayString, week: weekString, date: date, selected: offset == 0)
            button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 68),
                button.heightAnchor.constraint(equalToConstant: 60)
            ])

            dayButtons.append(button)
            daysStackView.addArrangedSubview(button)

            if offset == 0 {
                selectedDate = date
            }
        }
    }

    
    @objc private func dayTapped(_ sender: SchedulingDay) {
        dayButtons.forEach { $0.isSelected = false }
        sender.isSelected = true

        guard let data = sender.date else { return }
            selectedDate = data
            displayChunks(for: data)

            let dayOfMonth = Calendar.current.component(.day, from: data)
            OrderFlowViewModel.shared.selectedDayMonth = "\(dayOfMonth)"

            let weekdayFormatter = DateFormatter()
            weekdayFormatter.locale = Locale(identifier: "pt_BR")
            weekdayFormatter.dateFormat = "EEEE"
            let weekdayName = weekdayFormatter.string(from: data)
            OrderFlowViewModel.shared.selectedDayWeek = weekdayName

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
    }
    
    @objc func goToOrderSummaryVC() {
        let vc = OrderSummaryViewController()  // nota os parênteses!
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension CollectionSchedullingViewController: TimeChunksViewDelegate {
    func didSelect(option: TimeChunks) {
        timeChunksStackView.arrangedSubviews
            .compactMap { $0 as? TimeChunks }
            .forEach { $0.setSelected($0 === option) }

        let fmt = DateFormatter()
        fmt.dateFormat = "HH:mm"
        fmt.locale     = Locale(identifier: "pt_BR")
        fmt.timeZone   = TimeZone(identifier: "America/Sao_Paulo")

        let startString = fmt.string(from: option.chunkStart)
        let endString   = fmt.string(from: option.chunkEnd)

        OrderFlowViewModel.shared.selectedTimeStart = startString
        OrderFlowViewModel.shared.selectedTimeEnd   = endString

        selectedChunk = "\(startString) – \(endString)"
    }
}


extension CollectionSchedullingViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(descriptionLabel)
        view.addSubview(daysStackView)
        view.addSubview(timeChunksScrollView)
        timeChunksScrollView.addSubview(timeChunksStackView)
        view.addSubview(nextButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Descrição
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            daysStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            daysStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            daysStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            daysStackView.heightAnchor.constraint(equalToConstant: 60),
            
            // Scroll dos horários (vertical)
            timeChunksScrollView.topAnchor.constraint(equalTo: daysStackView.bottomAnchor, constant: 24),
            timeChunksScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeChunksScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            timeChunksScrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -11),

            // StackView dentro do scroll
            timeChunksStackView.topAnchor.constraint(equalTo: timeChunksScrollView.topAnchor),
            timeChunksStackView.bottomAnchor.constraint(equalTo: timeChunksScrollView.bottomAnchor),
            timeChunksStackView.leadingAnchor.constraint(equalTo: timeChunksScrollView.leadingAnchor),
            timeChunksStackView.trailingAnchor.constraint(equalTo: timeChunksScrollView.trailingAnchor),
         
            timeChunksStackView.widthAnchor.constraint(equalTo: timeChunksScrollView.widthAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

}

