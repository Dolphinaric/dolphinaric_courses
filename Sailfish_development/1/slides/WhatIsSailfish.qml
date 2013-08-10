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
    id: container
    title: "What is Sailfish OS"

    content: [
        "A platform developed by Jolla",
        " Jolla is a Start-up composed by ex-Nokians",
        " Based on the Mer project and Nemo mobile",
        " Mer is a Linux based core distribution",
        " Nemo mobile is a community distribution for mobile devices"
    ]

    contentWidth: width / 2 - 10

    Column  {
        anchors.top: parent.top
        anchors.right: parent.right

        Image {
            source: "../images/jolla-logo-1_0.png"
            height: container.height / 2.5
            sourceSize.height: container.height / 2.5
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Image {
            source: "../images/sailfish-logo.png"
            height: container.height / 2.5
            sourceSize.height: container.height / 2.5
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }
} 
