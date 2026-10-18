newCanvas = love.graphics.newCanvas()
username = ""
file = ""
local logged = false
local currentBox
local userBoxX, userBoxY, userBoxW, userBoxH
local fileBoxX, fileBoxY, fileBoxW, fileBoxH
local submitButtonX, submitButtonY, submitButtonW, submitButtonH
local usernameBoxIsClicked = false
local fileBoxIsClicked = false
local submitButtonClicked = false
local colors = {
    white = {0.9, 0.9, 0.9},
    red = {186/255, 23/255, 11/255},
    greyishBlack = {18/255, 18/255, 18/255, 80/255},
    lightBlack = {14/255, 14/255, 14/255},
    lightBlack2 = {12/255, 12/255, 12/255},
    darkBlack = {6/255, 6/255, 6/255},
    lightGreen = {16/255, 196/255, 42/255},
    green = {11/255, 133/255, 29/255}
}

function love.load()
    love.graphics.setBackgroundColor(colors.lightBlack)
    loadAllText()
    love.keyboard.setKeyRepeat(true)
end

function love.update(dt)

end

function love.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    if not logged then
        loginScreen(screenWidth, screenHeight)
        welcomeScreen(screenWidth, screenHeight)
    elseif logged == true then
        if username == "" then
            username = "Guest0123"
        elseif file == "" then
            file = "main.lua"
        end
        love.graphics.draw(newCanvas)
    end
end

function love.textinput(t)
    if currentBox == 1 then
        if #username == 16 then
            goto skip
        end
        username = username .. t
    elseif currentBox == 2 then
        if #file == 16 then
            goto skip
        end
        file = file .. t
    end
    ::skip::
end

function love.mousepressed( x, y, button)
    if button == 1 then
        if (x > userBoxX and x < userBoxX + userBoxW) and (y > userBoxY and y < userBoxY + userBoxH) then
            usernameBoxIsClicked = true
            fileBoxIsClicked = false
            currentBox = 1
        end
        if (x > fileBoxX and x < fileBoxX + fileBoxW) and (y > fileBoxY and y < fileBoxY + fileBoxH) then
            fileBoxIsClicked = true
            usernameBoxIsClicked = false
            currentBox = 2
        end
        if (x > submitButtonX and x < submitButtonX + submitButtonW) and (y > submitButtonY and y < submitButtonY + submitButtonH) then
            fileBoxIsClicked = false
            usernameBoxIsClicked = false
            submitButtonClicked = true
            logged = true
        end
    end
end

