## Getting Started

Welcome to the VS Code Java world. Here is a guideline to help you get started to write Java code in Visual Studio Code.

## Folder Structure

The workspace contains two folders by default, where:

- `src`: the folder to maintain sources
- `lib`: the folder to maintain dependencies

Meanwhile, the compiled output files will be generated in the `bin` folder by default.

> If you want to customize the folder structure, open `.vscode/settings.json` and update the related settings there.

## Dependency Management

The `JAVA PROJECTS` view allows you to manage your dependencies. More details can be found [here](https://github.com/microsoft/vscode-java-dependency#manage-dependencies).

## run project
Bước 2: Mở Command Prompt/PowerShell
Nhấn Win + R → gõ cmd hoặc powershell → Enter
Chuyển đến thư mục project: 
cd "D:\YEAR2 ĐAN\LTWEB\PetProject"

Bước 3: Biên dịch Java code
# Tạo thư mục tạm để biên dịch
mkdir C:\tmp\pet_src
xcopy "PetProject\src\main\java\*" "C:\tmp\pet_src\" /E /I

# Biên dịch Java files
cd C:\tmp\pet_src
javac -encoding UTF-8 -cp "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\lib\*" -d "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\PetProject\WEB-INF\classes" com\petweb\model\Pet.java com\petweb\servlet\PetDetailServlet.java
cd "D:\YEAR2 ĐAN\LTWEB\PetProject"

Bước 4: Deploy webapp
# Xóa deploy cũ (nếu có)
rmdir /S "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\PetProject"

# Tạo thư mục mới và copy webapp
mkdir "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\PetProject"
xcopy "PetProject\src\main\webapp\*" "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\PetProject\" /E /I

# Tạo thư mục classes
mkdir "C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\webapps\PetProject\WEB-INF\classes"
Bước 5: Khởi động Tomcat
"C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\bin\startup.bat"

Bước 6: Kiểm tra kết quả
Mở trình duyệt và truy cập:
http://localhost:8080/PetProject/pet-detail (servlet)
http://localhost:8080/PetProject/petDetail.jsp (JSP trực tiếp)

Bước 7: Dừng Tomcat (khi cần)
"C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\bin\shutdown.bat"

Cách sử dụng:
Trong PowerShell:
cd "D:\YEAR2 ĐAN\LTWEB\PetProject\PetProject"
.\start-tomcat.bat    # Khởi động
.\stop-tomcat.bat     # Dừng
.\restart-tomcat.bat  # Khởi động lại
Trong Command Prompt:
cd "D:\YEAR2 ĐAN\LTWEB\PetProject\PetProject"
start-tomcat.bat      # Khởi động
stop-tomcat.bat       # Dừng
restart-tomcat.bat    # Khởi động lại
Double-click trực tiếp:
Mở File Explorer → vào thư mục project → double-click file .bat
Nếu vẫn không dừng được:
Mở Task Manager (Ctrl+Shift+Esc)
Tìm process java.exe hoặc tomcat
Right-click → End Task