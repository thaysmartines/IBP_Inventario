import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Patrimonio.dart';

class NovoPatrimonioPage extends StatefulWidget {
  Patrimonio? patrimonio;
  NovoPatrimonioPage({Key? key, this.patrimonio}) : super(key: key);

  @override
  State<NovoPatrimonioPage> createState() => _NovoPatrimonioPageState();
}

class _NovoPatrimonioPageState extends State<NovoPatrimonioPage> {
  temPatrimonio() async {
    if (widget.patrimonio != null) {
      descricaoController.text = widget.patrimonio!.descricao;
      fornecedorController.text = widget.patrimonio!.fornecedor;
      codigoController.text = widget.patrimonio!.cod;
      setState(() {});
    }
  }

  pegarCodigo() async {
    if (widget.patrimonio == null) {
      Random random = Random();
      String randomNumber = '';

      for (int i = 0; i < 10; i++) {
        int digit = random.nextInt(10);
        randomNumber += digit.toString();
      }
      codigoController.text = (randomNumber).toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    temPatrimonio();
    super.initState();
    pegarCodigo();
  }

  final _formKey = GlobalKey<FormState>();
  final firestorePatrimonio =
      FirebaseFirestore.instance.collection('patrimonios');
  final codigoController = TextEditingController();
  final fornecedorController = TextEditingController();
  final numeroSerieController = TextEditingController();
  final localizacaoController = TextEditingController();
  final descricaoController = TextEditingController();
  final empresaController = TextEditingController();
  final responsavelController = TextEditingController();
  final centraldecustoController = TextEditingController();
  final grupodebemController = TextEditingController();
  final valorController = TextEditingController();
  final dataAquisicaoController = TextEditingController();
  final dataGarantiaController = TextEditingController();
  final observacaoController = TextEditingController();
  final depreciacaoController = TextEditingController();
  final vidaController = TextEditingController();
  DateTime? dataAquisicao;
  DateTime? dataGarantia;
  final empresas = <String>[
    'Pedro',
    'João',
    'Paulo',
    'Lucas',
    'Matheus',
  ];
  final localizacoes = <String>[
    'Galpão',
    'Loja Principal',
    'Estoque Principal',
    'Diversos',
  ];
  final gruposdebens = <String>[
    'Informática',
    'Maquinário',
    'Veículos',
    'Moveis Externos',
    'Diversos',
  ];
  final fornecedores = <String>[
    'Dell',
    'LG',
    'Paroupas',
    'Samsung',
    'Warrior',
  ];
  final responsaveis = <String>[
    'João',
    'João',
    'Paulo',
    'Lucas',
    'Matheus',
  ];
  final centraisdecustos = <String>[
    'Administrativo',
    'Fábrica',
    'Filial 1',
    'Diversos',
  ];
  final vidas = <String>[
    '1 ano',
    '2 anos',
    '3 anos',
    '4 anos',
    '5 anos',
    '6 anos',
    '7 anos',
    '8 anos',
    '9 anos',
    '10 anos',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patrimonio == null
            ? 'Cadastra Patrimônio'
            : 'Editar ${widget.patrimonio!.descricao}'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 12, bottom: 62),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        controller: codigoController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o código';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Código'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: numeroSerieController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o número de série';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Número de série'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: descricaoController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe uma descrição';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Descrição'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: grupodebemController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o grupo do bem';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Grupo de bens'),
                        ),
                        onTap: () {
                          _showDialog(
                            context: context,
                            lista: gruposdebens,
                            controller: grupodebemController,
                          );
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: empresaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a empresa';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Empresa'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: centraldecustoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a central de custo';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Centro de Custo'),
                        ),
                        onTap: () {
                          _showDialog(
                            context: context,
                            lista: centraisdecustos,
                            controller: centraldecustoController,
                          );
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: localizacaoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a localização';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Localização'),
                        ),
                        onTap: () {
                          _showDialog(
                              context: context,
                              lista: localizacoes,
                              controller: localizacaoController);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: fornecedorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o fornecedor';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Fornecedor'),
                  ),
                  onTap: () {
                    _showDialog(
                        context: context,
                        lista: fornecedores,
                        controller: fornecedorController);
                  },
                  readOnly: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: dataAquisicaoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a data de aquisição';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Data de aquisição'),
                        ),
                        onTap: () async {
                          final DateTime? data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (data != null && data != dataAquisicao) {
                            setState(() {
                              dataAquisicaoController.text =
                                  '${data.day}/${data.month}/${data.year}';
                            });
                          }
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: dataGarantiaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a data de garantia';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Data de garantia'),
                        ),
                        onTap: () async {
                          final DateTime? data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (data != null && data != dataAquisicao) {
                            setState(() {
                              dataGarantiaController.text =
                                  '${data.day}/${data.month}/${data.year}';
                            });
                          }
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: responsavelController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o responsável';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Responsável'),
                  ),
                  onTap: () {
                    _showDialog(
                        context: context,
                        lista: responsaveis,
                        controller: responsavelController);
                  },
                  readOnly: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: valorController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o valor do bem';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Valor do bem'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: vidaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a vida utíl';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Vida utíl'),
                        ),
                        onTap: () {
                          _showDialog(
                              context: context,
                              lista: vidas,
                              controller: vidaController);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: observacaoController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe algumas informações';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Observações'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Patrimonio patrimonio = Patrimonio(
                      cod: codigoController.text,
                      nSerie: numeroSerieController.text,
                      descricao: descricaoController.text,
                      filial: centraldecustoController.text,
                      gBens: grupodebemController.text,
                      empresa: empresaController.text,
                      cCusto: centraldecustoController.text,
                      localizacao: localizacaoController.text,
                      fornecedor: fornecedorController.text,
                      dataAquisicao: dataAquisicaoController.text,
                      dataGarantia: dataGarantiaController.text,
                      responsavel: responsavelController.text,
                      valor: valorController.text,
                      vidaUtil: vidaController.text,
                      depreciacao: depreciacaoController.text,
                      observacoes: observacaoController.text,
                    );

                    firestorePatrimonio
                        .doc(patrimonio.cod)
                        .set(patrimonio.toJson())
                        .then((value) {
                      Navigator.of(context).pop();
                    }).catchError(
                      (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Não foi possível cadastrar o Patrimonio'),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Text(widget.patrimonio == null ? 'Cadastrar' : 'Salvar'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(
      {required BuildContext context,
      required List<String> lista,
      required TextEditingController controller}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escolha uma fruta'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final item = lista[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    controller.text = item;
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            )
          ],
        );
      },
    );
  }
}
