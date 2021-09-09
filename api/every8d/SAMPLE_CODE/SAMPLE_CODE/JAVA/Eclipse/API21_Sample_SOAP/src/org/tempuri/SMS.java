/**
 * SMS.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public interface SMS extends javax.xml.rpc.Service {
    public java.lang.String getSMSSoapAddress();

    public org.tempuri.SMSSoap getSMSSoap() throws javax.xml.rpc.ServiceException;

    public org.tempuri.SMSSoap getSMSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getSMSSoap12Address();

    public org.tempuri.SMSSoap getSMSSoap12() throws javax.xml.rpc.ServiceException;

    public org.tempuri.SMSSoap getSMSSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
