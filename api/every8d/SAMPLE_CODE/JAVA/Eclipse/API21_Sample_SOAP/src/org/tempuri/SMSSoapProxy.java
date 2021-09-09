package org.tempuri;

public class SMSSoapProxy implements org.tempuri.SMSSoap {
  private String _endpoint = null;
  private org.tempuri.SMSSoap sMSSoap = null;
  
  public SMSSoapProxy() {
    _initSMSSoapProxy();
  }
  
  public SMSSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initSMSSoapProxy();
  }
  
  private void _initSMSSoapProxy() {
    try {
      sMSSoap = (new org.tempuri.SMSLocator()).getSMSSoap();
      if (sMSSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)sMSSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)sMSSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (sMSSoap != null)
      ((javax.xml.rpc.Stub)sMSSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.tempuri.SMSSoap getSMSSoap() {
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap;
  }
  
  public java.lang.String getConnection(java.lang.String userID, java.lang.String password) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.getConnection(userID, password);
  }
  
  public java.lang.String closeConnection(java.lang.String sessionKey) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.closeConnection(sessionKey);
  }
  
  public java.lang.String sendSMS(java.lang.String sessionKey, java.lang.String subject, java.lang.String content, java.lang.String mobile, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.sendSMS(sessionKey, subject, content, mobile, sendTime);
  }
  
  public java.lang.String sendParamSMS(java.lang.String sessionKey, java.lang.String subject, java.lang.String contentXML, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.sendParamSMS(sessionKey, subject, contentXML, sendTime);
  }
  
  public java.lang.String eraseBooking(java.lang.String sessionKey, java.lang.String batchID) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.eraseBooking(sessionKey, batchID);
  }
  
  public java.lang.String getDeliveryStatus(java.lang.String sessionKey, java.lang.String batchID, java.lang.String pageNo) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.getDeliveryStatus(sessionKey, batchID, pageNo);
  }
  
  public java.lang.String getCredit(java.lang.String sessionKey) throws java.rmi.RemoteException{
    if (sMSSoap == null)
      _initSMSSoapProxy();
    return sMSSoap.getCredit(sessionKey);
  }
  
  
}