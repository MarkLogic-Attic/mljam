package com.xqdev.jam;

/**
 * Utility class used for logging messages, typically errors and warnings.
 * It can output to System.err and/or a log file.  It may also timestamp
 * the message.
 */
public class Log {

  public static void log(String msg) {
    System.err.println(getPrefix() + msg);
  }

  public static void log(Throwable e) {
    System.err.println(getPrefix());
    e.printStackTrace(System.err);
  }

  public static void log(String msg, Throwable e) {
    System.err.println(getPrefix() + msg);
    e.printStackTrace(System.err);
  }

  protected static String getPrefix() {
    return "MLJAM: ";
    /*
    // This is useful for writing to a file
    StringBuffer buf = new StringBuffer();
    buf.append("[");
    buf.append(new Date().toString());
    buf.append("] ");
    return buf.toString();
    */
  }
}
