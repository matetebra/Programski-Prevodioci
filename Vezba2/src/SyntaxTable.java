/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Mateja
 */
public class SyntaxTable
{
    private SyntaxTableObject[][] table;
    public SyntaxTable()
    {
        table = new SyntaxTableObject[14][10];

        for (int i = 0; i < 14; i++)
        {
            for(int j = 0; j < 10; j++)
            {
                if (i-j == 4)
                {
                    if (i != 13)
                    {
                        table[i][j] = new SyntaxTableObject("pop");
                    }
                    else
                    {
                        table[i][j] = new SyntaxTableObject("acc");
                    }
                }
                else
                {
                    table[i][j] = new SyntaxTableObject("err");
                }
            }
        }

        int[] rightSide1 = { 4, 5, 6, 7, 6, 8, 9, 1 };
        this.table[0][0] = new SyntaxTableRuleObject(1, rightSide1);

        int[] rightSide2 = { 3, 2 };
        this.table[1][2] = new SyntaxTableRuleObject(2, rightSide2);

        int[] rightSide3 = { 10, 3, 2 };
        this.table[2][6] = new SyntaxTableRuleObject(3, rightSide3);

        int[] rightSide4 = { -1 };
        this.table[2][9] = new SyntaxTableRuleObject(4, rightSide4);

        int[] rightSide5 = { 6, 11, 12 };
        this.table[3][2] = new SyntaxTableRuleObject(5, rightSide5);
    }

    SyntaxTableObject getSyntaxTableObject(int m, int n)
    {
            return table[m][n];
    }
}
