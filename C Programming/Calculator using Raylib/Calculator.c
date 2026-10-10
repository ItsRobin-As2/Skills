// Calculator Using Raylib in C
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<raylib.h>

#define WIDTH 350
#define HEIGHT 500
#define TITLE "Calculator"
#define BgColor CLITERAL(Color) { 32, 32, 33, 200}
#define HeadColor CLITERAL(Color) { 30, 30, 35, 255}
#define Black CLITERAL(Color) { 15, 15, 15, 240}
#define Grey CLITERAL(Color) { 32, 32, 32, 255}
#define NeonRed CLITERAL(Color) { 255, 49, 49, 255}
#define LightBlack CLITERAL(Color) { 15, 15, 15, 80}
#define White CLITERAL(Color) { 190, 190, 190, 255}

void DrawButtons(char*);
void CalcInput(char*, char*);

void DrawButtons(char *Num){
    int numSize = 0;
    char *text[] = {"AC", " ", "%", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "00", "0", ".", "="};
    int x = 13, y = 174, width = 70, height = 50, fontSize = 28;
    for (int i = 0; i < 5; i++){
        for (int j = 0; j < 4; j++){
            Rectangle Temp = {x, y, width, height};
            DrawRectangleRounded(Temp, 0.3f, 2, Grey);
            DrawRectangleRounded((Rectangle){x + 3, y + 3, width, height}, 0.3f, 2, Black);
            if (i == 0 && j == 0) fontSize = 24;
            else fontSize = 28;
            DrawText(text[(i * 4) + j], x + 10, y + 10, fontSize, WHITE);
            Vector2 mousePos = GetMousePosition();
            if (IsMouseButtonPressed(MOUSE_BUTTON_LEFT) && CheckCollisionPointRec(mousePos, Temp))
            {
                DrawRectangleRounded((Rectangle){x, y, width, height}, 0.3f, 2, Black);
                char *input = text[(i * 4) + j];
                CalcInput(input, Num);
            }
            x += 84;
        }
        x = 12;
        y += 65;
    }
}

void CalcInput(char *input, char *Num)
{
    char ch = 0;
    if (strcmp(input, "AC") == 0){
        
    }else if (strcmp(input, " ") == 0){
        // else
    }
    else if (strcmp(input, "%") == 0){

    }
    else if (strcmp(input, "/") == 0){

    }
    else if (strcmp(input, "7") == 0){
        ch = '7';
    }
    else if (strcmp(input, "8") == 0){
        ch = '8';
    }
    else if (strcmp(input, "9") == 0){
        ch = '9';
    }
    else if (strcmp(input, "x") == 0){

    }
    else if (strcmp(input, "4") == 0){
        ch = '4';
    }
    else if (strcmp(input, "5") == 0){
        ch = '5';
    }
    else if (strcmp(input, "6") == 0){
        ch = '6';
    }
    else if (strcmp(input, "-") == 0){

    }
    else if (strcmp(input, "1") == 0){
        ch = '1';
    }
    else if (strcmp(input, "2") == 0){
        ch = '2';
    }
    else if (strcmp(input, "3") == 0){
        ch = '3';
    }
    else if (strcmp(input, "+") == 0){

    }
    else if (strcmp(input, "00") == 0){
        ch = '@';
    }
    else if (strcmp(input, "0") == 0){
        ch = '0';
    }
    else if (strcmp(input, ".") == 0){

    }
    else if (strcmp(input, "=") == 0){

    }
    int i = 0;
    while (Num[i] != '\0' && i < 11)
    {
        i++;
    }
    if (i >= 11)
    {
        return;
    }
    if (ch != '@')
    {
        Num[i] = ch;
        Num[i + 1] = '\0';
    }
    else
    {
        Num[i] = '0';
        if (i == 10)
        {
            return;
        }
        Num[i + 1] = '0';
        Num[i + 2] = '\0';
    }
}

int main(){
    long num1, num2, res;
    char *Num = malloc(12);
    Num[0] = '\0';
    InitWindow(WIDTH, HEIGHT, TITLE);
    SetWindowPosition(1540, 60);
    SetTargetFPS(24);
    SetWindowState(FLAG_WINDOW_TOPMOST);
    SetWindowState(FLAG_WINDOW_UNDECORATED);
    ClearBackground(Black);

    Texture2D powerButton = LoadTexture("PowerButton.png");
    Rectangle powerButtonRec = {WIDTH - 45, 16, 33, 33};
    powerButton.width = 33;
    powerButton.height = 33;
    Rectangle Box1 = {3, 3, WIDTH - 6, HEIGHT - 6};
    Rectangle Box2 = {3, 3, WIDTH - 6, 60};
    Rectangle calcScreen = {14, 74, WIDTH - 28, 86};
    Rectangle calcText = {8, 13, WIDTH - 64, 42};
    while (!WindowShouldClose()){
        Vector2 mousePos = GetMousePosition();
        ClearBackground(Black);
        BeginDrawing();
        DrawRectangleRounded(Box1, 0.1f, 2, BgColor);
        DrawRectangleRounded(Box2, 0.4f, 2, HeadColor);
        if (CheckCollisionPointRec(mousePos, calcText))
        {
            DrawRectangleRounded(calcText, 0.2f, 2, LightBlack);
        }
        DrawText("CALCULATOR", 15, 15, 40, DARKBLUE);
        DrawText("CALCULATOR", 16, 16, 40, DARKBLUE);
        DrawTexture(powerButton, WIDTH - 45, 16, NeonRed);
        if (IsMouseButtonPressed(MOUSE_BUTTON_LEFT)){
            mousePos = GetMousePosition();
            if (CheckCollisionPointRec(mousePos, powerButtonRec)){
                CloseWindow();
                exit(EXIT_SUCCESS);
            }
        }
        DrawRectangleRounded((Rectangle){12, 72, WIDTH - 24, 90}, 0.3f, 2, Black);
        DrawRectangleRounded(calcScreen, 0.3f, 2, Grey);
        DrawText(Num, 38, 95, 46, White);
        DrawButtons(Num);
        EndDrawing();
    }

    UnloadTexture(powerButton);
    CloseWindow();
    return 0;
}

// This program is currently incomplete.