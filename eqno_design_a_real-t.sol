pragma solidity ^0.8.0;

contract RealTimeMobileAppMonitor {
    // Mapping of app IDs to their respective monitoring data
    mapping(bytes32 => MonitoringData) public appData;

    // Struct to represent monitoring data for an app
    struct MonitoringData {
        uint256 crashCount;
        uint256 errorCount;
        uint256 requestCount;
        uint256 responseTimeAvg;
        uint256 lastUpdated;
    }

    // Event emitted when new monitoring data is received
    event NewDataReceived(bytes32 appId, MonitoringData data);

    // Function to update monitoring data for an app
    function updateAppData(bytes32 appId, uint256 crashCount, uint256 errorCount, uint256 requestCount, uint256 responseTimeAvg) public {
        MonitoringData storage data = appData[appId];
        data.crashCount += crashCount;
        data.errorCount += errorCount;
        data.requestCount += requestCount;
        data.responseTimeAvg = (data.responseTimeAvg * data.requestCount + responseTimeAvg) / (data.requestCount + 1);
        data.lastUpdated = block.timestamp;
        emit NewDataReceived(appId, data);
    }

    // Function to get monitoring data for an app
    function getAppData(bytes32 appId) public view returns (MonitoringData memory) {
        return appData[appId];
    }
}