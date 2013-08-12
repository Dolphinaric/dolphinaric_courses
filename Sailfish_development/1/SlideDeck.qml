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
import QtGraphicalEffects 1.0
import Qt.labs.presentation 1.0
import "components"
import "slides"

Item {
    id: root
    width: 1280
    height: 720
    property bool haveColor: true

    NoisyGradient {
        anchors.fill: parent;
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#287F93" }
            GradientStop { position: 1.0; color: "black" }
        }
    }

    Rectangle {
        id: colorTable
        width: 1
        height: 46
        color: "transparent"

        Column {
            spacing: 2
            y: 1
            Rectangle { width: 1; height: 10; color: "white" }
            Rectangle { width: 1; height: 10; color: "#3CC0DD" }
            Rectangle { width: 1; height: 10; color: "#319FB7" }
            Rectangle { width: 1; height: 10; color: "#287F93" }
        }

        layer.enabled: true
        layer.smooth: true
        visible: false;
    }


    Swirl {
        x: 0;
        width: parent.width
        height: parent.height * 0.2
        anchors.bottom: parent.bottom;
        amplitude: height * 0.2;
        colorTable: colorTable;
        speed: 0.2;
        opacity: 0.3
    }

    TransitionPresentation {
        id: presentation
        titleColor: "white"
        textColor: "white"
        anchors.fill: parent
        transitionTime: 1000
        layer.enabled: true//parent.useDropShadow
        layer.effect: DropShadow {
            horizontalOffset: presentation.width * 0.005;
            verticalOffset: presentation.width * 0.005;
            radius: 16.0
            samples: 16
            fast: true
            color: Qt.rgba(0.0, 0.0, 0.0, 0.7);
        }

        Slide {
            centeredText: "Introduction to Qt and Sailfish OS"
            fontScale: 2
        }

        WhatIsQt {}

        QtInUse {}

        QtFeatures {}

        QtFeatureMultimedia {}

        QtFeatureWebKit {}

        QmlIntro {}

        QmlLiveCode {}

        WhatIsSailfish {}

        // Need eye candy slide

        // Technical slide, might skip
        SailfishStack {}

        SailfishQml {}

        Slide {
            centeredText: "Demonstration with the sailfish OS emulator"
        }

        Slide {
            centeredText: "Questions ?"
            fontScale: 2;
        }
    }
}
