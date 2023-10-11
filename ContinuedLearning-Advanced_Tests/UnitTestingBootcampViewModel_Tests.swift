//
//  UnitTestingBootcampViewModel_Tests.swift
//  ContinuedLearning-Advanced_Tests
//
//  Created by Volkan Celik on 05/10/2023.
//

import XCTest
@testable import ContinuedLearning_Advanced

//naming structure:test_UnitOfWork_StateUnderTest_ExpectedBehaviour
//naming structure:test_[struct or class])_[variable or function]_[expected result]


//Testing structure:Given,when,then

final class UnitTestingBootcampViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue(){
        //Given
        let userIsPremium:Bool=true
        //When
        let vm=UnitTestingBootcampViewModel(isPremium: userIsPremium)
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse(){
        //Given
        let userIsPremium:Bool=false
        //When
        let vm=UnitTestingBootcampViewModel(isPremium: userIsPremium)
        //Then
        XCTAssertFalse(vm.isPremium)
        //XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_sholduBeInjectedValue(){
        //Given
        let userIsPremium:Bool=Bool.random()
        //When
        let vm=UnitTestingBootcampViewModel(isPremium: userIsPremium)
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_sholduBeInjectedValue_stress(){
        for _ in 0..<10{
            let userIsPremium:Bool=Bool.random()
            //When
            let vm=UnitTestingBootcampViewModel(isPremium: userIsPremium)
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty(){
        //Given
        //When
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems(){
        //Given
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let loopCount:Int=Int.random(in: 1..<100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        //XCTAssertGreaterThanOrEqual(vm.dataArray.count, 1)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString(){
        //Given
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        vm.addItem(item: "")
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil(){
        //Given
        //When
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem(){
        //Given
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        //select valid item
        let newItem=UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //select invalid item
        vm.selectItem(item: UUID().uuidString)
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected(){
        //Given
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let newItem=UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress(){
        //Given
        let vm=UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let loopCount:Int=Int.random(in: 1..<100)
        var itemsArray:[String]=[]
        for _ in 0..<loopCount{
            let newItem=UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomElement=itemsArray.randomElement() ?? ""
        
        vm.selectItem(item: randomElement)
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomElement)
    }

}
