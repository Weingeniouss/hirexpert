// ignore_for_file: constant_identifier_names, file_names, unused_import

import 'package:hirexpert/view/screen/Employer/collection/Signup.dart';

// static const Hirexpert = "https://cidevelop.weingenious.in/hirexpert/"; //Staging
// static const Hirexpert = "http://192.168.1.123/stage_gohire/";  //Local

class AppUrl {
  static const WebSocket = "wss://echo.websocket.events";
  static const Hirexpert = "https://cidevelop.weingenious.in/hirexpert";
  static const Base_location = "$Hirexpert/api/v1/";

  //Candidate
  //Popup
  static const preferredWork = "$Base_location/user/preferredWorkSetupList";
  static const Jobtype = "$Base_location/user/jobTypeList";
  static const interest = "$Base_location/user/candidateTech";
  static const degreeList = "$Base_location/user/degreeList";
  static const technologyList = "$Base_location/user/technologyList";

  //Show All Data
  static const Search_Job = "$Base_location/Advertisedjob/JobFilterList?TechId=3";
  static const SearchJob = "$Base_location/Advertisedjob/SearchJob";
  static const CandFilterList = "$Base_location/Advertisedjob/CandFilterList";

  //Collcetion
  static const login = "$Base_location/user/login";
  static const Sinup = "$Base_location/user/candidateSignup";
  static const OTP = "$Base_location/user/candidateOTPVerified/NTU=";
  static const Change_password = "$Base_location/user/changePassword";
  static const tagList = "$Base_location/user/tagList";
  static const Concern = "$Base_location/Advertisedjob/addConcern";
  static const count = "$Base_location/Advertisedjob/JobStatusWiseCountList";
  static const savelist = "$Base_location/Advertisedjob/FavouriteJobList";
  static const password_change = "$Base_location/user/changePassword";

  //Menu
  static const Offer = "$Base_location/Advertisedjob/AdvertiseJob";
  static const Offes = "$Base_location/Advertisedjob/JobStList";
  static const IsFavourite = "$Base_location/Advertisedjob/CanFavourite";
  static const JobInterviewList = "$Base_location/Advertisedjob/JobInterviewList";
  static const Applyed = "$Base_location/Advertisedjob/JobApply";
  static const isApplyed = "$Base_location/Advertisedjob/CanJobDetails";
  static const update_profile = "$Base_location/user/CandidateProfile";
  static const CanWithdrawJob = "$Base_location/Advertisedjob/CanWithdrawJob";
  static const applyStatusChange = "$Base_location/Advertisedjob/applyStatusChange";
  static const CanArchiveJob = "$Base_location/Advertisedjob/CanArchiveJob";
  static const ArchiveJobList = "$Base_location/Advertisedjob/ArchiveJobList";
  static const JobInterview = "$Base_location/Advertisedjob/JobInterview";
  static const CanIntReply = "$Base_location/Advertisedjob/CanIntReply";
  static const OfferedjobConfim = "$Base_location/Advertisedjob/OfferedjobConfim";

  //Details
  static const details = "$Base_location/Advertisedjob/JobDetails";
  static const ApplyJobList = "$Base_location/Advertisedjob/ApplyJobList";
  static const CanJobDetails = "$Base_location/Advertisedjob/CanJobDetails";
  static const CandidateDetails = "$Base_location/user/CandidateDetails";
  static const CandidateUpdate = "$Base_location/user/CandidateUpdate";
  static const CertificateList_list = "$Base_location/user/CertificateList";
  static const CertificateList_list_remove = "$Base_location/user/RemoveCertficate";
  static const CertificateList_list_add = "$Base_location/user/AddUpdCertificate";
  static const JobApply = "$Base_location/Advertisedjob/JobApply";

  //Notification
  // static const Notification = "$Hirexpert/api/v1/user/notificationList?UserType=Candidate";
  static const Notification = "$Base_location/user/userNotification";
  static const taglist = "$Base_location/user/tagList";
  static const updateAllNotification = '$Base_location/user/updateAllNotification';

  //Pop
  static const describe_your_job = '$Base_location/user/technologyList';
  static const candidateTech = '$Base_location/user/candidateTech';
  static const CountryList = '$Base_location/user/CountryList';

  //Profile
  static const CandidateUpdates = '$Base_location/user/CandidateUpdate';
  static const candidateBIO = '$Base_location/user/candidateBIO';
  //Stting
  static const privacyPolicy = '$Base_location/user/privacyPolicy';
  static const termsConditions = '$Base_location/user/termsConditions';
  static const RemoveAccount = '$Base_location/user/RemoveAccount';
  static const SetPrivateAccount = '$Base_location/user/SetPrivateAccount';
  static const AddFeedback = '$Base_location/user/AddFeedback';

  //Commnication
  static const setmsg = '$Base_location/chat/SendMsg';
  static const sendMessage = '$Base_location/Advertisedjob/sendMessage';
  static const CanChatList = '$Base_location/chat/JobChatList';
  static const ChatDetail = '$Base_location/chat/ChatDetail';
  static const ChatRoomExist = '$Base_location/chat/ChatRoomExist';


  //Dashbord
  static const SetPrivateAccounts = '$Base_location/user/SetPrivateAccount';
  static const CandidateResume = '$Base_location/user/CandidateResume';
  static const recommendationsJob = '$Base_location/Advertisedjob/recommendationsJob';
  static const upcomingInterviewList = '$Base_location/Advertisedjob/upcomingInterviewList';
  static const jobApplication = '$Base_location/Advertisedjob/jobApplication';
  static const SaveJob = '$Base_location/Advertisedjob/candidateSaveJobList';
  static const candidateProfileAnalytics = '$Base_location/user/candidateProfileAnalytics';
  static const JobInterviewLists = '$Base_location/Advertisedjob/JobInterviewList';
  static const candidateProfileCalculate = '$Base_location/user/candidateProfileCalculate?CandidateId=6&Timezone=asia%2Fkolkata';

  //Employer
  //Collcetion
  static const Employer_Signup = "$Hirexpert/api/v1/user/employerSignup";

  //Profile
  static const Employer_profile = "$Hirexpert/user/login";
}
