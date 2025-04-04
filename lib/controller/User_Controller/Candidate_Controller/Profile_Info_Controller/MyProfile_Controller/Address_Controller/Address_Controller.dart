// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Collction/Location/jobtype_API_controller.dart';
import 'package:hirexpert/view/utils/common/Tostification/Toastification_success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../view/utils/app_constance.dart';
import '../../../../../API_Controller/Candidate/Collction/Location/preferencetype_API_controller.dart';
import '../../../../../API_Controller/Candidate/Collction/Pop_Collection/CountryList_pop_controller.dart';
import '../../../../../API_Controller/Candidate/Collction/Pop_Collection/DegreeList_pop_Controller.dart';
import '../../../../../API_Controller/Candidate/Collction/Poppup/candidateTech.dart';
import '../../../../../API_Controller/Candidate/Menu/Home/Candidate_Details_Controllres.dart';
import '../../../../../API_Controller/Candidate/Profile/My_Profile/Candidate_Update_Controllers.dart';

class AddressProvider extends GetxController {
  CandidatedetailsControllers_Controllrs Candidatedetails = Get.put(CandidatedetailsControllers_Controllrs());
  CandidateUpdateControllers CandidateUpdate = Get.put(CandidateUpdateControllers());
  Candidatetech candidate = Get.put(Candidatetech());
  DegreelistPopController Degree = Get.put(DegreelistPopController());
  PreferencetypeApiController Preferencet = Get.put(PreferencetypeApiController());
  JobtypeApiController JobType = Get.put(JobtypeApiController());

  //start
  //Personal Information
  TextEditingController? JobTitle_Controllers;
  TextEditingController? FirstName_Controllers;
  TextEditingController? LastName_Controllers;
  TextEditingController? Email_Controllers;
  TextEditingController? Phone_Controllers;
  TextEditingController? DOB_Controllers;

  //Address
  TextEditingController? Street_Controllers;
  TextEditingController? Post_Controllers;
  TextEditingController? SelectProvince_Controllers;
  TextEditingController? SelectCity_Controllers;

  //Education Details
  TextEditingController? Degree_Controllers;
  TextEditingController? Specialsation_Controllers;
  TextEditingController? Institute_Controllers;

  //Work Experience
  TextEditingController? CompanyName_Controllers;
  TextEditingController? Designation_Controllers;

  //Salary
  TextEditingController? CurrentSalary_Controllers;
  TextEditingController? CurrentExpented_Controllers;

  //Work Location
  TextEditingController? CurrentSalarywork_Controllers;
  TextEditingController? PrefferedSalary_Controllers;
  TextEditingController? Prefferedwork_Controllers;
  TextEditingController? JobType_Controllers;
  TextEditingController? NoticePeriod_Controllers;

  @override
  void onInit() {
    Tokans = pref!.getString('Tokan')!;
    Candidate = pref!.getString('Candidate')!;

    SharedPreferences.getInstance().then((prefs) {
        pref = prefs;
        savedIndex = pref!.getInt('selectedCheckboxIndex') ?? -1;
       update();
    });

    Countrylist.CountrylistPopController_fuction();
    Candidatedetails.CandidatedetailsControllers_Fuction(CandidateId: Candidate, Timezone: 'asia/kolkata', IsLabel: '1', CompanyId: '1', Tokan: Tokans);
    candidate.Candidatetech_fuctions(CandidateId: Candidate, TechId: TechId, Timezone: 'asia/kolkata');
    Degree.DegreelistPopController_Fuction(CandidateId: Candidate, TechId: TechId, Timezone: 'asia/kolkata');
    Preferencet.PreferencetypeApiController_fuction();
    JobType.JobtypeApiController_Fuction();

    var candidateData = Candidatedetails.Candidatedetails_data?['data'];

    //Personal Infromation
    JobTitle_Controllers = TextEditingController(text: candidateData['JobTitle'] ?? '');
    FirstName_Controllers = TextEditingController(text: candidateData['FirstName'] ?? '');
    LastName_Controllers = TextEditingController(text: candidateData['LastName'] ?? '');
    Email_Controllers = TextEditingController(text: candidateData['Email'] ?? '');
    Phone_Controllers = TextEditingController(text: candidateData['Phone'] ?? '');
    DOB_Controllers = TextEditingController(text: candidateData['DOB'].toString());

    //Address
    Street_Controllers = TextEditingController(text: candidateData['StreetAddress'] ?? '');
    Post_Controllers = TextEditingController(text: candidateData['PostCode'] ?? '');
    SelectProvince_Controllers = TextEditingController(text: candidateData['ProvinceName'] ?? '');
    SelectCity_Controllers = TextEditingController(text: candidateData['CityName'] ?? '');

    //Educational Details
    Degree_Controllers = TextEditingController(text: candidateData['DegreeName'] ?? '');
    Specialsation_Controllers = TextEditingController(text: candidateData['QuestionList'][0]['Answer'][0] ?? '');
    Institute_Controllers = TextEditingController(text: candidateData['DegreeName'] ?? '');

    //Work Experience
    CompanyName_Controllers = TextEditingController(text: candidateData['CompanyName'] ?? '');
    Designation_Controllers = TextEditingController(text: candidateData['Designation'] ?? '');

    //Salary
    CurrentSalary_Controllers = TextEditingController(text: candidateData['CurrentCTC'] ?? '');
    CurrentExpented_Controllers = TextEditingController(text: candidateData['ExpectedSalaryTo'] ?? '');

    //Work Location
    CurrentSalarywork_Controllers = TextEditingController(text: candidateData['Salary'] ?? '');
    PrefferedSalary_Controllers = TextEditingController(text: candidateData['CurrentLocation'] ?? '');
    Prefferedwork_Controllers = TextEditingController(text: candidateData['CurrentlyWork'] ?? '');
    JobType_Controllers = TextEditingController(text: candidateData['CurrentlyWork'] ?? '');
    NoticePeriod_Controllers = TextEditingController(text: candidateData['NoticePeriod'] ?? '');

    super.onInit();
  }

