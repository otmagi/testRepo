<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>好友列表</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>好友列表</h1>
    <table>
        <thead>
        <tr>
            <th>好友姓名</th>
            <th>在线状态</th>
        </tr>
        </thead>
        <tbody>
        <%
            String currentStudentId = session.getAttribute("id").toString();
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mybook", "root", "root");

                // 获取当前学生的好友列表
                String getFriendsQuery = "SELECT friends FROM message_info WHERE id = ?";
                pstmt = conn.prepareStatement(getFriendsQuery);
                pstmt.setString(1, currentStudentId);
                rs = pstmt.executeQuery();

                String friends = "";
                if (rs.next()) {
                    friends = rs.getString("friends"); // 获取好友列表
                }

                if (friends != null && !friends.isEmpty()) {
                    String[] friendIds = friends.split(","); // 将好友ID分隔

                    for (String friendId : friendIds) {
                        // 查询每个好友的详细信息
                        String friendQuery = "SELECT name, is_online FROM message_info WHERE id = ?";
                        pstmt = conn.prepareStatement(friendQuery);
                        pstmt.setString(1, friendId);
                        ResultSet friendResult = pstmt.executeQuery();

                        if (friendResult.next()) {
                            String friendName = friendResult.getString("name");
                            boolean isOnline = friendResult.getBoolean("is_online");

                            // 输出好友的姓名和在线状态
                            out.println("<tr>");
                            out.println("<td>" + friendName + "</td>");
                            out.println("<td>" + (isOnline ? "在线" : "离线") + "</td>");
                            out.println("</tr>");
                        }
                    }
                } else {
                    out.println("<tr><td colspan='2'>你还没有好友</td></tr>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        </tbody>
    </table>
    <button onclick="window.location.href='student_homepage.jsp'">返回主页</button>
</div>
</body>
</html>
