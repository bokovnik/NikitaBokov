//
//  NewsFeedTableViewCell.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 21.11.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//
import Foundation
import UIKit

class NewCell: UITableViewCell {
    
    @IBOutlet weak var authorPhoto: UIImageView! {
        didSet {
        authorPhoto.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var author: UILabel! {
        didSet {
            author.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var textOf: UILabel! {
        didSet {
            textOf.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var likeCount: UILabel! {
        didSet {
            likeCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var commentCount: UILabel! {
        didSet {
            commentCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var repostCount: UILabel! {
        didSet {
            repostCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var viewCount: UILabel! {
        didSet {
            viewCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    //задаем отступы по 10 точек с каждой стороны
    let instets: CGFloat = 10.0
    
    func setAuthorPhoto() {
        //authorPhoto.image = UIImage(named: "")
        authorPhotoFrame()
    }
    
    func setAuthor(text: String) {
        author.text = text
        authorLabelFrame()
    }
    
    func setTextOf(text: String) {
        textOf.text = text
        textOfLabelFrame()
    }
    //переопределение метода расчета позиции элементов
    override func layoutSubviews() {
        super.layoutSubviews()
        
        authorPhotoFrame()
        authorLabelFrame()
        textOfLabelFrame()
    }
    //вестка иконки автора
    func authorPhotoFrame() {
        let authorPhotoSideLenght: CGFloat = 50
        let authorPhotoSize = CGSize(width: authorPhotoSideLenght, height: authorPhotoSideLenght)
        let authorPhotoOrigin = CGPoint(x: 10/*bounds.midX - authorPhotoSideLinght / 2*/, y: 10/*bounds.midY - authorPhotoSideLinght / 2*/)
        authorPhoto.frame = CGRect(origin: authorPhotoOrigin, size: authorPhotoSize)
    }
    //верстка наименования автора сообщения
    func authorLabelFrame() {
        //получаем размер текста передавая сам текст и шрифт.
        let authorLabelSize = getLabelSize(text: author.text!, font: author.font)
        //рассчитывает координату по оси Х
        let authorLabelX:CGFloat = 70//(bounds.width - authorLabelSize.width) / 2 + instets + authorPhoto.frame.width
        //получим точку верхнего левого угла надписи
        let authorLabelOrigin =  CGPoint(x: authorLabelX, y: instets)
        //получаем фрейм и устанавливаем нашей UILabel
        author.frame = CGRect(origin: authorLabelOrigin, size: authorLabelSize)
    }
    //верстка текста новости
    func textOfLabelFrame() {
        //получаем размер текста передавая сам текст и шрифт.
        let textOfLabelSize = getLabelSize(text: textOf.text!, font: textOf.font)
        //рассчитывает координату по оси Х
        let textOfLabelX = (bounds.width - textOfLabelSize.width) / 2
        //рассчитывает координату по оси Y
        let textOfLabelY: CGFloat = 70 //(bounds.height - textOfLabelSize.height) / 2
        //получим точку верхнего левого угла надписи
        let textOfLabelOrigin =  CGPoint(x: textOfLabelX, y: textOfLabelY)
        //получаем фрейм и устанавливаем нашей UILabel
        textOf.frame = CGRect(origin: textOfLabelOrigin, size: textOfLabelSize)
    }
    //функция для расчета размера текста, находящегося в UILabel
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        //определяем максимальную ширину, которую может занимать наш текст
        //это ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - instets * 2
        //получаем размеры блока в которого надо вписать надпись
        //используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        //получим прямоугольник который займет наш текст в этом блоке, уточняем каким шрифтом он будет написан
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        //получаем ширину блока, переводим ее в Double
        let width = Double(rect.size.width)
        //получаем высоту блока, переводим ее в Double
        let height = Double(rect.size.height)
        //получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    //}

}