  //Dropdown
  CountrylistPopController Countrylist = Get.put(CountrylistPopController());

  //Address
  var Province = ''.obs;
  var city_Province = ''.obs;


  var selectedProvince = ''.obs;
  var provinceId = ''.obs;
  var cityList = <String>[].obs;
  var selectedCityId = ''.obs;
  var selectedProvinceBool = false.obs;
  var selectedCountry = ''.obs;

  var GraduationYears;

  var Specialization_pop_bool = false.obs;
  var Specialization_pop_ID = ''.obs;
  var Specialization_pop_name = ''.obs;
  var Specialization_post = ''.obs;

  var Degree_pop_bool = false.obs;
  var Degree_pop_ID  = ''.obs;
  var Degree_pop_name  = ''.obs;
  var Degree_pop_post  = ''.obs;

  var WorkSetup_bool = false.obs;
  var WorkSetup_pop_ID = ''.obs;
  var WorkSetup_pop_name = ''.obs;
  var WorkSetup_post = ''.obs;

  var JobType_bool = false.obs;
  var JobType_pop_ID = ''.obs;
  var JobType_pop_name = ''.obs;
  var JobType_post = ''.obs;

  var setectpasing = false.obs;
  ValueNotifier<int> passYearNotifier = ValueNotifier<int>(2001);

  var selectExperience_year = false.obs;
  var selectExperience_month = false.obs;
  ValueNotifier<int> experienceYearNotifier_start = ValueNotifier<int>(1);
  ValueNotifier<int> experienceYearNotifier_end = ValueNotifier<int>(1);

  void Gradution_ID(){
    setectpasing.value = true;
    GraduationYears = Candidatedetails.Candidatedetails_data?['data']['GraduationYears'];
    Get.back();
  }

  void Passyer(newValue) {
    setectpasing.value = true;
    passYearNotifier.value = newValue;
    update();
  }

  void Year(newValue){
    experienceYearNotifier_start.value = newValue;

    // Ensure start year is not greater than end year
    if (experienceYearNotifier_start.value > experienceYearNotifier_end.value) {
      experienceYearNotifier_end.value = newValue;
    }
    selectExperience_year.value = true;
  }

  void Month(newValue){
    experienceYearNotifier_end.value = newValue;
    selectExperience_month.value = true;
  }

  void Male_Value(int? value){
    savedIndex = value ?? -1;
    pref!.setInt('selectedCheckboxIndex', savedIndex!);
  }

  void Female_value(int? value){
    savedIndex = value ?? -1;
    pref!.setInt('selectedCheckboxIndex', savedIndex!);
  }

  void Other_value(int? value){
    savedIndex = value ?? -1;
    pref!.setInt('selectedCheckboxIndex', savedIndex!);
  }


