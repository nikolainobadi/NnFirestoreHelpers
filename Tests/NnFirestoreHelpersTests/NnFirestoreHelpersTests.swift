import XCTest
import NnFirestoreHelpers

final class NnFirestoreHelpersTests: XCTestCase {
    
    func test_batchUpdater() {
        let factory = NnBatchUpdaterComposite()
        let updater = factory.makeBatchUpdater()
    
    }
}
