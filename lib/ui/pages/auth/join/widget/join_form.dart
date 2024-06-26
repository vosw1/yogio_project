import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:yogi_project/_core/constants/size.dart';
import 'package:yogi_project/_core/constants/style.dart';
import 'package:yogi_project/_core/utils/validator_util.dart';
import 'package:yogi_project/data/dtos/user_request.dart';
import 'package:yogi_project/data/store/session_store.dart';
import 'package:yogi_project/ui/pages/_main_holder.dart';
import 'package:yogi_project/ui/pages/auth/join/widget/join_text_form_field.dart';
import 'package:yogi_project/ui/pages/auth/join/widget/duplicate_email.check.dart';
import 'package:yogi_project/ui/pages/home/home_page.dart';

class JoinForm extends StatefulWidget {
  @override
  _JoinFormState createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _ageController = MaskedTextController(mask: '0000-00-00');
  final _phoneController = MaskedTextController(mask: '000-0000-0000');
  List<bool> _subCheckboxValues = [false, false];
  bool _isAllChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          JoinTextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: '이메일',
            hintText: 'example@email.com',
            validator: validateEmail,
          ),
          SizedBox(height: gap_s),
          DuplimentEmailCheck(emailController: _emailController),
          SizedBox(height: gap_s),
          JoinTextFormField(
            controller: _passwordController,
            labelText: '비밀번호',
            validator: validatePassword,
            hintText: "패스워드를 입력하세요",
          ),
          SizedBox(height: gap_m),
          JoinTextFormField(
            controller: _nameController,
            labelText: '이름',
            validator: validateName,
            hintText: "이름을 입력하세요",
          ),
          SizedBox(height: gap_m),
          JoinTextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            labelText: '생년월일',
            hintText: 'YYYY-MM-DD',
            validator: validateAge,
          ),
          SizedBox(height: gap_m),
          JoinTextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            labelText: '전화번호',
            hintText: '000-0000-0000',
            validator: validatePhoneNumber,
          ),
          SizedBox(height: gap_m),
          Row(
            children: [
              Checkbox(
                value: _isAllChecked,
                onChanged: (value) {
                  setState(() {
                    _isAllChecked = value ?? false;
                    _subCheckboxValues =
                    List<bool>.filled(_subCheckboxValues.length, _isAllChecked);
                  });
                },
              ),
              GestureDetector(
                onTap: () async {
                  _showPopup(context, 0);
                },
                child: Text(
                  '전체 동의',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          _buildCheckboxWithPopup(
            context: context,
            index: 0,
            text: '만 14세 이상 확인',
          ),
          _buildCheckboxWithPopup(
            context: context,
            index: 1,
            text: '개인정보 수집 및 이용 동의',
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _canProceed()
                ? () {
              if (_formKey.currentState!.validate()) {
                String password = _passwordController.text;
                String email = _emailController.text;
                String name = _nameController.text;
                String phone = _phoneController.text;
                String address = _addressController.text;
                String birth = _ageController.text;

                JoinReqDTO joinReqDTO = JoinReqDTO(
                    password: password,
                    email: email,
                    name: name,
                    phone: phone,
                    birth: birth);

                SessionStore store =
                SessionStore(); // Change this to the appropriate way to get the SessionStore instance

                store.join(joinReqDTO);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainHolder()),
                        (route) => false);
              }
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: Text('회원가입', style: h5(mColor: Colors.white)),
          ),
          SizedBox(height: gap_l),
        ],
      ),
    );
  }

  Widget _buildCheckboxWithPopup({
    required BuildContext context,
    required int index,
    required String text,
  }) {
    return Row(
      children: [
        Checkbox(
          value: _subCheckboxValues[index],
          onChanged: (value) {
            setState(() {
              _subCheckboxValues[index] = value ?? false;
              _isAllChecked = _subCheckboxValues.every((element) => element);
            });
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _showPopup(context, index + 1);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text),
                Icon(Icons.arrow_forward_ios, size: gap_m), // 아이콘의 위치를 적절히 조정
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    return _subCheckboxValues.every((element) => element);
  }

  void _showPopup(BuildContext context, int index) {
    AlertDialog? alertDialog;

    switch (index) {
      case 1:
        alertDialog = _buildDialog(
          title: '만 14세 이상 확인',
          content: [
            _buildDialogContent(
              '만 14세 이상 이용 확인 동의',
              '여어떻노는 만 14세 미만 아동의 서비스 이용을 제한하고 있습니다.\n\n'
                  '개인정보 보호법에는 만 14세 미만 아동의 개인정보 수집 시 법정대리인 동의를 받도록 규정하고 있으며,\n'
                  '만 14세 미만 아동이 법정대리인 동의없이 서비스 이용이 확인된 경우 서비스 이용이 제한될 수 있음을 알려드립니다',
            ),
          ],
        );
        break;
      case 2:
        alertDialog = _buildDialog(
          title: '개인정보 수집 및 이용 동의',
          content: [
            _buildDialogContent(
              '개인정보 수집 및 이용 확인 동의',
              '필수\t예약/구매 서비스 제공 상담 및 부정거래 기록 확인\t\n'
                  '[예약·구매]\n'
                  '예약자 정보(이름, 휴대전화번호)\n'
                  '[결제]\n'
                  '거래내역\n'
                  '*결제 시 개인정보는 PG사(결제대행업체)에서 수집 및 저장하고 있으며, 회사는 PG사에서 제공하는 거래 내역만 제공받음\n'
                  '[거래명세서 발급]\n'
                  '이메일주소\n'
                  '[현금영수증 발급]\n'
                  '휴대전화번호, 이메일주소\n'
                  '[취소·환불]\n'
                  '은행명, 계좌번호, 예금주명\n'
                  '- 회원 탈퇴 시 까지\n'
                  '* 관계 법령에 따라 보존할 필요가 있는 경우 해당 법령에서 요구하는 기한까지 보유\n'
                  '※ 위 동의 내용을 거부하실 수 있으나, 동의를 거부하실 경우 서비스를 이용하실 수 없습니다.\n'
                  '※ 개인정보 처리와 관련된 상세 내용은 \'개인정보처리방침\'을 참고',
            ),
          ],
        );
        break;
    }

    if (alertDialog != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog!;
        },
      );
    }
  }

  AlertDialog _buildDialog(
      {required String title, required List<Widget> content}) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content,
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Center(child: Text('확인')),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogContent(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
