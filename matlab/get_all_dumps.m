function [] = get_all_dumps(n, dir)
    % Generate all dumps

    disp("NOTE: This code only generates dumps for those configurations in which upper half of adder is a "+...
    "single block (always on) and lower half of the adder is divided into block (switchable)");

    % % 8-4
    gendump(n, 8, 4, [1 0], dir);

    % % 16-4
    gendump(n, 16, 4, [1 1 1 0], dir);
    gendump(n, 16, 4, [1 1 0 0], dir);
    
    % % 16-8
    gendump(n, 16, 8, [1 0], dir);
        
    % 32-4
    gendump(n, 32, 4, [1 1 1 1 1 1 1 0], dir);
    gendump(n, 32, 4, [1 1 1 1 1 1 0 0], dir);
    gendump(n, 32, 4, [1 1 1 1 1 0 0 0], dir);
    gendump(n, 32, 4, [1 1 1 1 0 0 0 0], dir);
    
    % 32-8
    gendump(n, 32, 8, [1 1 1 0], dir);
    gendump(n, 32, 8, [1 1 0 0], dir);

    % 32-16
    gendump(n, 32, 16, [1 0], dir);

end