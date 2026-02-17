import 'package:e_consular_card/config/injection.dart';
import 'package:e_consular_card/core/data/models/location_models.dart';
import 'package:e_consular_card/core/navigation/main_navigation.dart';
import 'package:e_consular_card/core/presentation/providers/location_provider.dart';
import 'package:e_consular_card/core/services/storage_service.dart';
import 'package:e_consular_card/core/widget/location_dropdown.dart';
import 'package:e_consular_card/core/widget/phone_number_field.dart';
import 'package:e_consular_card/features/auth/presentation/providers/auth_provider.dart';
import 'package:e_consular_card/features/auth/presentation/widget/common_widget.dart';
import 'package:e_consular_card/features/auth/presentation/widget/registration_dropdown.dart';
import 'package:e_consular_card/features/auth/presentation/widget/registration_text_field.dart';
import 'package:e_consular_card/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';

class CompleteRegistrationPage extends StatefulWidget {
  const CompleteRegistrationPage({Key? key}) : super(key: key);

  @override
  State<CompleteRegistrationPage> createState() =>
      _CompleteRegistrationPageState();
}

class _CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String? _selectedIdType;
  String? _selectedMaritalStatus;
  String? _selectedEducationalQualification;
  String? _selectedCitizenBy;
  String? _selectedKinRelationship;

  final _additionalInfoFormKey = GlobalKey<FormState>();
  final _personalFormKey = GlobalKey<FormState>();
  final _kinFormKey = GlobalKey<FormState>();

  // Personal Info Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _country = TextEditingController();
  final _heightController = TextEditingController();
  final _numberOfChildrenController = TextEditingController();

  //additional info controllers
  final _addressController = TextEditingController();
  final _foreignAddressController = TextEditingController();
  final _countryOfResidenceController = TextEditingController();
  final _stateOfResidenceController = TextEditingController();
  final _lgaOfResidenceController = TextEditingController();
  final _stateOfOriginController = TextEditingController();
  final _educationalQualificationsController = TextEditingController();
  final _professionController = TextEditingController();
  final _citizenByController = TextEditingController();
  final _motherMaidenNameController = TextEditingController();
  //final _meansOfIdentificationController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();

  // Next of Kin Controllers
  final _kinFirstNameController = TextEditingController();
  final _kinLastNameController = TextEditingController();
  final _kinPhoneController = TextEditingController();
  final _kinEmailController = TextEditingController();
  final _kinRelationshipController = TextEditingController();
  final _kinAddressController = TextEditingController();


  // Location selections
  Country? _selectedCountry;
  StateModel? _selectedState;
  Lga? _selectedLga;


