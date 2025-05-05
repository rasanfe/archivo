﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using WIA;
using System.ComponentModel;

namespace ScannerWia
{
    internal class Scanner
    {
        const string WIA_SCAN_COLOR_MODE = "6146";
        const string WIA_HORIZONTAL_SCAN_RESOLUTION_DPI = "6147";
        const string WIA_VERTICAL_SCAN_RESOLUTION_DPI = "6148";
        const string WIA_HORIZONTAL_SCAN_START_PIXEL = "6149";
        const string WIA_VERTICAL_SCAN_START_PIXEL = "6150";
        const string WIA_HORIZONTAL_SCAN_SIZE_PIXELS = "6151";
        const string WIA_VERTICAL_SCAN_SIZE_PIXELS = "6152";
        const string WIA_SCAN_BRIGHTNESS_PERCENTS = "6154";
        const string WIA_SCAN_CONTRAST_PERCENTS = "6155";

        private readonly DeviceInfo _deviceInfo;
        private int resolution = 300;
        private int width_pixel = 2481;//1250;
        private int height_pixel = 3507;//1700;
        private int color_mode = 1;

        internal Scanner(DeviceInfo deviceInfo)
        {
            this._deviceInfo = deviceInfo;
        }

        /// <summary>
        /// Scan an image with the specified format
        /// </summary>
        /// <param name="imageFormat">Expects a WIA.FormatID constant</param>
        /// <returns></returns>
        internal List<ImageFile> ScanImages(string imageFormat)
        {
            // Connect to the device and instruct it to scan
            // Connect to the device
            var device = this._deviceInfo.Connect();

            // Select the scanner
            CommonDialog dlg = new CommonDialog();

            var item = device.Items[1];

            List<ImageFile> scannedImages = new List<ImageFile>();

            while (true)
            {
                 try
                  {
                    AdjustScannerSettings(item, resolution, 0, 0, width_pixel, height_pixel, 0, 0, color_mode);

                    object scanResult = dlg.ShowTransfer(item, imageFormat, true);

                    if (scanResult != null)
                    {
                        var imageFile = (ImageFile)scanResult;
                        scannedImages.Add(imageFile);
                    }
                    else
                    {
                        break;
                    }
                }
                catch (COMException e)
                {
                    // Display the exception in the console.
                    Console.WriteLine(e.ToString());

                    uint errorCode = (uint)e.ErrorCode;

                    // Catch 2 of the most common exceptions
                    if (errorCode == 0x80210006)
                    {
                        throw new Exception("El escáner está ocupado o no está listo.");
                    }
                    else if (errorCode == 0x80210064)
                    {
                        throw new Exception("El proceso de escaneo ha sido cancelado.");
                    }
                    else if (errorCode == 0x80210003) // WIA_ERROR_PAPER_EMPTY
                    {
                        // No more pages
                        break;
                    }
                    else
                    {
                        throw new Exception("Se produjo un error no capturado, verifica la consola.");
                    }
                }
            }

            return scannedImages;

        }

        /// <summary>
        /// Adjusts the settings of the scanner with the providen parameters.
        /// </summary>
        /// <param name="scannnerItem">Expects a </param>
        /// <param name="scanResolutionDPI">Provide the DPI resolution that should be used e.g 150</param>
        /// <param name="scanStartLeftPixel"></param>
        /// <param name="scanStartTopPixel"></param>
        /// <param name="scanWidthPixels"></param>
        /// <param name="scanHeightPixels"></param>
        /// <param name="brightnessPercents"></param>
        /// <param name="contrastPercents">Modify the contrast percent</param>
        /// <param name="colorMode">Set the color mode</param>
        private void AdjustScannerSettings(IItem scannnerItem, int scanResolutionDPI, int scanStartLeftPixel, int scanStartTopPixel, int scanWidthPixels, int scanHeightPixels, int brightnessPercents, int contrastPercents, int colorMode)
        {
            SetWIAProperty(scannnerItem.Properties, WIA_HORIZONTAL_SCAN_RESOLUTION_DPI, scanResolutionDPI);
            SetWIAProperty(scannnerItem.Properties, WIA_VERTICAL_SCAN_RESOLUTION_DPI, scanResolutionDPI);
            SetWIAProperty(scannnerItem.Properties, WIA_HORIZONTAL_SCAN_START_PIXEL, scanStartLeftPixel);
            SetWIAProperty(scannnerItem.Properties, WIA_VERTICAL_SCAN_START_PIXEL, scanStartTopPixel);
            SetWIAProperty(scannnerItem.Properties, WIA_HORIZONTAL_SCAN_SIZE_PIXELS, scanWidthPixels);
            SetWIAProperty(scannnerItem.Properties, WIA_VERTICAL_SCAN_SIZE_PIXELS, scanHeightPixels);
            SetWIAProperty(scannnerItem.Properties, WIA_SCAN_BRIGHTNESS_PERCENTS, brightnessPercents);
            SetWIAProperty(scannnerItem.Properties, WIA_SCAN_CONTRAST_PERCENTS, contrastPercents);
            SetWIAProperty(scannnerItem.Properties, WIA_SCAN_COLOR_MODE, colorMode);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="properties"></param>
        /// <param name="propName"></param>
        /// <param name="propValue"></param>
        private void SetWIAProperty(IProperties properties, object propName, object propValue)
        {
            Property prop = properties.get_Item(ref propName);

            try
            {
                prop.set_Value(ref propValue);
            }
            catch
            {
                // DPI can only be set to values listed in SubTypeValues
                // This sets the DPI to the lowest one supported by the scanner
                if (propName.ToString() == WIA_HORIZONTAL_SCAN_RESOLUTION_DPI || propName.ToString() == WIA_VERTICAL_SCAN_RESOLUTION_DPI)
                {
                    foreach (object test in prop.SubTypeValues)
                    {
                        prop.set_Value(test);
                        break;
                    }
                }
            }
        }

        /// <summary>
        /// Declare the ToString method
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return (string)this._deviceInfo.Properties["Name"].get_Value();
        }




    }
}