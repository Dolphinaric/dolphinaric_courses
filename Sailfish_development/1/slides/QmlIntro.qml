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

import QtQuick 2.0
import Qt.labs.presentation 1.0

Slide {
    id: slide
    title: "QML and Qt Quick"
    property string code: "import QtQuick 2.0

Rectangle {
    width: 640
    height: 480
    color: \"black\"

    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }

    Text {
        font.pixelSize: 25
        anchors.centerIn: parent
        text: \"Click me !\"
    }
}"

    content: [
        "QML is a declarative language",
        "Qt Quick is the Qt UI Creation Kit",
        " A way to create UI using QML",
        " Introduced in Qt 4.7",
        " Greatly improved in Qt 5.0",
        "This presentation is done with QML"
    ]
    contentWidth: width / 2 - 10

    Component.onCompleted: {
        var component
        if (root.haveColor) {
            component = Qt.createComponent(Qt.resolvedUrl("../components/ColoredCodeSection.qml"))
        } else {
            component = Qt.createComponent(Qt.resolvedUrl("../components/CodeSection.qml"))
        }
        if (component.status == Component.Ready) {
            component.createObject(slide, {readOnly: true, code: slide.code})
        }
    }
}
