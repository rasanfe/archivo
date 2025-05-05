using SixLabors.ImageSharp;
using ImageSharpImage = SixLabors.ImageSharp.Image;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using SixLabors.ImageSharp.Metadata.Profiles.Exif;
using System.IO;

namespace ImageSharp
{
    public class ImageSharp
    {

        //    public void CambiarFirma(string inputPath, string outputPath)
        //    {
        //        //string inputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers.png";
        //        //string outputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers2.jpg";

        //        using (Image<Rgba32> image = Image.Load<Rgba32>(inputPath))
        //        {
        //            // Cambiar el tamaño de la imagen
        //            image.Mutate(x => x.Resize(754, 480));

        //            // Cambiar la resolución a 96x96
        //            var metadata = image.Metadata;
        //            var exifProfile = metadata.ExifProfile ?? new ExifProfile();
        //            exifProfile.SetValue(ExifTag.XResolution, new Rational(96, 1));
        //            exifProfile.SetValue(ExifTag.YResolution, new Rational(96, 1));
        //            metadata.ExifProfile = exifProfile;

        //            // Crear una nueva imagen con fondo blanco
        //            using (Image<Rgba32> whiteBackground = new Image<Rgba32>(754, 480, Color.White))
        //            {
        //                // Dibujar la imagen redimensionada sobre el fondo blanco
        //                whiteBackground.Mutate(x => x.DrawImage(image, new Point(0, 0), 1.0f));
        //                // Guardar la imagen resultante
        //                whiteBackground.Save(outputPath);
        //            }
        //        }
        //    }
        //    public void CambiarFirma(string inputPath, string outputPath)
        //    {
        //        //string inputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers.png";
        //        //string outputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers2.jpg";
        //        Rgba32 signatureColor = new Rgba32(0, 0, 255); // Color azul

        //        using (Image<Rgba32> image = Image.Load<Rgba32>(inputPath))
        //        {
        //            // Cambiar el tamaño de la imagen
        //            image.Mutate(x => x.Resize(754, 480));

        //            // Crear una nueva imagen con fondo blanco
        //            using (Image<Rgba32> whiteBackground = new Image<Rgba32>(754, 480, Color.White))
        //            {
        //                // Dibujar la imagen redimensionada sobre el fondo blanco
        //                whiteBackground.Mutate(x => x.DrawImage(image, new Point(0, 0), 1.0f));

        //                // Cambiar los píxeles negros al color azul
        //                whiteBackground.ProcessPixelRows(accessor =>
        //                {
        //                    for (int y = 0; y < accessor.Height; y++)
        //                    {
        //                        Span<Rgba32> pixelRow = accessor.GetRowSpan(y);
        //                        for (int x = 0; x < pixelRow.Length; x++)
        //                        {
        //                            if (pixelRow[x].R == 0 && pixelRow[x].G == 0 && pixelRow[x].B == 0)
        //                            {
        //                                pixelRow[x] = signatureColor;
        //                            }
        //                        }
        //                    }
        //                });

        //                // Guardar la imagen resultante en formato JPEG
        //                whiteBackground.Save(outputPath);
        //            }
        //        }
        //    }


        public void CambiarFirma(string inputPath, string outputPath)
            {
                //string inputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers.png";
                //string outputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers2.jpg";
                Rgba32 signatureColor = new Rgba32(0, 0, 255); // Color azul

                using (Image<Rgba32> image = Image.Load<Rgba32>(inputPath))
                {
                    // Poner el color transparente en blanco
                    image.Mutate(x => x.BackgroundColor(Color.White));

                    // Cambiar los píxeles negros al color azul
                    image.ProcessPixelRows(accessor =>
                    {
                        for (int y = 0; y < accessor.Height; y++)
                        {
                            Span<Rgba32> pixelRow = accessor.GetRowSpan(y);
                            for (int x = 0; x < pixelRow.Length; x++)
                            {
                                if (pixelRow[x].R == 0 && pixelRow[x].G == 0 && pixelRow[x].B == 0)
                                {
                                    pixelRow[x] = signatureColor;
                                }
                            }
                        }
                    });

                    // Cambiar el tamaño de la imagen
                    image.Mutate(x => x.Resize(754, 480));

                    // Guardar la imagen resultante en formato JPEG
                    image.Save(outputPath);
                }
            }
        }
 
}
