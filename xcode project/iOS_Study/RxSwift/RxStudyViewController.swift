//
//  RxStudyViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/07/19.
//

import UIKit
import RxSwift
import RxCocoa

class RxStudyViewController: UIViewController {

	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		practice()
	}

	/// https://eunjin3786.tistory.com/37
	/// https://joycestudios.tistory.com/88

	func practice() {

		print("========== RxSwfit 예제 ==========")

		// MARK: - Observable
		// Observable에서 새로운 이벤트가 발생하면 next 이벤트로 Observer에 전달

//		let intObservable = Observable<Int>.of(1,2,3,4,5)
		let intObservable = Observable<Int>.from([1,2,3,4,5])
		intObservable.subscribe(onNext: { int in
			print(int)
		})
		.disposed(by: disposeBag)

		intObservable.subscribe(onNext: { int in
			print(int + 100)
		})
		.disposed(by: disposeBag)

//		intObservable.subscribe(onNext: { int in
//			print(int)
//		})
//		.disposed(by: disposeBag)

		// MARK: - Observable과 Subject 차이점
		// Subject 는 구독을 여러개 추가 가능

		let subject = PublishSubject<String>()

		subject.onNext("0")

		subject.subscribe(onNext: { string in
			print("첫 번째 구독" + string)
		})
		.disposed(by: disposeBag)

		subject.on(.next("1"))
		subject.onNext("2")

		subject.subscribe(onNext: { string in
			print("두 번째 구독" + string)
		})
		.disposed(by: disposeBag)

		subject.onNext("3")

		// MARK: - PublishSubject
		// Subject는 Observable 인 동시에 Observer 이다.
		// - default값(초기값)이 없다
		// - 다른 옵져버가 subscribe한 순간 아무것도 주지 않지만 데이터가 발생하면 다 준다

		let publishSubject = PublishSubject<String>()	// 생성자에 별 다른 인자를 전달하지 않음

		publishSubject.onNext("publish subject 첫번째")	// 구독 전에 전달 한 이벤트는 전달하지 않음
		publishSubject.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)

		publishSubject.onNext("publish subject 두번째")

		publishSubject.subscribe(onNext: { emitter in
			print(emitter + "!!!!")
		})
		.disposed(by: disposeBag)

		publishSubject.onNext("publish subject 세번째")

		let publishSubjectCreated = PublishSubject<String>.create { (emitter) -> Disposable in
			emitter.onNext("요호")
			return Disposables.create()
		}

		publishSubjectCreated.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)

		publishSubjectCreated.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)

		// MARK: - BehaviorSubject
		// - default(초기값) 을 넣어주어야한다
		// - 값이 없을때 (초기값만 있을 때) subscribe하면 초기값을 주고, 값이 있을때 subcribe하면가장 최근의 것을 준다
		// - 중간에 error가 나면 subscribe하고 있는 모든 옵져버들한테 에러가 간다

		let behaviorSubject = BehaviorSubject<String>(value: "기본값")	// PublishSubject에서는 기본값을 가지고 있다.
//		behaviorSubject.onNext("behavior subject 첫번째")					// 만약 구독자가 구독을 하게 되면 이벤트를 방출하는데 최대 1개의 이벤트만 저장해두기 때문에 이전 이벤트는 제거된다.
		behaviorSubject.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)
		behaviorSubject.onNext("behavior subject 두번째")

		// MARK: - ReplaySubject
		// - default값(초기값)이 없다
		// - 다른 옵져버가 subscribe하면 여태까지 발생했던것 다 준다

		let replaySubject = ReplaySubject<String>.create(bufferSize: 3)
		let replayData = ["헬", "로", "우", "월", "드"]

		replayData.forEach{ replaySubject.onNext($0) }	//

		replaySubject.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)

		replayData.forEach{ replaySubject.onNext($0) }

		// MARK: - AsyncSubject
		// - default값(초기값)이 없다
		// - Subject가 complete되면 가장 마지막 데이터를 그때서야 다른 옵져버에게 넘겨준다

		let asyncSubject = AsyncSubject<Int>()
		asyncSubject.subscribe(onNext: { emitter in
			print(emitter)
		})
		.disposed(by: disposeBag)

		asyncSubject.onNext(1)
		asyncSubject.onNext(2)
		asyncSubject.onNext(3)	// <- onCompleted 시점에 가장 최근 전달된 이벤트만 전달
		asyncSubject.onCompleted()

		// MARK: - Relay
		// Relay는 Subject와 매우 유사한 특징을 가지고 있다. 다만 오직 next 이벤트만 전달이 가능하다.
		// Subject와 달리 구독자가 Dispose 되기 전까지 메모리에서 해제 되지 않는다. -> UI Event 처리에 활용
		// 한번 시작된 스트림은 종료되지 않는다.

		let publishRelay = PublishRelay<String>()

		publishRelay.subscribe(onNext: {
			print($0)
		})

		publishRelay.accept("relay emit")

		// MARK: - Driver
		// Observable에서 에러를 무시하고 싶다면 Driver를 사용하면 된다.
		// Relay와 마찬가지로 UI에서 사용하는 용도로 만들어둔 것이다( + MainScheduler.instance 해줄 필요 없다. Main Scheduler에서 동작하기 때문)
	}
}
