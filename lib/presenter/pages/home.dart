import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/e_trashes/e_trashes_bloc.dart';
import '../view_models/e_trashes_view_model.dart';
import '../view_models/tflite_view_model.dart';
import '../widgets/e_trash_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tflite = Modular.get<TFLiteViewModel>();
  final trashViewModel = Modular.get<ETrashesViewModel>();

  bool glitchFlag = false;

  @override
  void initState() {
    trashViewModel.fetchAllETrashes();

    tflite.loadModel().then((_) {
      if (mounted) {
        tflite.loadLabels(context).then((loadedLabels) => setState(() {
              tflite.labels = loadedLabels;
              if (kDebugMode) {
                print(tflite.labels);
              }
            }));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tflite.interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            GestureDetector(
              onDoubleTap: () => setState(() {
                glitchFlag = !glitchFlag;
              }),
              child: const Text(
                'E-Waste Detector App',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    fontFamily: 'SofiaSans',
                    fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => tflite.pickImageFromCamera(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Tire uma foto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SofiaSans',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => tflite.pickImageFromGallery(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Enviar uma foto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SofiaSans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (!glitchFlag)
              BlocBuilder(
                bloc: trashViewModel.bloc,
                builder: (_, state) {
                  if (state is ETrashesErrorState) {
                    return const Center(
                      child: Text('Ocorreu um erro'),
                    );
                  }

                  if (state is ETrashesSuccessState) {
                    final trashes = state.eTrashes.trashes;

                    if (trashes.isEmpty) {
                      return const Text('Nenhum lixo cadastrado.');
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async =>
                            trashViewModel.fetchAllETrashes(),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: trashes.length,
                          padding: const EdgeInsets.only(bottom: 20),
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, index) {
                            final trash = trashes[index];

                            return ETrashCard(
                              eTrash: trash,
                              onCardTap: () => Modular.to.pushNamed(
                                '/monitoring',
                                arguments: trash,
                              ),
                              onDeleteTap: () => trashViewModel.deleteTrash(
                                trashId: trash.id,
                                trashFilePath: trash.filePath ?? '',
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
          ],
        ),
      ),
    );
  }
}
