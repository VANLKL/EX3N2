<%@ page language="java" import="java.io.*" %>
<%!
  int count = 0;
  String dbPath;

  public void jspInit() {
    try {
      // 设置文件路径（保存在应用根目录下）
      dbPath = getServletContext().getRealPath("/counter.txt");

      // 从文件中读取计数器值
      File file = new File(dbPath);
      if (file.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
          String line = reader.readLine();
          if (line != null) {
            count = Integer.parseInt(line);
          }
        }
      } else {
        // 如果文件不存在，初始化为0（count默认为0）
        file.createNewFile(); // 自动创建空文件
      }
    } catch (Exception e) {
      log("Error loading persistent counter", e);
    }
  }
%>

<%-- 页面内容 --%>
<html><body>
<% count++; %>
Welcome! You are the <%= count %>th visitor(s).
</body></html>

<%!
  public void jspDestroy() {
    try {
      // 将计数器值写入文件
      try (PrintWriter writer = new PrintWriter(new FileOutputStream(dbPath))) {
        writer.println(count);
      }
    } catch (Exception e) {
      log("Error storing persistent counter", e);
    }
  }
%>