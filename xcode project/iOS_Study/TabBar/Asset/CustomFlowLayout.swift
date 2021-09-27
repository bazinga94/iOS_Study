//
//  CustomFlowLayout.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/28.
//

import UIKit

protocol FlowLayoutDelegate: class {
}

class CenterHorizontalLayout: UICollectionViewFlowLayout {

	private var cellSpacing: CGFloat		// cell간 간격
	private var horizontalInset: CGFloat	// 컬렉션뷰 좌우 inset
	private var isOneStepPaging: Bool		// 한번에 한 페이지 이동 여부
	private var currentIndex: CGFloat = 0

	weak var delegate: FlowLayoutDelegate?

	init(cellSpacing: CGFloat, horizontalInset: CGFloat, isOneStepPaging: Bool) {
		self.cellSpacing = cellSpacing
		self.horizontalInset = horizontalInset
		self.isOneStepPaging = isOneStepPaging
		super.init()
		self.scrollDirection = .horizontal
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CenterHorizontalLayout: UICollectionViewDelegate {
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{

		// item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
		guard let collectionView = collectionView else { return }
		let cellWidth = collectionView.bounds.width - horizontalInset * 2.0
		let cellWidthIncludingSpacing = cellWidth + cellSpacing

		// targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
		// 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
		var offset = targetContentOffset.pointee
		let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
		var roundedIndex = round(index)

		// scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
		// index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
		// 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
		if scrollView.contentOffset.x > targetContentOffset.pointee.x {
			roundedIndex = floor(index)
		} else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
			roundedIndex = ceil(index)
		} else {
			roundedIndex = round(index)
		}

		if isOneStepPaging {
			if currentIndex > roundedIndex {
				currentIndex -= 1
				roundedIndex = currentIndex
			} else if currentIndex < roundedIndex {
				currentIndex += 1
				roundedIndex = currentIndex
			}
		}

		// 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
		offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
		targetContentOffset.pointee = offset
	}
}

extension CenterHorizontalLayout: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.bounds.width - horizontalInset * 2.0, height: collectionView.bounds.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return cellSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let insetX: CGFloat = horizontalInset
		let insetY: CGFloat = 0
		return .init(top: insetY, left: insetX, bottom: insetY, right: insetX)
	}
}

@objc protocol CenterAlignCollectionViewDelegate: class {
	@objc optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	@objc optional func scrollViewEndDragging(offset: CGPoint, index: CGFloat)
	@objc optional func scrollViewDidScroll(progress: CGFloat)
}

class CenterAlignFlowLayout: UICollectionViewFlowLayout {

	private var cellSpacing: CGFloat        // cell간 간격
	private var horizontalInset: CGFloat    // 컬렉션뷰 좌우 inset
	private var isOneStepPaging: Bool        // 한번에 한 페이지 이동 여부
	private var currentIndex: CGFloat = 0
	weak var delegate: CenterAlignCollectionViewDelegate?

	init(cellSpacing: CGFloat, horizontalInset: CGFloat, isOneStepPaging: Bool) {
		self.cellSpacing = cellSpacing
		self.horizontalInset = horizontalInset
		self.isOneStepPaging = isOneStepPaging
		super.init()
		self.scrollDirection = .horizontal
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CenterAlignFlowLayout: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
	}

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

		guard let collectionView = collectionView else { return }
		let cellWidth = collectionView.bounds.width - horizontalInset * 2.0
		let cellWidthIncludingSpacing = cellWidth + cellSpacing

		var offset = targetContentOffset.pointee    // x좌표가 얼마나 이동했는지
		let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
		var roundedIndex = round(index)     // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정

		if scrollView.contentOffset.x > targetContentOffset.pointee.x { // 스크롤 방향을 확인하여 페이징 인덱스 확인
			roundedIndex = floor(index)
		} else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
			roundedIndex = ceil(index)
		} else {
			roundedIndex = round(index)
		}

		if isOneStepPaging {    // 한 페이지씩 페이징
			if currentIndex > roundedIndex {
				currentIndex -= 1
				roundedIndex = currentIndex
			} else if currentIndex < roundedIndex {
				currentIndex += 1
				roundedIndex = currentIndex
			}
		}

		offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
		targetContentOffset.pointee = offset        // 페이징 될 좌표값을 targetContentOffset에 대입

		delegate?.scrollViewEndDragging?(offset: offset, index: roundedIndex)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		delegate?.scrollViewDidScroll?(progress: scrollView.contentOffset.x / (scrollView.contentSize.width - horizontalInset * 2.0))
	}
}

extension CenterAlignFlowLayout: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.bounds.width - horizontalInset * 2.0, height: collectionView.bounds.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return cellSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let insetX: CGFloat = horizontalInset
		let insetY: CGFloat = 0
		return .init(top: insetY, left: insetX, bottom: insetY, right: insetX)
	}
}
