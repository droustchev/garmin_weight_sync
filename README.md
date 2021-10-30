# WeightSync

I have a Withings Scale and a Garmin watch. My daily weight measurements end up in Withings Health Mate, but all my other data is in Garmin Connect. These two platforms are currently not able to directly exchange data, which is a pity. There are workarounds through third party sercies, such as MyFitnessPal, or scripts/sites which require you to enter both your Withings and Garmin Connect credentials. Naturally, I'm not a fan of this and also don't feel compelled to sign up for yet another service and give them access to my data.

Withings/Health Mate has an API that allows to pull measurements, but unfortunately Garmin Connect does not. There are solutions out ther that generate FIT files and use Garmin's internal API to upload those FIT files, but that is very hacky and would break the moment Garmin chnages anything about their internal APIs.

Garmin wearables are able to create FIT files though, so my idea is to have a ConnectIQ application, that can pull data from Withings/Health Mate and creates FIT files (of the dedicated 'Weight' type), which should in theory then sync to Garmin Connect like any other activities/measurements.

This is all WIP at the moment though, as I'm new to the entire Garmin ecosystem.

Pull requests welcome!

