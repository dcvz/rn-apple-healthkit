'use strict'

let { AppleHealthKit } = require('react-native').NativeModules;

import { ActivityTypes } from './Constants/ActivityTypes'
import { Permissions } from './Constants/Permissions'
import { Units } from './Constants/Units'

let HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: {
		ActivityTypes: ActivityTypes,
		Permissions: Permissions,
		Units: Units,
	}
});

export default HealthKit
module.exports = HealthKit;