function love.keypressed(key)
    if key == "backspace" then
        if currentBox == 1 then
            username = string.sub(username, 1, #username - 1)
        elseif currentBox == 2 then
            file = string.sub(file, 1, #file - 1)
        end
    end
end

function loadAllText()
    fontW = love.graphics.newFont(50)
    love.graphics.setFont(fontW)
    textW = love.graphics.newText(fontW, {{1, 1, 1}, "Welcome to Lua IDE!"})
    textWidth = textW:getWidth()

    font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    text = love.graphics.newText(font, "Username: ")
    text2 = love.graphics.newText(font, "File Name: ")

    font1 = love.graphics.newFont(25)
    love.graphics.setFont(font1)
    boldText = love.graphics.newText(font1, "Username: ")
    boldText2 = love.graphics.newText(font1, "File Name: ")

    userInputFont = love.graphics.newFont(20)
    love.graphics.setFont(userInputFont)
    userInputFontBig = love.graphics.newFont(25)
    love.graphics.setFont(userInputFontBig)

    fileInputFont = love.graphics.newFont(20)
    love.graphics.setFont(fileInputFont)
    fileInputFontBig = love.graphics.newFont(25)
    love.graphics.setFont(fileInputFontBig)

    submitInputFont = love.graphics.newFont(35)
    love.graphics.setFont(submitInputFont)
    submitText = love.graphics.newText(submitInputFont, "SUBMIT")
end

function welcomeScreen(width, height)
    love.graphics.setColor(colors.white)
    love.graphics.draw(textW, width / 2 - textWidth / 2, height / 7)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.draw(textW, width / 2 - textWidth / 2 + 2, height / 7 + 2)
end

function loginScreen(width, height)
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", 10, 10, width - 20, height - 20, 10)

    local lsh = 220; local lsw = 500
    local lsx = width / 2 - lsw / 2; local lsy = height / 2 - lsh / 2
    love.graphics.setColor(colors.lightBlack)
    love.graphics.rectangle("fill", lsx, lsy, lsw, lsh, 10)

    local lsh1 = lsh - 20; local lsw1 = lsw - 20
    local lsx1 = (width / 2 - lsw / 2) + 10; local lsy1 = (height / 2 - lsh / 2) + 10
    love.graphics.setColor(colors.lightBlack2)
    love.graphics.rectangle("fill", lsx1, lsy1, lsw1, lsh1, 10)

    local lsh2 = lsh - 40; local lsw2 = lsw - 40
    local lsx2 = (width / 2 - lsw / 2) + 20; local lsy2 = (height / 2 - lsh / 2) + 20
    love.graphics.setColor(colors.white)
    love.graphics.rectangle("fill", lsx2, lsy2, lsw2, lsh2, 10)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.rectangle("fill", lsx2 + 1, lsy2 + 1, lsw2 - 2, lsh2 - 2, 10)
    -- show user input area
    if usernameBoxIsClicked then
        userInputBox(lsx2 - 5, lsy2 - 5, 10)
    else
        userInputBox(lsx2, lsy2)
    end
    -- show file input area
    if fileBoxIsClicked then
        fileInputBox(lsx2 - 5, lsy2 - 5, 10)
    else
        if usernameBoxIsClicked then
            fileInputBox(lsx2, lsy2 - 10)
        else
            fileInputBox(lsx2, lsy2)
        end
    end
    submitButton(lsx + lsw / 4, lsy + lsh / 2)
end

function userInputBox(lsx2, lsy2, diff)
    diff = diff or 0
    -- Username Box
    userBoxH = 60 + diff; userBoxW = 420 + diff
    userBoxX = lsx2 + 20; userBoxY = lsy2 + 20
    if diff ~= 0 then
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", userBoxX - 1, userBoxY - 1, userBoxW + 2, userBoxH + 2, 10)
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", userBoxX, userBoxY, userBoxW, userBoxH, 10)
        love.graphics.setColor(colors.darkBlack)
        love.graphics.draw(boldText, userBoxX + 15, userBoxY + 17)
        -- User Input
        love.graphics.setColor(colors.darkBlack)
        love.graphics.print({colors.white, username}, userInputFontBig, userBoxX + 180, userBoxY + 17)
    else
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", userBoxX, userBoxY, userBoxW, userBoxH, 10)
        love.graphics.setColor(colors.white)
        love.graphics.draw(text, userBoxX + 15, userBoxY + 17)
        -- User Input
        love.graphics.setColor(colors.white)
        love.graphics.print({colors.white, username}, userInputFont, userBoxX + 160, userBoxY + 17)
    end
end

function fileInputBox(lsx2, lsy2, diff)
    diff = diff or 0
    -- file Box
    fileBoxH = 60 + diff; fileBoxW = 420 + diff
    fileBoxX = lsx2 + 20; fileBoxY = userBoxH + lsy2 + 40
    if diff ~= 0 then
        love.graphics.setColor(colors.white)
        love.graphics.rectangle("fill", fileBoxX - 1, fileBoxY - 1, fileBoxW + 2, fileBoxH + 2, 10)
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", fileBoxX, fileBoxY, fileBoxW, fileBoxH, 10)
        love.graphics.setColor(colors.darkBlack)
        love.graphics.draw(boldText2, fileBoxX + 15, fileBoxY + 17)
        -- User Input
        love.graphics.setColor(colors.darkBlack)
        love.graphics.print({colors.white, file}, fileInputFontBig, fileBoxX + 180, fileBoxY + 17)
    else
        love.graphics.setColor(colors.greyishBlack)
        love.graphics.rectangle("fill", fileBoxX, fileBoxY, fileBoxW, fileBoxH, 10)
        love.graphics.setColor(colors.white)
        love.graphics.draw(text2, fileBoxX + 15, fileBoxY + 17)
        -- User Input
        love.graphics.setColor(colors.white)
        love.graphics.print({colors.white, file}, fileInputFont, fileBoxX + 160, fileBoxY + 17)
    end
end

function submitButton(sx, sy)
    submitButtonH = 60; submitButtonW = 260
    submitButtonX = sx; submitButtonY = userBoxH + sy + 80
    if not submitButtonClicked then
        love.graphics.setColor(colors.lightGreen)
        love.graphics.rectangle("fill", submitButtonX + 2, submitButtonY + 2, submitButtonW, submitButtonH, 10)
    end
    love.graphics.setColor(colors.green)
    love.graphics.rectangle("fill", submitButtonX , submitButtonY, submitButtonW, submitButtonH, 10)
    love.graphics.setColor(colors.darkBlack)
    love.graphics.draw(submitText, submitButtonX + submitButtonW / 4, submitButtonY + 10)
    love.graphics.setColor(colors.green)
    love.graphics.draw(submitText, submitButtonX + submitButtonW / 4 + 2, submitButtonY + 10 + 2)
end