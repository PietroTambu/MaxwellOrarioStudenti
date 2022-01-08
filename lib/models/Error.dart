class ErrorCodes {
  List badRequest;
  List deviceOffline;
  List serverOffline;
  List internalError;

  ErrorCodes({
    required this.badRequest,
    required this.deviceOffline,
    required this.serverOffline,
    required this.internalError,
  });

  factory ErrorCodes.getErrorCodes() {
    return ErrorCodes(
        badRequest: [
          '101',
          'Bad Request',
          'La richiesta al Server non è andata a buon fine; riprova più tardi o prova a cambiare connessione internet'
        ],
        deviceOffline: [
          '102',
          'Device Offline',
          'Sembra che il tuo dispositivo non sia connesso ad internet; l\'applicazione deve scaricare dei file importanti. Connettiti ad internet e riprova'
        ],
        serverOffline: [
          '103',
          'Server Offline',
          'Al momento il server è irraggiungibile; si prega di riprovare più tardi'
        ],
        internalError: [
          '104',
          'Internal Error',
          'Si è verificato un errore interno nell\'applicazione. Prova a riavviare l\'applicazione assicurandoti di non averla attiva in background'
        ],
    );
  }
}
