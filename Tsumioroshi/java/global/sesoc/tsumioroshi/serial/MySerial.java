package global.sesoc.tsumioroshi.serial;

import java.io.BufferedInputStream;
import java.io.BufferedReader;

import jssc.SerialPort;
import jssc.SerialPortException;
import jssc.SerialPortList;

public class MySerial extends Thread{
   
   public  SerialPort serial=null;
   private String rxPac="";
   private  String rxData="";
   private String final_RxData="";
   private  String txPac="";
   private boolean sw=false;
   private boolean startSw=false;
   private long finalTime=0;
   private String pre_TxPac="";
   String portName=null;
   
   private short checksum=0;
   //private int count=0;
   
   public MySerial() {
      this.setName("mySerial");
   }
   
   //기본 포트 열고 닫기등 기본 설정
   //포트 찾아서 설정
   public boolean setMyPort() {
      
      
      String[] portNames = SerialPortList.getPortNames();
      for (int i = 0; i < portNames.length; i++) {
         System.out.println(portNames[i]);
         portName=portNames[i];
      }
      System.out.println(portName);
      if(portName==null) return false;
      
      serial = new SerialPort(portName);
      return true;
   }
   //포트 열고 기본 설정
   public void openMyPort() {
      
      if(serial!=null && !serial.isOpened()) {
         try {
            serial.openPort();
            serial.setParams(SerialPort.BAUDRATE_115200,
                  SerialPort.DATABITS_8,
                  SerialPort.STOPBITS_1,
                  SerialPort.PARITY_NONE);
            System.out.println("buffer: "+serial.getInputBufferBytesCount());
            flushBuffer();
         } catch (SerialPortException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
   }
   //통신 포트를 닫음
   public synchronized void closeMyPort() {
      if(serial.isOpened()) {
         try {
            serial.closePort();
         } catch (SerialPortException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
   }
   
   //Tx관련 함수 --------------------------------------------------------------------------------------------------------------------------------------------------
   //Tx패킷을 생성해주는 함수
   public synchronized String createTxPac(String states, int txDataLength) {
      String txPac=">PA"+txDataLength+states+"/";
      return txPac;
   }
   public synchronized String createTxPac(String states, int txDataLength, String txData) {
      String txPac=">PA"+txDataLength+states;
      int calChecksum=0;
      byte checksum=0;
      for(int i=0;i<txData.getBytes().length;i++) {
         txPac+=txData.getBytes()[i]; 
         calChecksum+=txData.getBytes()[i];
      }
      checksum=(byte)(calChecksum&0xFF);
      checksum=(byte)(0x100-checksum);
      txPac+=checksum;
      txPac+="/";
      return txPac;
   }
   //실제 Tx패킷을 전송하는 함수
   public synchronized void sendTxPac(String txPac) throws SerialPortException, InterruptedException {
      System.out.println(txPac);
      if(!txPac.equals(""))serial.writeBytes(txPac.getBytes());
      Thread.sleep(500);
   }
   //NC를 위해 이전 명령어를 저장해주는 함수
   

   //Rx관련함수------------------------------------------------------------------------------------------------------------------------------------------------------
   //들어온 패킷을 해석해서 분류할 때 사용
   public synchronized void distingishPac(byte[] read) throws SerialPortException, InterruptedException {

      rxData="";
      for(int i=0;i<read.length;i++) {
         System.out.print(read[i]+"/");
         System.out.print("char: "+(char)read[i]+"/");
         rxPac+=(char)read[i];
      }
      System.out.print("len: "+rxPac.length()+"/");
      System.out.println(rxPac);
      if(!rxPac.contains("/")) return;
      if(rxPac.trim().length()>5) {
         if(rxPac.charAt(0)=='<') {
            System.out.println(1);

            if(rxPac.charAt(1)=='A') {
               System.out.println(2);

               if(rxPac.charAt(2)=='P') {
                  System.out.println(3);

                  System.out.println(rxPac);
                  String states=rxPac.substring(4, 6);
                  System.out.println(states);
                  System.out.println(startSw);

                  //System.out.println("OP");
                  if(states.equals("OP")) {//통신을 열 경우
                     System.out.println("OP");
                     txPac=createTxPac("OP",0);
                     pre_TxPac=txPac;
                     sendTxPac(txPac);
                     txPac="";
                     startSw=true;
                     flushBuffer();

                     return;
                  }
                  if(startSw) {
                     switch(states) {
                     case "CL":   //통신을 닫을 경우
                        txPac="";
                        System.out.println("close");
                        sw=true;
                        return;
                     case "DA":   //NFC태그를 받아오는 경우
                        rxPac=rxPac.substring(3);
                        if(!findRxData()) break;
                        txPac=createTxPac("SU",0);
                        pre_TxPac=txPac;
                        sendTxPac(txPac);
                        System.out.println("su");
                        flushBuffer();
                        return;//here
                     case "SU":
                        txPac="";
                        System.out.println("SU");
                        return;
                     case "NC":   //받지 못하는 경우
                        sendTxPac(pre_TxPac);
                        break;
                     }
                  }
               }//P
            }//A
         }//<
      }
      txPac=createTxPac("NC", 0);
      sendTxPac(txPac);
      return;
   }
   //들어온 Rx패킷 내의 실제 DATA를 해석하고 체크섬을 확인하는 함수
   public boolean findRxData() {
      System.out.println("OK");
      int rxDataLen=Integer.parseInt(rxPac.substring(0,1))*2;
      System.out.println(rxDataLen+", "+rxPac.length());
      if(rxPac.length()<(3+rxDataLen)) return false;
      for(int i=3;i<(3+rxDataLen);i+=2) {
         rxData+=rxPac.charAt(i);
         rxData+=rxPac.charAt(i+1);
         checksum+=calcByte(rxPac.getBytes()[i],rxPac.getBytes()[i+1]);
      }
      System.out.print("rxData: "+rxData);
      System.out.printf("/1checksum: %x", (checksum&0xff));
      short getChecksum=calcByte(rxPac.getBytes()[rxPac.length()-4],rxPac.getBytes()[rxPac.length()-3]);
      System.out.printf("/2checksum: %x\n", ((~getChecksum)&0xff));
      if((checksum&0xff)!=((~getChecksum)&0xff)) return false;
      final_RxData=rxData;
      System.out.println(final_RxData);
      return true;
   }
   //들어온 데이터를 바이트 단위로 바꾸어 주는 함수 
   public byte calcByte(byte letter1, byte letter2) {
      byte result=0;
      result=(byte) ((StringToHex(letter1)<<4)|StringToHex(letter2));
      return result;
   }
   //들어온 문자를 16진수로 바꾸어주는 함수
   public byte StringToHex(byte letter) {
      switch(letter) {
      case 48: return 0x00;
      case 49: return 0x01;
      case 50: return 0x02;
      case 51: return 0x03;
      case 52: return 0x04;
      case 53: return 0x05;
      case 54: return 0x06;
      case 55: return 0x07;
      case 56: return 0x08;
      case 57: return 0x09;
      case 97: case 65: return 0x0a;
      case 98: case 66: return 0x0b;
      case 99: case 67: return 0x0c;
      case 100: case 68: return 0x0d;
      case 101: case 69: return 0x0e;
      case 102: case 70: return 0x0f;
      }
      return 0x00;
   }
   
   //쓰레드외부에서 제어할떄 사용할함수
   //Rx데이터를 설정해줌(비울때 쓸 예정)
   public synchronized void setRxData(String rxData) {
      this.rxData=rxData;
   }
   //Rx데이터를 받아올때 사용
   public synchronized String getRxData() {
      return this.rxData;
   }
   public synchronized void setFinal_RxData(String final_RxData) {
      this.final_RxData=final_RxData;
   }
   //Rx데이터를 받아올때 사용
   public synchronized String getFinal_RxData() {
      return this.final_RxData;
   }
   //편의 함수----------------------------------------------------------------------------------------------------------
   //통신 쓰레드를 종료하는 함수
   public void finishCom() {
      this.sw= true;
   }
   //NFC태그로 찾은 아이템 정보전송시에 사용할 함수
   public void sendProduct(String data) {
      txPac=createTxPac("PR",data.length(), data);
      try {
         sendTxPac(txPac);
      } catch (SerialPortException | InterruptedException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
   }
   //강제적으로 오래 돌릴경우 사용할 함수
   public synchronized void setFinalTime(long finalTime) {
      this.finalTime = finalTime;
   }
   //통신을 종료할 때 사용할 함수
   public  void sendCL() {
      
      try {
         Thread.sleep(5000);
         if(portName==null)return;
         txPac=createTxPac("CL",0);
         pre_TxPac=txPac;
         sendTxPac(txPac);
         System.out.println("goCl");
      } catch (SerialPortException | InterruptedException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
   }
   //버퍼를 비워주는 함수
   public void flushBuffer() {
      try {
         if(serial.getInputBufferBytesCount()>0) {   
            serial.readBytes();
            System.out.println("buffer: "+serial.getInputBufferBytesCount());
         }
      } catch (SerialPortException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
   }
   
   //실제 통신 부분
   public void run() {
      //System.out.println("run");
      finalTime=System.currentTimeMillis()/1000+10;
      checksum=0;
      rxPac="";
      sw=false;
      try {
         while (true) {
            byte[] read = serial.readBytes();
            //System.out.println(read);
            
            if(read != null && read.length > 0) {
               distingishPac(read);
               finalTime=System.currentTimeMillis()/1000+10;
            }
            
            if(rxPac.contains("/")) {
               System.out.println(4);
               rxPac="";
               checksum=0;
            }
            
            if(System.currentTimeMillis()/1000>finalTime) {
               System.out.println("sw==true");
               sw=true;
            }
            
            if(sw) break;
         }
         this.closeMyPort();//here;
      } catch (SerialPortException | InterruptedException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

   }
   
   
   
}