  void toggleProvinceSelection() {
    selectedProvinceBool.value = !selectedProvinceBool.value;
  }

  void setSelectedProvince(String value) {
    selectedProvince.value = value;
    List<String> parts = value.split(':');
    provinceId.value = parts[0].trim();
    cityList.value = (Countrylist.countrylist['data'][0]['ProvinceList'].firstWhere((province) => province['ProvinceId'] == provinceId.value)['CityList'] as List).map<String>((city) => "${city['CityId']} : ${city['CityName']}").toList();
    selectedCityId.value = '';
  }

  void toggleCitySelection() {
    selectedProvinceBool.value = !selectedProvinceBool.value;
  }

  void setSelectedCity(String city) {
    selectedCityId.value = city;
  }

  void setSelectedCountry(String country) {
    selectedCountry.value = country;
  }

  void Degree_fuc(index){
    Degree_pop_bool.value = true;
    Degree_pop_post.value = Candidatedetails.Candidatedetails_data?['data']['DegreeName'];
    Degree_pop_ID.value = Degree.Degree_data['data'][index]['DegreeId'];
    Degree_pop_name.value = Degree.Degree_data['data'][index]['Name'];
    ToastificationSuccess.Success('$Degree_pop_name, $Degree_pop_ID');
    print('$Degree_pop_name, $Degree_pop_ID');
    Degree_pop_post.value = Degree_pop_name.value;
    Get.back();
    update();
  }

  void Specialisation(index){
    Specialization_pop_bool.value = true;
    Specialization_pop_ID.value = candidate.Candidatetech_data['data']['OptionList'][index]['QDetailId'];
    Specialization_pop_name.value = candidate.Candidatetech_data['data']['OptionList'][index]['QueAnswer'];
    Specialization_post.value = Specialization_pop_name.value;
    Get.back();
    ToastificationSuccess.Success('$Specialization_pop_ID, $Specialization_pop_name');
    update();
  }

  void Work_Setups(index){
    WorkSetup_bool.value = true;
    WorkSetup_pop_ID.value = JobType.jobtype_data['data'][index];
    WorkSetup_pop_name.value = JobType.jobtype_data['data'][index];
    WorkSetup_post.value = WorkSetup_pop_name.value;
    Get.back();
    ToastificationSuccess.Success('$WorkSetup_pop_ID, $WorkSetup_pop_name');
    update();
  }

  void Job_Types(index){
    JobType_bool.value = true;
    JobType_pop_ID.value = Preferencet.Preferencetype_data['data'][index];
    JobType_pop_name.value = Preferencet.Preferencetype_data['data'][index];
    JobType_post.value = JobType_pop_name.value;
    Get.back();
    ToastificationSuccess.Success('$JobType_pop_ID, $JobType_pop_name');
    update();
  }

  void Sentdata(){
    CandidateUpdate.CandidateUpdateControllers_Fuction(
      CandidateId: Candidate,
      Tokan: Tokans,
      UserId: Candidatedetails.Candidatedetails_data!['data']['UserId'],
      Timezone: 'asia/kolkata',

      //Personal Information
      FirstName: FirstName_Controllers!.text,
      JobTitle: JobTitle_Controllers!.text,
      Phone: Phone_Controllers!.text,
      DOB: DOB_Controllers!.text,
      Gender: savedIndex.toString(),

      //Address
      StreetAddress: Street_Controllers!.text,
      PostCode: Post_Controllers!.text,
      ProvinceId: provinceId.value.toString(),
      CityId: selectedCityId.value.toString(),

      //Educational Details
      DegreeIdProfile: Degree_pop_ID.value,
      GraduationYear: passYearNotifier.value.toString(),
      SpecialisationProfile: Specialization_pop_ID.value,

      //Work Experience
      YearsExperience: experienceYearNotifier_start.value.toString(),
      MonthExperience: experienceYearNotifier_end.value.toString(),
      CompanyNameProfile: CompanyName_Controllers!.text,
      DesignationProfile: Designation_Controllers!.text,

      //Salary
      CurrentCTC: CurrentSalary_Controllers!.text,
      ExpectedSalary: CurrentExpented_Controllers!.text,

      //Work Location
      NoticePeriod: NoticePeriod_Controllers!.text,
      WorkType: WorkSetup_pop_ID.value,
      JobType: JobType_pop_ID.value,
    );

    ToastificationSuccess.Success(Candidatedetails.Candidatedetails_data!['data']['message'].toString());
  }
}
