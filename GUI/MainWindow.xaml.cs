using System.IO;
using System.Windows;
using System.Windows.Forms;

namespace Robyte_Dev
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static string project_path;
        public static string[] projectDirPaths;
        public static string programData = "C:\\ProgramData\\Robyte";
        public MainWindow()
        {
            InitializeComponent();
            getProjectPath();
        }

        public void getProjects(string path)
        {
            projectDirPaths = Directory.GetDirectories(path);
            foreach (string projectDir in projectDirPaths)
            {
                int startIndex = projectDir.LastIndexOf('\\') + 1;
                System.Windows.Controls.Button button = new() { Content = projectDir.Substring(startIndex) };
                button.Click += Project_Click;
                button.DataContext = projectDir;
                button.Width = 200;
                button.Height = 100;
                projects.Children.Add(button);
            }
        }

        private void Project_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Controls.Button clickedButton = sender as System.Windows.Controls.Button;
            SubProject subproject = new SubProject();
            subproject.projectDir = clickedButton.DataContext.ToString();
            subproject.projectname.Content = subproject.projectDir.Substring(subproject.projectDir.LastIndexOf('\\') + 1);
            subproject.getSubProjects(subproject.projectDir);
            subproject.Show();
            this.Close();
        }

        private void CreateProject_Click(object sender, RoutedEventArgs e)
        {
            CreateProject cp = new CreateProject();
            cp.Show();
            this.Close();
        }

        private void getProjectPath()
        {
            string pathFileContent = "";
            try
            {
                pathFileContent = File.ReadAllText(programData + "\\projectPath.txt");
                project_path = pathFileContent;
            }
            catch
            {
                Directory.CreateDirectory(programData);
                var projectPathFile = File.Create(programData + "\\projectPath.txt");
                projectPathFile.Close();
            }
            if (pathFileContent == "")
            {
                changeProjectPath();
            }
            getProjects(project_path);
        }

        public void changeProjectPath()
        {
            FolderBrowserDialog dialog = new FolderBrowserDialog();
            var dialogResult = dialog.ShowDialog();
            if (dialogResult.ToString() == "OK")
            {
                File.WriteAllText(programData + "\\projectPath.txt", dialog.SelectedPath);
                project_path = dialog.SelectedPath;
            } else
            {
                System.Windows.MessageBox.Show("You need to select a folder!");
                System.Windows.Application.Current.Shutdown();
            }

        }

        private void ChangeProjectFolder_Click(object sender, RoutedEventArgs e)
        {
            changeProjectPath();
        }
    }
}
