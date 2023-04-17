

import UIKit
// Описание класса ViewController
class ViewController: UIViewController {
    // Вычисляемое свойство для кнопки "Открыть autolayout макет"
    
    
    private lazy var autoLayoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть autolayout макет", for: .normal)
        button.addTarget(self, action: #selector(openAutoLayoutVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Вычисляемое свойство для кнопки "Открыть таблицу"
    private lazy var tableViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть таблицу", for: .normal)
        button.addTarget(self, action: #selector(openTableView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Функция, вызываемая при загрузке view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Добавляем кнопку "Открыть autolayout макет" на view и активируем ограничения
        view.addSubview(autoLayoutButton)
        view.addSubview(tableViewButton)
        
        NSLayoutConstraint.activate([
            tableViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewButton.topAnchor.constraint(equalTo: autoLayoutButton.bottomAnchor, constant: 16),
            autoLayoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            autoLayoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    

    
    // Функция, вызываемая при нажатии кнопки "Открыть autolayout макет"
    @objc private func openAutoLayoutVC() {
        let autoLayoutVC = AutoLayoutViewController(data: "Data")
        navigationController?.pushViewController(autoLayoutVC, animated: true)
    }
    
    // Функция, вызываемая при нажатии кнопки "Открыть таблицу"
    @objc private func openTableView() {
        let tableVC = MyTableViewController()
        navigationController?.pushViewController(tableVC, animated: true)
    }
    
}

//MARK:
// Класс AutolLayoutViewController отвечает за отображение экрана с примером autolayout расстановки элементов интерфейса
class AutoLayoutViewController: UIViewController {
    // Определяем элементы интерфейса
    
    var data: String?
    
    init(data: String) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:" // текст метки "Имя"
        label.font = UIFont.systemFont(ofSize: 18) // шрифт метки
        label.textColor = .black // цвет текста метки
        label.textAlignment = .left // выравнивание текста по левому краю
        label.translatesAutoresizingMaskIntoConstraints = false // выключаем автолейаут для возможности задавать констрейнты вручную
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age:" // текст метки "Возраст"
        label.font = UIFont.systemFont(ofSize: 18) // шрифт метки
        label.textColor = .black // цвет текста метки
        label.textAlignment = .left // выравнивание текста по левому краю
        label.translatesAutoresizingMaskIntoConstraints = false // выключаем автолейаут для возможности задавать констрейнты вручную
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // устанавливаем белый фон для экрана
        
        view.addSubview(nameLabel) // добавляем метку "Имя" на экран
        view.addSubview(ageLabel) // добавляем метку "Возраст" на экран
        
        // Устанавливаем констрейнты для меток
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            ageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            ageLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true // устанавливаем большие заголовки в навигационной панели
        navigationItem.title = "Auto Layout Example" // устанавливаем заголовок для экрана
    }
}


import UIKit

// Определение класса MyTableViewController, который наследует от UITableViewController
class MyTableViewController: UITableViewController {
    // Метод жизненного цикла, который вызывается при загрузке view controller'a
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Регистрация класса UITableViewCell для повторного использования
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.title = "TableVC"
    }
    
    // Метод делегата, который возвращает количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Метод делегата, который возвращает количество строк в секции таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Метод делегата, который создает и возвращает ячейку для соответствующего indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем повторно используемую ячейку с помощью идентификатора "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Устанавливаем текст ячейки в зависимости от indexPath
        if indexPath.row == 0 {
            cell.textLabel?.text = "Row 1"
        } else {
            cell.textLabel?.text = "Row 2"
        }
        
        // Возвращаем ячейку
        return cell
    }
}
