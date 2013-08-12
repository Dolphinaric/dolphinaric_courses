/*
 * Copyright (C) 2013 Lucien XU <sfietkonstantin@free.fr>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * The names of its contributors may not be used to endorse or promote
 *     products derived from this software without specific prior written
 *     permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.1

Rectangle {
    id: container
    property alias readOnly: code.readOnly
    property alias code: code.text
    property real fontSize: parent.baseFontSize / 2
    property alias textDocument: code.textDocument

    width: parent.width / 2 - 10
    anchors.top: parent.top
    anchors.right: parent.right
    height: Math.min(code.paintedHeight + 40, parent.height)
    color: "#287F93"

    Flickable {
        anchors.fill: parent
        anchors.margins: 20
        contentWidth: code.width
        contentHeight: code.height
        clip: true

        TextEdit {
            id: code
            text: container.text
            font.family: "Monospace"
            font.pixelSize: container.fontSize
            color: "white"
            onTextChanged: {
                var cursor = cursorPosition
                var tabsCount = 0
                var indexOfTab = text.indexOf("\t", 0)
                while (indexOfTab != -1) {
                    tabsCount ++
                    indexOfTab = text.indexOf("\t", indexOfTab + 2)
                }
                text = text.replace("\t", "    ")
                if (tabsCount > 0) {
                    cursorPosition = cursor + 3
                }
            }
        }
    }
}
