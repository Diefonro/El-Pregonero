//
//  El_PregoneroTests.swift
//  El PregoneroTests
//
//  Created by Andrés Fonseca on 24/05/2024.
//

import XCTest
@testable import El_Pregonero

class NewsListScreenVCTests: XCTestCase {
    
    var sut: NewsListScreenVC!
    var mockViewModel: MockNewsScreenViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "NewsListScreen", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "NewsListScreenVC") as? NewsListScreenVC
        mockViewModel = MockNewsScreenViewModel()
        sut.setViewModel(viewModel: mockViewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }

    func testFetchShows() async throws {
      await sut.fetchShows()
      XCTAssertTrue(mockViewModel.getShowsCalled, "getShows should be called")
      XCTAssertEqual(DataManager.showsData.count, mockViewModel.mockShowsData.count, "Shows data count should match")
    }
    
    @MainActor func setUpWithErrorHandling() {
      let mockViewModel = MockNewsScreenViewModel()
      sut = NewsListScreenVC()
      sut.viewModel = mockViewModel
    }
    
     func testFetchNews() async throws {
         await setUpWithErrorHandling()

       await sut.fetchNews()

       XCTAssertTrue(mockViewModel.getJPNewsCalled, "getJPNewsCalled should be called")
       XCTAssertTrue(mockViewModel.getTNNewsCalled, "getTNNewsCalled should be called")
       XCTAssertTrue(mockViewModel.getDJNewsCalled, "getDJNewsCalled should be called")
     }

     func testFetchSports() async throws {
         await setUpWithErrorHandling()

       let expectation = expectation(description: "Wait for sports data assignment")
         await sut.viewModel?.getSports {
         expectation.fulfill()
       }

         await fulfillment(of: [expectation], timeout: 1)

       XCTAssertTrue(mockViewModel.getSportsCalled, "getSports should be called")
     }

    func testViewModelGetSports() async throws {
      let expectation = expectation(description: "Wait for sports data assignment")

      mockViewModel.getSports {
        expectation.fulfill()
      }
        

      await fulfillment(of: [expectation], timeout: 1)

      XCTAssertTrue(mockViewModel.getSportsCalled, "getSports should be called")
      XCTAssertEqual(DataManager.matchesData.count, mockViewModel.mockSportsData.count, "Sports data count should match")
    }
}

class UsersListScreenTests: XCTestCase {
    
    var sut: UsersListScreenVC!
    var mockViewModel: MockUserListScreenViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "UsersListScreen", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "UsersListScreenVC") as? UsersListScreenVC
        mockViewModel = MockUserListScreenViewModel()
        sut.setViewModel(viewModel: mockViewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testFetchUsers() async throws {
        await sut.fetchUsers()
        XCTAssertTrue(mockViewModel.getUsersCalled, "getUsers should be called")
        XCTAssertEqual(DataManager.usersData.count, mockViewModel.mockUsersData.count, "Users data count should match")
    }
    
    func testViewModelGetUsers() async throws {
        let expectation = expectation(description: "Wait for users data assignment")

        mockViewModel.getUsers {
            expectation.fulfill()
        }
        

        await fulfillment(of: [expectation], timeout: 1)

        XCTAssertTrue(mockViewModel.getUsersCalled, "getUsers should be called")
        XCTAssertEqual(DataManager.usersData.count, mockViewModel.mockUsersData.count, "Users data count should match")
    }
}

class MockUserListScreenViewModel: UserListScreenViewModel {
    var getUsersCalled = false
    var mockUsersData = Users()

    override func getUsers(completion: @escaping () -> Void) {
        getUsersCalled = true
        DataManager.usersData = mockUsersData
        completion()
    }
}


class DataManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        DataManager.newsJPData.removeAll()
        DataManager.newsTNData.removeAll()
        DataManager.newsDJData.removeAll()
        DataManager.showsData.removeAll()
        DataManager.matchesData.removeAll()
    }

    func testSettingJPNewsData() {
        let news = [NewsElement(slug: "test-slug", url: "http://test.url", title: "Test Title", content: "Test Content", image: "http://test.image", thumbnail: "http://test.thumbnail", status: "published", publishedAt: "2022-01-01", updatedAt: "2022-01-01")]
        DataManager.newsJPData = news
        XCTAssertEqual(DataManager.newsJPData.count, 1)
        XCTAssertEqual(DataManager.newsJPData.first?.title, "Test Title")
    }

    func testSettingTNNewsData() {
        let news = [Datum(title: "Test Title", description: "Test Description", url: "http://test.url", imageURL: "http://test.image", publishedAt: "2022-01-01", source: "Test Source")]
        DataManager.newsTNData = news
        XCTAssertEqual(DataManager.newsTNData.count, 1)
        XCTAssertEqual(DataManager.newsTNData.first?.title, "Test Title")
    }

    func testSettingDJNewsData() {
        let posts = [Post(title: "Test Title", body: "Test Body", reactions: Reactions(likes: 10, dislikes: 1), views: 100, userID: 1)]
        DataManager.newsDJData = posts
        XCTAssertEqual(DataManager.newsDJData.count, 1)
        XCTAssertEqual(DataManager.newsDJData.first?.title, "Test Title")
    }

    func testSettingMatchesData() {
        let match = MatchElement(competition: "Test Competition", utcDate: "2022-01-01", homeTeam: Team(name: "Home Team", nameShort: "HT", crest: "http://home.team.crest"), awayTeam: Team(name: "Away Team", nameShort: "AT", crest: "http://away.team.crest"), score: Score(winner: "HT", home: 2, away: 1), referee: "Test Referee", status: "finished", news: nil)
        DataManager.matchesData = [match]
        XCTAssertEqual(DataManager.matchesData.count, 1)
        XCTAssertEqual(DataManager.matchesData.first?.competition, "Test Competition")
    }
    
    func testSettingUsersData() {
        let user = User(id: 1, firstname: "Test", lastname: "User", email: "test@example.com", birthDate: "2000-01-01", address: Address(street: "123 Street", suite: "Apt 101", city: "City", zipcode: "12345", geo: Geo(lat: "0.0", lng: "0.0")), phone: "123-456-7890", website: "example.com", company: Company(name: "Test Company", catchPhrase: "Catchy phrase", bs: "BS"))
        DataManager.usersData = [user]
        XCTAssertEqual(DataManager.usersData.count, 1)
        XCTAssertEqual(DataManager.usersData.first?.firstname, "Test")
    }
}

class MockNewsScreenViewModel: NewsScreenViewModel {
    var getShowsCalled = false
    var getJPNewsCalled = false
    var getTNNewsCalled = false
    var getDJNewsCalled = false
    var getSportsCalled = false
    
    var mockShowsData = [Show]()
    var mockJPNewsData = JPNews()
    var mockTNNewsData = [Datum]()
    var mockDJNewsData = [Post]()
    var mockSportsData = [MatchElement]()
    
    override func getShows() async {
        getShowsCalled = true
        DataManager.showsData = mockShowsData
    }
    
    override func getJPNews() async {
        getJPNewsCalled = true
        DataManager.newsJPData = mockJPNewsData
    }
    
    override func getTNNews() async {
        getTNNewsCalled = true
        DataManager.newsTNData = mockTNNewsData
    }
    
    override func getDJNews() async {
        getDJNewsCalled = true
        DataManager.newsDJData = mockDJNewsData
    }
    
    override func getSports(completion: @escaping () -> Void) {
        getSportsCalled = true
        DataManager.matchesData = mockSportsData
        completion()
    }
}
