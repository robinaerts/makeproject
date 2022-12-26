using System;
using System.IO;
using System.Diagnostics;
using System.Windows;
using System.Windows.Controls;

namespace Robyte_Dev
{
    /// <summary>
    /// Interaction logic for SubProject.xaml
    /// </summary>
    public partial class SubProject : Window
    {
        public string projectDir { get; set; }

        public SubProject()
        {
            InitializeComponent();
        }

        public void getSubProjects(string path)
        {
            string[] projectDirPaths = Directory.GetDirectories(path);
            foreach (string projectDir in projectDirPaths)
            {
                int startIndex = projectDir.LastIndexOf('\\') + 1;
                string projectType = projectDir.Substring(startIndex);
                Button button = new() { Content = projectType };
                button.Click += OpenProject_Click;
                button.DataContext = new string[] { projectDir, projectType};
                button.Width = 200;
                button.Height = 100;
                subprojects.Children.Add(button);
            }

        }
        private void OpenProject_Click(object sender, RoutedEventArgs e)
        {
            Button clickedButton = sender as Button;
            string[] projectProperties = clickedButton.DataContext as String[];
            string dir = projectProperties[0];
            switch (projectProperties[1].Substring(projectProperties[1].LastIndexOf('_') + 1))
            {
                case "basicweb":
                    openBasicWeb(dir);
                    break;
                case "web":
                    openWeb(dir);
                    break;
                case "webapi":
                    openWeb(dir);
                    break;
                case "android":
                    break;
                case "ios":
                    break;
                case "csharp":
                    openCsharp(dir);
                    break;
                case "nodeconsole":
                    openNodeConsole(dir);
                    break;
            }
        }

        private void openWeb(string dir)
        {
            string command = "/k cd " + dir + " && code . && npm run dev";
            Process.Start("explorer.exe", dir);
            Process.Start("cmd.exe", command);
        }

        private void openBasicWeb(string dir)
        {
            string command = "/k cd " + dir + " && index.html";
            Process.Start("explorer.exe", dir);
            Process.Start("cmd.exe", command);
        }

        private void openNodeConsole(string dir)
        {
            string command = "/k cd " + dir + " && code .";
            Process.Start("explorer.exe", dir);
            Process.Start("cmd.exe", command);
        }

        private void openCsharp(string dir)
        {
            string command = "/k cd " + dir + " && FOR %F in (*.sln) DO START %F";
            Process.Start("explorer.exe", dir);
            Process.Start("cmd.exe", command);
        }

        private void HomeBtn_Click(object sender, RoutedEventArgs e)
        {
            MainWindow home = new MainWindow();
            home.Show();
            this.Close();
        }

        private void CreateProject_Click(object sender, RoutedEventArgs e)
        {
            CreateProject cp = new CreateProject();
            cp.Show();
            this.Close();
        }
    }
}