@override
void initState() {
  super.initState();
  
  // Debug: Check if token is available
  final storageService = getIt<StorageService>();
  final token = storageService.getFullToken();
  print('🔑 Token in Complete Registration: $token');
  _firstNameController.text = storageService.getUserFirstName() ?? '';
  _lastNameController.text = storageService.getUserLastName() ?? '';
}
  @override
  void dispose() {

    
    // Personal Info
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _country.dispose();
    _heightController.dispose();
    _numberOfChildrenController.dispose();
    //additional info 
    _addressController.dispose();
    _foreignAddressController.dispose();
    _countryOfResidenceController.dispose();
    _stateOfResidenceController.dispose();
    _lgaOfResidenceController.dispose();
    _stateOfOriginController.dispose();
    _educationalQualificationsController.dispose();
    _professionController.dispose();
    _citizenByController.dispose();
    _motherMaidenNameController.dispose();
    _idNumberController.dispose();
    _expiryDateController.dispose();


    // Next of Kin
    _kinFirstNameController.dispose();
    _kinLastNameController.dispose();
    _kinPhoneController.dispose();
    _kinEmailController.dispose();
    _kinRelationshipController.dispose();
    _kinAddressController.dispose();

    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final isValid = _validateCurrentPage();

    if (!isValid) return;

    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleSubmit();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

 
  Future<void> _handleSubmit() async {
    if (!_kinFormKey.currentState!.validate()) return;


    final authProvider = context.read<AuthProvider>();

    showLoadingDialog(context);

    final success = await authProvider.completeRegistration(
      countryId: _selectedCountry?.id ?? 0,
      stateId: _selectedState?.id ?? 0,
      lgaId: _selectedLga?.id ?? 0,
      means: _selectedIdType!,
      identification: _idNumberController.text.trim(),
      expiryDate: _expiryDateController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      height: _heightController.text.trim(),
      educationalQualification: _selectedEducationalQualification!,
      profession: _professionController.text.trim(),
      citizenBy: _selectedCitizenBy!,
      motherMaidenName: _motherMaidenNameController.text.trim(),
      maritalStatus: _selectedMaritalStatus!,
      kinFirstName: _kinFirstNameController.text.trim(),
      kinLastName: _kinLastNameController.text.trim(),
      kinPhone: _kinPhoneController.text.trim(),
      kinRelationship: _selectedKinRelationship!,
      kinEmail: _kinEmailController.text.trim(),
      kinAddress: _kinAddressController.text.trim(),
    );

    if (!mounted) return;
    hideLoadingDialog(context);

    if (success) {
      showSuccessSnackbar(context, 'Registration completed successfully!');
      final dashboardProvider = context.read<DashboardProvider>();
    dashboardProvider.markRegistrationAsComplete();

     // Show loading for refresh
    showLoadingDialog(context);
    
    // Refresh dashboard data to get updated regStatus
    await dashboardProvider.loadDashboardData();
    
    if (!mounted) return;
    hideLoadingDialog(context);

      // Navigate to main app
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
        (route) => false,
      );
    } else {
      showErrorSnackbar(
        context,
        authProvider.errorMessage ?? 'Failed to complete registration',
      );
    }}

  bool _validateCurrentPage() {
    switch (_currentPage) {
      case 0:
        return _personalFormKey.currentState!.validate();
      case 1:
        return _additionalInfoFormKey.currentState!.validate();
      case 2:
        return _kinFormKey.currentState!.validate();
      case 3:
        return true; // review page, nothing to validate
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_currentPage == 0) {
                        Navigator.pop(context);
                      } else {
                        _prevPage();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                  ),
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.backgroundMedium,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Page View
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildPersonalInfoForm(),
                    _buildAdditionalInfoForm(),
                    _buildKinInfoForm(),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Navigation Buttons
              Column(
                children: [
                  if (_currentPage > 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          elevation: 0,
                        ),
                        onPressed: _prevPage,
                        icon: Icon(Icons.arrow_back, color: AppColors.primary),
                        label: Text(
                          "Previous",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ),
                  if (_currentPage < 3) SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      onPressed: _nextPage,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      label: Text(
                        _currentPage == 2 ? "Submit" : "Next",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoForm() {

  final locationProvider = context.watch<LocationProvider>();
  
    return Form(
      key: _personalFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complete Registration",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Complete your registration",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "Personal Information",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: RegistrationTextField(
                    label: "First Name",
                    controller: _firstNameController,
                    hint: "Enter First Name",
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "First Name is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: RegistrationTextField(
                    label: "Last Name",
                    controller: _lastNameController,
                    hint: "Enter Last Name",
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last Name is required";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
           
          PhoneNumberField(
            label: "Phone Number",
            controller: _phoneController,
            dialCode: _selectedCountry?.dialCode,
            hint: "Enter Phone Number",
            maxLength: 11,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Phone Number is required";
              }
              return null;
            },
          ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Date of Birth",
              controller: _dobController,
              hint: "dd-mm-yyyy",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Date of Birth is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
         
          LocationDropdown<Country>(
            label: "Country",
            hint: "Select Country",
            value: _selectedCountry,
            items: locationProvider.countries,
            getLabel: (country) => country.capitalizedName,
            isLoading: locationProvider.isLoadingCountries,
            onChanged: (country) {
              setState(() {
                _selectedCountry = country;
                _selectedState = null; // Reset state
                _selectedLga = null; // Reset LGA
              });
              
              if (country != null) {
                // Load states for selected country
                locationProvider.loadStates(country.id);
              }
            },
            validator: (value) {
              if (value == null) {
                return "Country is required";
              }
              return null;
            },
          ),

          SizedBox(height: 16.h),

          // State Dropdown (only show if country is selected)
          if (_selectedCountry != null) ...[
            LocationDropdown<StateModel>(
              label: "State/Region",
              hint: "Select State",
              value: _selectedState,
              items: locationProvider.states,
              getLabel: (state) => state.name,
              isLoading: locationProvider.isLoadingStates,
              onChanged: (state) {
                setState(() {
                  _selectedState = state;
                  _selectedLga = null; // Reset LGA
                });
                
                if (state != null) {
                  // Load LGAs for selected state
                  locationProvider.loadLgas(state.id);
                }
              },
              validator: (value) {
                if (value == null) {
                  return "State is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
          ],

          // LGA Dropdown (only show if state is selected)
          if (_selectedState != null) ...[
            LocationDropdown<Lga>(
              label: "Local Government Area (LGA)",
              hint: "Select LGA",
              value: _selectedLga,
              items: locationProvider.lgas,
              getLabel: (lga) => lga.name,
              isLoading: locationProvider.isLoadingLgas,
              onChanged: (lga) {
                setState(() {
                  _selectedLga = lga;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "LGA is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
          ],


            RegistrationDropdown(
              label: "Marital Status",
              hint: "Select Marital Status",
              value: _selectedMaritalStatus,
              items: const [
                DropdownItem(value: 'single', label: 'Single'),
                DropdownItem(value: 'married', label: 'Married'),
                DropdownItem(value: 'divorced', label: 'Divorced'),
                DropdownItem(value: 'seperated', label: 'Seperated'),
                DropdownItem(value: 'widowed', label: 'Widowed'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMaritalStatus = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Marital Status is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Height(cm)",
              controller: _heightController,
              hint: "Enter Height in cm",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Height is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Number of Children",
              controller: _numberOfChildrenController,
              hint: "Enter Number of Children",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Number of Children is required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKinInfoForm() {
    return Form(
      key: _kinFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              "Next of Kin Information",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: RegistrationTextField(
                    label: "First Name",
                    controller: _kinFirstNameController,
                    hint: "Enter First Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "First Name is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: RegistrationTextField(
                    label: "Last Name",
                    controller: _kinLastNameController,
                    hint: "Enter Last Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last Name is required";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Phone Number",
              controller: _kinPhoneController,
              hint: "Enter Phone Number",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone Number is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Email",
              controller: _kinEmailController,
              hint: "Enter Email Address (e.g. example@gmail.com)",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email Address is required";
                }
                return null;
              },
            ),
             SizedBox(height: 16.h),
            RegistrationDropdown(
              label: "Relationship",
              hint: "Select Relationship",
              value: _selectedKinRelationship,
              items: const [
               
                DropdownItem(value: 'Father', label: 'Father'),
                DropdownItem(value: 'Mother', label: 'Mother'),
                 DropdownItem(value: 'Brother', label: 'Brother'),
                DropdownItem(value: 'Sister', label: 'Sister'),
                DropdownItem(value: 'Uncle', label: 'Uncle'),
                DropdownItem(value: 'Aunt', label: 'Aunt'),
                DropdownItem(value: 'Other', label: 'Other'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedKinRelationship = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Relationship is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Address",
              controller: _kinAddressController,
              hint: "Enter Contact Address",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Address is required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoForm() {
    return Form(
      key: _additionalInfoFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              "Additional Information",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24.h),
            RegistrationTextField(
              label: "Address of Residence",
              controller: _addressController,
              hint: "Enter Address of Residence",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Address of Residence is required";
                }
                return null;
              },
            ),
            SizedBox(width: 12.w),
            RegistrationTextField(
              label: "Foreign Address",
              controller: _foreignAddressController,
              hint: "Enter Foreign Address (if applicable)",
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "Foreign Address is required";
              //   }
              //   return null;
              // },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Country of Residence",
              controller: _countryOfResidenceController,
              hint: "Enter Country of Residence",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Country of Residence is required";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "State of Residence",
              controller: _stateOfResidenceController,
              hint: "Enter State of Residence",
              //   validator: (value) {
              // if (value == null || value.isEmpty) {
              //   return "State of Residence is required";
              // }
              // return null;
              //  },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "LGA of Residence",
              controller: _lgaOfResidenceController,
              hint: "Select LGA",
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "LGA is required";
              //   }
              //   return null;
              // },
            ),
            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "State of Origin",
              controller: _stateOfOriginController,
              hint: "Enter State of Origin",
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "State of Origin is required";
              //   }
              //   return null;
              // },
            ),
            SizedBox(height: 24.h),
            Text(
              "Misc Data",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
               SizedBox(height: 16.h),
            RegistrationDropdown(
              label: "Educational Qualification",
              hint: "Select Qualification",
              value: _selectedEducationalQualification,
              items: const [
                DropdownItem(value: 'HND', label: 'HND'),
                DropdownItem(value: 'Bachelor', label: 'Bachelor'),
                DropdownItem(value: 'Masters', label: 'Masters'),
                DropdownItem(value: 'PhD', label: 'PhD'),
                DropdownItem(value: 'Diploma', label: 'Diploma'),
                DropdownItem(value: 'Secondary', label: 'Secondary'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedEducationalQualification = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Educational qualification is required";
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            RegistrationTextField(
              label: "Profession",
              controller: _professionController,
              hint: "Enter Profession",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Profession is required";
                }
                return null;
              },
            ),
         
            SizedBox(height: 16.h),
            RegistrationDropdown(
              label: "Citizen By",
              hint: "Select Citizenship Type",
              value: _selectedCitizenBy,
              items: const [
                DropdownItem(value: 'birth', label: 'Birth'),
                DropdownItem(value: 'naturalization', label: 'Naturalization'),
                DropdownItem(value: 'registration', label: 'Registration'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCitizenBy = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Citizenship type is required";
                }
                return null;
              },
            ),

            SizedBox(height: 16.h),
            RegistrationTextField(
              label: "Mother's Maiden Name",
              controller: _motherMaidenNameController,
              hint: "Enter Mother's Maiden Name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Mother's maiden name is required";
                }
                return null;
              },
            ),

          
            SizedBox(height: 24.h),
            Text(
              "Identity Verification",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12.h),
            RegistrationDropdown(
              label: "Means of Identification",
              hint: "Enter Means of Identification",
              value: _selectedIdType,
              items: const [
                DropdownItem(
                    value: 'NATIONAL_INSURANCE', label: 'National Insurance'),
                DropdownItem(
                    value: 'IMMIGRATION_DOCUMENT', label: "Immigration Document"),
                   DropdownItem(
                    value: 'NIGERIAN_PASSPORT',
                    label: 'Nigerian Passport'),
                DropdownItem(
                    value: 'OTHER_PASSPORT', label: 'Other Passport'),
                        DropdownItem(
                    value: 'OTHER_TRAVEL_DOCUMENT', label: 'Other Travel Document'),
                   DropdownItem(
                    value: 'OTHER_NATIONAL_IDENTITY_CARD', label: 'Other National Identity Card'),
                   DropdownItem(
                    value: 'ANY_IDENTITY_REFERENCE', label: 'Any Identity Reference'),
                   DropdownItem(
                    value: 'NIGERIA_DRIVER_LICENCE', label: 'Nigeria Driver Licence'),
                DropdownItem(
                    value: 'OTHER_DESIGNATED_DOCUMENT', label: 'Other Passport'),
               
              ],
              onChanged: (value) {
                setState(() {
                  _selectedIdType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "ID Type is required";
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            RegistrationTextField(
              label: "Enter ID Number",
              controller: _idNumberController,
              hint: "Enter ID Number",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "ID Number is required";
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            RegistrationTextField(
              label: "Expiry Date",
              controller: _expiryDateController,
              hint: "Enter Expiry Date",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Expiry Date is required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
