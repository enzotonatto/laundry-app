// CollectionSchedullingViewController.swift
// laundry-app
// Created by Antonio Costa on 20/06/25.

import UIKit

class CollectionSchedullingViewController: UIViewController {
    private let laundry = OrderFlowViewModel.shared.selectedLaundry
    
    private let currentLaundry: Laundry! = {
        let laundries = LaundryPersistence.shared.getAllLaundries()
        guard let laundry = laundries.first(where: { $0.name == "Gumgum Lavanderias" }) else {
            fatalError("❌ Lavanderia iWash não encontrada no banco!")
        }
        return laundry
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escolha o dia e horário da sua coleta"
        label.font = Fonts.title3
        return label
    }()
    
    private let daysStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    private let timeChunksScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let timeChunksStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
//        sv.distribution = .fill
        sv.spacing = 12
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()



    private var dayButtons: [SchedulingDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Agendamento da Coleta"
        setup()
        generateDayButtons()
        if let date = selectedDate {
            displayChunks(for: date)
        }
    }
    private var selectedDate: Date?
    
    private func displayChunks(for date: Date) {
        // limpa o stack
        timeChunksStackView.arrangedSubviews.forEach {
            timeChunksStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard let open = currentLaundry.openHour,
              let close = currentLaundry.closeHour else { return }

        let calendar = Calendar.current
        let targetDay = calendar.startOfDay(for: date)

        // 1) Extrai só a hora e descarta minutos
        let openHour  = calendar.component(.hour, from: open)
        let closeHour = calendar.component(.hour, from: close)

        // 2) Cria openDate em HH:00, mas se o open original tiver minutos > 0, pula pra próxima hora
        var openDate = calendar.date(bySettingHour: openHour, minute: 0, second: 0, of: targetDay)!
        if calendar.component(.minute, from: open) > 0 {
            openDate = calendar.date(byAdding: .hour, value: 1, to: openDate)!
        }

        // 3) Cria closeDate em HH:00 (arredonda para baixo sempre)
        let closeDate = calendar.date(bySettingHour: closeHour, minute: 0, second: 0, of: targetDay)!

        // 4) Se for hoje, começa na próxima hora cheia a partir de agora
        var currentStart = openDate
        if calendar.isDateInToday(targetDay) {
            let now = Date()
            let nextHour = calendar.nextDate(after: now,
                                             matching: DateComponents(minute: 0, second: 0),
                                             matchingPolicy: .nextTime)!
            currentStart = max(openDate, nextHour)
        }

        // 5) Gera blocos de 1h
        while currentStart < closeDate {
            let end = calendar.date(byAdding: .hour, value: 1, to: currentStart)!
            let chunk = TimeChunks(chunkStart: currentStart, chunkEnd: end)
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
        // normaliza hoje com hora zero
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

        // **Adicione esta linha para recarregar os horários**
        displayChunks(for: data)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
        formatter.dateFormat = "dd/MM/yyyy HH:mm"

        let texto = formatter.string(from: data)
        print("Usuário escolheu: \(texto)")
    }
    

}

extension CollectionSchedullingViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(descriptionLabel)
            view.addSubview(daysStackView)
            view.addSubview(timeChunksScrollView)
            timeChunksScrollView.addSubview(timeChunksStackView)
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
            timeChunksScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // StackView dentro do scroll
            timeChunksStackView.topAnchor.constraint(equalTo: timeChunksScrollView.topAnchor),
            timeChunksStackView.bottomAnchor.constraint(equalTo: timeChunksScrollView.bottomAnchor),
            timeChunksStackView.leadingAnchor.constraint(equalTo: timeChunksScrollView.leadingAnchor),
            timeChunksStackView.trailingAnchor.constraint(equalTo: timeChunksScrollView.trailingAnchor),
         
            timeChunksStackView.widthAnchor.constraint(equalTo: timeChunksScrollView.widthAnchor)
        ])
    }

}

