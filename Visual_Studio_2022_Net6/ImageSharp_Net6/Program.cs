
namespace ImageSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            string inputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers.png";
            string outputPath = "C:\\proyecto pw2022\\MaterialesErp\\Materials\\pdf\\jobers2.jpg";

            var emgu = new Emgu();

            int totalLength1 = (int)Math.Round(emgu.PenDataCount(inputPath) / 3);

            Console.WriteLine($"Longitud total del trazo de la firma 1: {totalLength1} píxeles");

            var image = new ImageSharp();

            image.CambiarFirma(inputPath, outputPath);

            int totalLength2 = (int)Math.Round(emgu.PenDataCount(outputPath) / 3);

            Console.WriteLine($"Longitud total del trazo de la firma 2: {totalLength2} píxeles");

        }
    }
}
