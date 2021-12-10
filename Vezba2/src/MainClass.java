/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Mateja
 */
import java.util.Stack;
import java.io.Reader;

public class MainClass
{
    public static void main(String args[])
    {
        int[] lookup = new int[26];
        int[] indices = {7, 13, 9, 22, 14, 23, 16, 15, 10, 0};

        for(int i = 0; i < 26; i++)
        {
            lookup[i] = -1;
        }

        for (int i = 0; i < 9; i++)
        {
            lookup[indices[i]] = i;
        }

        Stack<Integer> stack = new Stack();

        stack.push(new Integer(13)); // push # to stack
        stack.push(new Integer(0)); // push ReadExp (ReadExpression) to stack

        boolean prepoznat = false;
        boolean greska = false;

        try
        {
            MPLexer lexer = new MPLexer(new java.io.FileReader(args[0]));
            SyntaxTable table = new SyntaxTable();

            int next;
            do
                next = lookup[lexer.next_token().m_index];
            while (next == -1);
            
            do
            {
                SyntaxTableObject sto =  table.getSyntaxTableObject(stack.peek().intValue(), next);

                switch(sto.type)
                {
                    case "pop":
                    {
                        stack.pop();
                        do
                            next = lookup[lexer.next_token().m_index];
                        while (next == -1);
                        break;
                    }
                    case "rule":
                    {
                        stack.pop();
                        ((SyntaxTableRuleObject)sto).pushToStack(stack);

                        //eventualno cuvanje ((SyntaxTableRuleObject)sto).ruleNumber u P

                        break;
                    }
                    case "acc":
                    {
                        prepoznat = true;
                        break;
                    }
                    case "err":
                        greska = true;
                        break;
                }
            }
            while(!(prepoznat || greska));

            if (greska)
            {
                System.out.println("Sintax error!");
            }

            if (prepoznat)
            {
                System.out.println("No sintax errors!");
            }
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
        }
    }
}
