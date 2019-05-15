import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class CurrencyFormat {
  currency(double data) {
    FlutterMoneyFormatter fm = new FlutterMoneyFormatter(
        amount: data,
        settings: MoneyFormatterSettings(
            symbol: 'Rp',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            compactFormatType: CompactFormatType.short
        )
    );
    return fm.output.withoutFractionDigits;
  }
}