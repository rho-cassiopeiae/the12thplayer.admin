import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/account_actions.dart';
import '../bloc/account_bloc.dart';
import '../../general/extensions/kiwi_extension.dart';
import '../bloc/account_states.dart';
import '../enums/auth_page_mode.dart';

class AuthPage extends StatefulWidget with DependencyResolver<AccountBloc> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState(resolve());
}

class _AuthPageState extends State<AuthPage> {
  final AccountBloc _accountBloc;

  final TextStyle _labelStyle = GoogleFonts.openSans(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  late final FlyoutController _flyoutController;

  late AuthPageMode _mode;

  String? _email;
  String? _username;
  String? _password;
  String? _confirmationCode;
  String? _payload;
  String? _signature;

  _AuthPageState(this._accountBloc);

  @override
  void initState() {
    super.initState();
    _flyoutController = FlyoutController();
    _mode = AuthPageMode.SignUp;
  }

  @override
  void dispose() {
    _flyoutController.dispose();
    super.dispose();
  }

  Widget _buildEmailField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Email',
        headerStyle: _labelStyle,
        onChanged: (value) => _email = value,
      ),
    );
  }

  Widget _buildUsernameField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Username',
        headerStyle: _labelStyle,
        onChanged: (value) => _username = value,
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Password',
        headerStyle: _labelStyle,
        obscureText: true,
        onChanged: (value) => _password = value,
      ),
    );
  }

  Widget _buildOtpField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Confirmation code',
        headerStyle: _labelStyle,
        onChanged: (value) => _confirmationCode = value,
      ),
    );
  }

  Widget _buildPayloadField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Payload',
        headerStyle: _labelStyle,
        onChanged: (value) => _payload = value,
      ),
    );
  }

  Widget _buildSignatureField() {
    return SizedBox(
      width: 300.0,
      child: TextBox(
        header: 'Signature',
        headerStyle: _labelStyle,
        onChanged: (value) => _signature = value,
        minLines: 3,
        maxLines: 3,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 300.0,
      child: FilledButton(
        child: Text(
          'SUBMIT',
          style: GoogleFonts.openSans(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          switch (_mode) {
            case AuthPageMode.SignUp:
              var action = SignUp(
                email: _email,
                username: _username,
                password: _password,
              );
              _accountBloc.dispatchAction(action);

              var state = await action.state;
              if (state is AuthenticationSucceeded) {
                setState(() {
                  _mode = AuthPageMode.Confirm;
                });
              }

              return;
            case AuthPageMode.SignIn:
              var action = SignIn(
                email: _email,
                password: _password,
              );
              _accountBloc.dispatchAction(action);

              var state = await action.state;
              if (state is AuthenticationSucceeded) {
                setState(() {
                  _mode = AuthPageMode.Superuser;
                });
              }

              return;
            case AuthPageMode.Confirm:
              var action = ConfirmEmail(
                email: _email,
                confirmationCode: _confirmationCode,
              );
              _accountBloc.dispatchAction(action);

              var state = await action.state;
              if (state is AuthenticationSucceeded) {
                setState(() {
                  _mode = AuthPageMode.SignIn;
                  _password = null;
                });
              }

              return;
            case AuthPageMode.Superuser:
              var action = GrantSuperuserPermissions(
                payload: _payload,
                signature: _signature,
              );
              _accountBloc.dispatchAction(action);

              var state = await action.state;
              if (state is AuthenticationSucceeded) {
                setState(() {
                  _mode = AuthPageMode.SignInAsAdmin;
                  _password = null;
                });
              }

              return;
            case AuthPageMode.SignInAsAdmin:
              var action = SignInAsAdmin(
                email: _email,
                password: _password,
              );
              _accountBloc.dispatchAction(action);

              var state = await action.state;
              if (state is AuthenticationSucceeded) {}

              return;
          }
        },
      ),
    );
  }

  List<Widget> _buildChildren() {
    switch (_mode) {
      case AuthPageMode.SignUp:
        return [
          SizedBox(height: 30.0),
          _buildEmailField(),
          SizedBox(height: 30.0),
          _buildUsernameField(),
          SizedBox(height: 30.0),
          _buildPasswordField(),
        ];
      case AuthPageMode.SignIn:
        return [
          SizedBox(height: 30.0),
          _buildEmailField(),
          SizedBox(height: 30.0),
          _buildPasswordField(),
        ];
      case AuthPageMode.Confirm:
        return [
          SizedBox(height: 30.0),
          _buildEmailField(),
          SizedBox(height: 30.0),
          _buildOtpField(),
        ];
      case AuthPageMode.SignInAsAdmin:
        return [
          SizedBox(height: 30.0),
          _buildEmailField(),
          SizedBox(height: 30.0),
          _buildPasswordField(),
        ];
      case AuthPageMode.Superuser:
        return [
          SizedBox(height: 30.0),
          _buildPayloadField(),
          SizedBox(height: 30.0),
          _buildSignatureField(),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        commandBar: DropDownButton(
          controller: _flyoutController,
          contentWidth: 150.0,
          leading: const Icon(FluentIcons.signin),
          items: [
            DropDownButtonItem(
              title: const Text('Sign-up'),
              onTap: () => setState(() {
                _mode = AuthPageMode.SignUp;
              }),
            ),
            DropDownButtonItem(
              title: const Text('Sign-in'),
              onTap: () => setState(() {
                _mode = AuthPageMode.SignIn;
              }),
            ),
            DropDownButtonItem(
              title: const Text('Confirm'),
              onTap: () => setState(() {
                _mode = AuthPageMode.Confirm;
              }),
            ),
            DropDownButtonItem(
              title: const Text('Admin'),
              onTap: () => setState(() {
                _mode = AuthPageMode.SignInAsAdmin;
              }),
            ),
            DropDownButtonItem(
              title: const Text('Superuser'),
              onTap: () => setState(() {
                _mode = AuthPageMode.Superuser;
              }),
            ),
          ],
        ),
      ),
      content: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: const [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _mode.name,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ..._buildChildren(),
                SizedBox(height: 30.0),
                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
