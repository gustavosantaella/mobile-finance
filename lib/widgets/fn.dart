
import 'package:flutter/material.dart';
import 'package:wafi/helpers/fn/main.dart';

dropdownWalletCurrencies(List wallets, dynamic value, Function onChanged){
   return  DropdownButton(
                value: value,
                items: wallets
                    .map((wallet) => DropdownMenuItem(
                          value: wallet['currency'],
                          child: Text(wallet['currency']),
                        ))
                    .toList(),
                onChanged:(value){
                  Map w = getWalletByCurrency(value.toString(), wallets);
                  onChanged(w);
                });
          
}