import 'package:flutter/material.dart';

import '../../../../data/models/employee.dart';
import '../../../../data/models/cash_opening.dart';

import '../../../../data/repositories/employee_repository.dart';
import '../../../../data/repositories/cash_opening_repository.dart';

import '../../../../routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() =>
      _LoginFormState();
}

class _LoginFormState
    extends State<LoginForm> {
  final TextEditingController
  _userController =
      TextEditingController();

  final TextEditingController
  _pinController =
      TextEditingController();

  final EmployeeRepository
  _employeeRepository =
      EmployeeRepository();

  final CashOpeningRepository
  _cashOpeningRepository =
      CashOpeningRepository();

  Future<void> _login() async {
    final username =
        _userController.text.trim();

    final pin =
        _pinController.text.trim();

    // Validar campos
    if (username.isEmpty ||
        pin.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Ingresa usuario y contraseña",
          ),
        ),
      );

      return;
    }

    try {
      // Buscar empleado
      final employee =
          await _employeeRepository.login(
        username,
        pin,
      );

      if (employee == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Usuario o contraseña incorrectos",
            ),
          ),
        );

        return;
      }

      // Revisar si ya tiene apertura activa
      final cashOpeningActive =
          await _cashOpeningRepository
              .obtenerAperturaActivaPorEmpleado(
        employee.id!,
      );

      late CashOpening apertura;

      // Si NO tiene apertura activa -> crearla
      if (cashOpeningActive == null) {
        final newCashOpening =
            CashOpening(
          id: null,

          empleadoId: employee.id!,

          fechaHoraApertura:
              DateTime.now()
                  .toIso8601String(),
        );

        await _cashOpeningRepository
            .insertar(newCashOpening);

        // Volver a obtener la apertura para tener el ID generado
        apertura = (await _cashOpeningRepository
            .obtenerAperturaActivaPorEmpleado(employee.id!))!;
      } else {
        apertura = cashOpeningActive;
      }

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.employeeMenu,
        arguments: {
          'employee': employee,
          'apertura': apertura,
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Error al iniciar sesión: $e",
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _pinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],

      child: Center(
        child: Container(
          width: 350,

          padding:
              const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(12),

            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
              ),
            ],
          ),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              const Text(
                "Bienvenido",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Usuario
              TextField(
                controller:
                    _userController,

                decoration:
                    InputDecoration(
                  hintText: "Usuario",

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // PIN
              TextField(
                controller:
                    _pinController,

                obscureText: true,

                keyboardType:
                    TextInputType.number,

                decoration:
                    InputDecoration(
                  hintText:
                      "PIN / Contraseña",

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: _login,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFFE32E8F,
                    ),

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),

                  child: const Text(
                    "Iniciar sesión",

                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}