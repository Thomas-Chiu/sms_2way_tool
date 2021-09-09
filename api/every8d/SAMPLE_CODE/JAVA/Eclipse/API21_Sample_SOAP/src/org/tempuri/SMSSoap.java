/**
 * SMSSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public interface SMSSoap extends java.rmi.Remote {
    public java.lang.String getConnection(java.lang.String userID, java.lang.String password) throws java.rmi.RemoteException;
    public java.lang.String closeConnection(java.lang.String sessionKey) throws java.rmi.RemoteException;
    public java.lang.String sendSMS(java.lang.String sessionKey, java.lang.String subject, java.lang.String content, java.lang.String mobile, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String sendParamSMS(java.lang.String sessionKey, java.lang.String subject, java.lang.String contentXML, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String eraseBooking(java.lang.String sessionKey, java.lang.String batchID) throws java.rmi.RemoteException;
    public java.lang.String getDeliveryStatus(java.lang.String sessionKey, java.lang.String batchID, java.lang.String pageNo) throws java.rmi.RemoteException;
    public java.lang.String getCredit(java.lang.String sessionKey) throws java.rmi.RemoteException;
}
