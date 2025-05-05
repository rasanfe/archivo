using System;
using System.Drawing;
using Emgu.CV;
using Emgu.CV.CvEnum;
using Emgu.CV.Structure;
using Emgu.CV.Util;
namespace ImageSharp
{
    internal class Emgu
    {
        public double PenDataCount(string inputPath)
        {
           //string inputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers.png";

            // Cargar la imagen en escala de grises
            Mat image = CvInvoke.Imread(inputPath, ImreadModes.Grayscale);

            // Binarizar la imagen (umbralización)
            Mat binaryImage = new Mat();
            CvInvoke.Threshold(image, binaryImage, 128, 255, ThresholdType.Binary);

            // Encontrar contornos
            using (VectorOfVectorOfPoint contours = new VectorOfVectorOfPoint())
            {
                CvInvoke.FindContours(binaryImage, contours, null, RetrType.External, ChainApproxMethod.ChainApproxSimple);

                double totalLength = 0;

                // Calcular la longitud de cada contorno
                for (int i = 0; i < contours.Size; i++)
                {
                    using (VectorOfPoint contour = contours[i])
                    {
                        double length = CvInvoke.ArcLength(contour, false);
                        totalLength += length;
                    }
                }

                // Console.WriteLine($"Longitud total del trazo de la firma: {totalLength} píxeles");
                return totalLength;
            }
        }
    }
}
