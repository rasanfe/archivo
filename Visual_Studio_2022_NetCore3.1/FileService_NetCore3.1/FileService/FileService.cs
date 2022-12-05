﻿using System;
using System.IO;
namespace FileService
{
    public class FileService
    {
        private string errorText = "";
        public string GetFilename(string fileInput)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            if (EndsInDirectorySeparator(fileInput))
            {
                fileInput = Path.TrimEndingDirectorySeparator(fileInput);
            }

            try
            {
                string fileOut = Path.GetFileName(fileInput);
                return fileOut;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return System.String.Empty;
            }
        }

        public string GetExtension(string fileInput)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            if (EndsInDirectorySeparator(fileInput))
            {
                fileInput = Path.TrimEndingDirectorySeparator(fileInput);
            }


            try
            {
                string fileOut = Path.GetExtension(fileInput);
                return fileOut;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return System.String.Empty;
            }
        }

        public string GetFileNameWithoutExtension(string fileInput)
        {
            if (EndsInDirectorySeparator(fileInput))
            {
                fileInput = Path.TrimEndingDirectorySeparator(fileInput);
            }


            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            try
            {
                string fileOut = Path.GetFileNameWithoutExtension(fileInput);
                return fileOut;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return System.String.Empty;
            }
        }

        public string ChangeExtension(string fileInput, string extension)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            if (EndsInDirectorySeparator(fileInput))
            {
                fileInput = Path.TrimEndingDirectorySeparator(fileInput);
            }

            try
            {
                string fileOut = Path.ChangeExtension(fileInput, extension);
                return fileOut;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return System.String.Empty;
            }
        }

        public string GetDirectoryName(string fileInput)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            if (EndsInDirectorySeparator(fileInput))
            {
                fileInput = Path.TrimEndingDirectorySeparator(fileInput);
            }


            try
            {
                string fileOut = Path.GetDirectoryName(fileInput);
                return fileOut;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return System.String.Empty;
            }
        }

        public bool EndsInDirectorySeparator(string fileInput)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            bool isEndsInDirectorySeparator = Path.EndsInDirectorySeparator(fileInput);

            return isEndsInDirectorySeparator;
        }

        public bool FileRename(string fileInput, string newFile)
        {

            if (string.IsNullOrEmpty(fileInput))
            {
                errorText = "Input File cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            if (!File.Exists(fileInput))
            {
                errorText = "Input File not Exists";
                throw new ArgumentException(paramName: nameof(fileInput), message: errorText);
            }

            if (string.IsNullOrEmpty(newFile))
            {
                errorText = "New File Name cannot be null or Empty";
                throw new ArgumentNullException(paramName: nameof(fileInput), message: errorText);
            }

            try
            {
                if (File.Exists(newFile))
                {
                    File.Delete(newFile);
                }

                File.Move(fileInput, newFile);
                return true;
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
                return false;
            }

        }


    }
}
