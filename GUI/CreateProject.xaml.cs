using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Robyte_Dev
{
    /// <summary>
    /// Interaction logic for CreateProject.xaml
    /// </summary>
    public partial class CreateProject : Window
    {

        private static string SelectedProjectType;
        public CreateProject()
        {
            InitializeComponent();
            PopulateExistingProjects();
        }

        private void HomeBtn_Click(object sender, RoutedEventArgs e)
        {
            MainWindow home = new MainWindow();
            home.Show();
            this.Close();
        }

        private void PopulateExistingProjects()
        {
            foreach (string projectDir in MainWindow.projectDirPaths)
            {
                string projectName = Path.GetFileName(projectDir);
                existingProjectsDropbox.Items.Add(projectName);
            }
        }

        private void CreateProject_Click(object sender, RoutedEventArgs e)
        {
            // Some validation
            if (SelectedProjectType == null)
                MessageBox.Show("You have to specify the project type!");
            if (projectNameTextbox.Text == null)
                MessageBox.Show("You must give your project a name!");

            string projectName = projectNameTextbox.Text.Substring(0, 1).ToLower() + projectNameTextbox.Text.Substring(1);
            string[] extraTechnologies = getSelectedCheckboxes().ToArray();
            switch (SelectedProjectType)
            {
                case "Basic web project (HTML, CSS, JS)":
                    createBasicWebProject(extraTechnologies, existingProjectsDropbox, projectName);
                    break;
                case "Reactjs project":
                    createReactProject(extraTechnologies, existingProjectsDropbox, projectName);
                    break;
                case "REST-API (Nodejs with Express)":
                    createExpressApi(extraTechnologies, existingProjectsDropbox, projectName);
                    break;
            }
        }

        private void createBasicWebProject(string[] extraTechnologies, ComboBox addToProject, string projectName)
        {
            if (addToProject.SelectedItem == null)
            {
            string fullProjectPath = MainWindow.project_path + "\\" + projectName + "\\" + projectName + "_basicweb";
                Directory.CreateDirectory(fullProjectPath);
                File.Create(fullProjectPath + "\\index.html");
                File.Create(fullProjectPath + "\\style.css");
                File.Create(fullProjectPath + "\\app.js");
                Process.Start("cmd", "/c cd " + fullProjectPath + " && code .");
            }
            else
            {
                string fullAddToProjectPath = MainWindow.project_path + "\\" + existingProjectsDropbox.SelectedItem.ToString() + "\\" + projectName + "_basicweb";
                Directory.CreateDirectory(fullAddToProjectPath);
                File.Create(fullAddToProjectPath + "\\index.html");
                File.Create(fullAddToProjectPath + "\\style.css");
                File.Create(fullAddToProjectPath + "\\app.js");
                Process.Start("cmd", "/c cd " + fullAddToProjectPath + " && code .");
            }
        }
        private void createReactProject(string[] extraTechnologies, ComboBox addToProject, string projectName)
        {
            if (addToProject.SelectedItem == null)
            {
            string fullProjectPath = MainWindow.project_path + "\\" + projectName;
                Directory.CreateDirectory(fullProjectPath);
                if (extraTechnologies == null)
                    Process.Start("cmd", "/k cd " + fullProjectPath + " && npx create-react-app " + projectName + "_web " + "&& cd " + fullProjectPath + "\\" + projectName + "_web " + "&& code . && npm start");
                else if (extraTechnologies.Contains("Next"))
                {
                    extraTechnologies = extraTechnologies.Where(tech => tech != "Next").ToArray();
                    if (extraTechnologies == null)
                    {
                        Process.Start("cmd", "/k cd " + fullProjectPath + " && npx create-next-app " + projectName + "_web " + "&& cd " + fullProjectPath + "\\" + projectName + "_web " + "&& code . && npm run dev");
                    } else
                    {
                        string npmPackages = string.Join(' ', extraTechnologies).Replace("Material UI", "@material-ui/core").Replace("Stripejs", "@stripe/react-stripe-js @stripe/stripe-js").Replace("Chartjs", "react-chartjs-2");
                        Process.Start("cmd", "/k cd " + fullProjectPath + " && npx create-next-app " + projectName + "_web " + "&& cd " + fullProjectPath + "\\" + projectName + "_web " + "&& npm install " + npmPackages + "&& code . && npm run dev");
                    }
                } else
                {
                    string npmPackages = string.Join(' ', extraTechnologies).Replace("Material UI", "@material-ui/core").Replace("Stripejs", "@stripe/react-stripe-js @stripe/stripe-js").Replace("Chartjs", "react-chartjs-2");
                    Process.Start("cmd", "/k cd " + fullProjectPath + " && npx create-react-app " + projectName + "_web " + "&& cd " + fullProjectPath + "\\" + projectName + "_web " + "&& npm install " + npmPackages + " && code . && npm start");
                }
            }
            else
            {
                string fullAddToProjectPath = MainWindow.project_path + "\\" + existingProjectsDropbox.SelectedItem.ToString();
                Directory.CreateDirectory(fullAddToProjectPath);
                if (extraTechnologies == null)
                    Process.Start("cmd", "/k cd " + fullAddToProjectPath + " && npx create-react-app " + projectName + "_web " + "&& cd " + fullAddToProjectPath + "\\" + projectName + "_web" + " && code . && npm start");
                else if (extraTechnologies.Contains("Next"))
                {
                    extraTechnologies = extraTechnologies.Where(tech => tech != "Next").ToArray();
                    if (extraTechnologies == null)
                    {
                        Process.Start("cmd", "/k cd " + fullAddToProjectPath + " && npx create-next-app " + projectName + "_web " + "&& cd " + fullAddToProjectPath + "\\" + projectName + "_web " + "&& code . && npm run dev");
                    }
                    else
                    {
                        string npmPackages = string.Join(' ', extraTechnologies).Replace("Material UI", "@material-ui/core").Replace("Stripejs", "@stripe/react-stripe-js @stripe/stripe-js").Replace("Chartjs", "react-chartjs-2");
                        Process.Start("cmd", "/k cd " + fullAddToProjectPath + " && npx create-next-app " + projectName + "_web " + "&& cd " + fullAddToProjectPath + "\\" + projectName + "_web " + "&& npm install " + npmPackages + "&& code . && npm run dev");
                    }
                }
                else
                {
                    string npmPackages = string.Join(' ', extraTechnologies).Replace("Material UI", "@material-ui/core").Replace("Stripejs", "@stripe/react-stripe-js @stripe/stripe-js").Replace("Chartjs", "react-chartjs-2");
                    Process.Start("cmd", "/k cd " + fullAddToProjectPath + " && npx create-react-app " + projectName + "_web " + "&& cd " + fullAddToProjectPath + "\\" + projectName + "_web " + "&& npm install " + npmPackages + " && code . && npm start");
                }
            }
        }
        private void createExpressApi(string[] extraTechnologies, ComboBox addToProject, string projectName)
        {
            if (addToProject.SelectedItem == null)
            {
                string fullProjectPath = MainWindow.project_path + "\\" + projectName + "\\" + projectName + "_webapi";

                // Make basic folder structure
                Directory.CreateDirectory(fullProjectPath);
                Directory.CreateDirectory(fullProjectPath + "\\routes");
                Directory.CreateDirectory(fullProjectPath + "\\models");
                Directory.CreateDirectory(fullProjectPath + "\\images");
                Directory.CreateDirectory(fullProjectPath + "\\controllers");
                File.Create(fullProjectPath + "\\app.js");

                // Check for other technologies and install them + Launch vscode
                if (extraTechnologies == null)
                    Process.Start("cmd", "/c cd " + fullProjectPath + " && npm i express && code .");
                else
                {
                    // Replace Checkbox labelnames with real npm package names
                    string npmPackages = string.Join(' ', extraTechnologies).Replace("MongoDB", "mongoose").ToLower();
                    Process.Start("cmd", "/c cd " + fullProjectPath + " && npm i express " + npmPackages + "&& code .");
                }
            }
            else
            {
                string fullAddToProjectPath = MainWindow.project_path + "\\" + existingProjectsDropbox.SelectedItem.ToString() + "\\" + projectName + "_webapi";

                // Make basic folder structure
                Directory.CreateDirectory(fullAddToProjectPath);
                Directory.CreateDirectory(fullAddToProjectPath + "\\routes");
                Directory.CreateDirectory(fullAddToProjectPath + "\\models");
                Directory.CreateDirectory(fullAddToProjectPath + "\\images");
                Directory.CreateDirectory(fullAddToProjectPath + "\\controllers");
                File.Create(fullAddToProjectPath + "\\app.js");

                // Check for other technologies and install them + Launch vscode
                if (extraTechnologies == null)
                    Process.Start("cmd", "/c cd " + fullAddToProjectPath + " && npm i express && code .");
                else
                {
                    // Replace Checkbox labelnames with real npm package names
                    string npmPackages = string.Join(' ', extraTechnologies).Replace("MongoDB", "mongoose").ToLower();
                    Process.Start("cmd", "/c cd " + fullAddToProjectPath + " && npm i express " + npmPackages + "&& code .");
                }
            }
        }

        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {
            RadioButton radioButton = sender as RadioButton;
            if (radioButton == null)
                return;
            SelectedProjectType = radioButton.Content.ToString();
        }
        
        private List<string> getSelectedCheckboxes()
        {
            IEnumerable<CheckBox> selectedBoxes =
            from checkbox in extraTechnologies.Children.OfType<CheckBox>()
            where checkbox.IsChecked.Value
            select checkbox;

            List<string> SelectedTechnologies = new List<string>();

            foreach (CheckBox box in selectedBoxes)
            {
                if (box.IsChecked == true)
                {
                    SelectedTechnologies.Add(box.Content.ToString());
                }
            }
            return SelectedTechnologies;
        }
    }
}
