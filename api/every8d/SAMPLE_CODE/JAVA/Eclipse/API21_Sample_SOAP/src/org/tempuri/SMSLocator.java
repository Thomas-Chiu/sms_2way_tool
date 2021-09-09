/**
 * SMSLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public class SMSLocator extends org.apache.axis.client.Service implements org.tempuri.SMS {

    public SMSLocator() {
    }


    public SMSLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SMSLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SMSSoap
    private java.lang.String SMSSoap_address = "http://api.every8d.com/API21/SOAP/SMS.asmx";

    public java.lang.String getSMSSoapAddress() {
        return SMSSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SMSSoapWSDDServiceName = "SMSSoap";

    public java.lang.String getSMSSoapWSDDServiceName() {
        return SMSSoapWSDDServiceName;
    }

    public void setSMSSoapWSDDServiceName(java.lang.String name) {
        SMSSoapWSDDServiceName = name;
    }

    public org.tempuri.SMSSoap getSMSSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SMSSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSMSSoap(endpoint);
    }

    public org.tempuri.SMSSoap getSMSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            org.tempuri.SMSSoapStub _stub = new org.tempuri.SMSSoapStub(portAddress, this);
            _stub.setPortName(getSMSSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSMSSoapEndpointAddress(java.lang.String address) {
        SMSSoap_address = address;
    }


    // Use to get a proxy class for SMSSoap12
    private java.lang.String SMSSoap12_address = "http://api.every8d.com/API21/SOAP/SMS.asmx";

    public java.lang.String getSMSSoap12Address() {
        return SMSSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SMSSoap12WSDDServiceName = "SMSSoap12";

    public java.lang.String getSMSSoap12WSDDServiceName() {
        return SMSSoap12WSDDServiceName;
    }

    public void setSMSSoap12WSDDServiceName(java.lang.String name) {
        SMSSoap12WSDDServiceName = name;
    }

    public org.tempuri.SMSSoap getSMSSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SMSSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSMSSoap12(endpoint);
    }

    public org.tempuri.SMSSoap getSMSSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            org.tempuri.SMSSoap12Stub _stub = new org.tempuri.SMSSoap12Stub(portAddress, this);
            _stub.setPortName(getSMSSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSMSSoap12EndpointAddress(java.lang.String address) {
        SMSSoap12_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (org.tempuri.SMSSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                org.tempuri.SMSSoapStub _stub = new org.tempuri.SMSSoapStub(new java.net.URL(SMSSoap_address), this);
                _stub.setPortName(getSMSSoapWSDDServiceName());
                return _stub;
            }
            if (org.tempuri.SMSSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                org.tempuri.SMSSoap12Stub _stub = new org.tempuri.SMSSoap12Stub(new java.net.URL(SMSSoap12_address), this);
                _stub.setPortName(getSMSSoap12WSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("SMSSoap".equals(inputPortName)) {
            return getSMSSoap();
        }
        else if ("SMSSoap12".equals(inputPortName)) {
            return getSMSSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "SMS");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SMSSoap"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SMSSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SMSSoap".equals(portName)) {
            setSMSSoapEndpointAddress(address);
        }
        else 
if ("SMSSoap12".equals(portName)) {
            setSMSSoap12EndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
