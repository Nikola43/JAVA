import java.util.Random;

public class Main
{
    public static void main(String []Args)
    {
        final int MIN_RANDOM = 1;
        final int MAX_RANDOM = 3;

        final int LCD_HEIGHT = 64;
        final int LCD_WIDTH = 64;

        char [][]lcd = new char[LCD_WIDTH][LCD_WIDTH];


        for ( int i = 0; i < 34; i++)
        {
            System.out.println(generateRandom(MIN_RANDOM, MAX_RANDOM));
        }



    }

    public static int generateRandom(int minimum, int maximum)
    {
        return((new Random().nextInt(maximum - minimum + 1) + minimum));
    }
}
