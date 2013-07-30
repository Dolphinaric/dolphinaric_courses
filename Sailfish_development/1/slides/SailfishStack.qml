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
import "../components"

Slide {
    id: container
    title: "What's inside Sailfish OS"

    Rectangle {
        id: content
        anchors.fill: parent
        border.color: "black"
        border.width: 2

        Column {

            TableRow {
                color: "#C2CACC"
                baseFontSize: container.baseFontSize
                tableWidth: content.width
                height: content.height / 4
                model: ListModel {
                    ListElement { text: "User interface" }
                    ListElement { text: "Sailfish Silica" }
                    ListElement { text: "Input methods" }
                    ListElement { text: "Homescreen" }
                    ListElement { text: "Settings" }
                    ListElement { text: "Applications" }
                }
            }

            TableRow {
                color: "#B7C8CC"
                baseFontSize: container.baseFontSize
                tableWidth: content.width
                height: content.height / 4
                model: ListModel {
                    ListElement { text: "Nemo \nmiddleware" }
                    ListElement { text: "Tracker" }
                    ListElement { text: "Maliit" }
                    ListElement { text: "Lipstick" }
                    ListElement { text: "Grilo" }
                    ListElement { text: "Gecko" }
                    ListElement { text: "QML plugins" }
                }
            }

            TableRow {
                color: "#A2C1C8"
                baseFontSize: container.baseFontSize
                tableWidth: content.width
                height: content.height / 4
                model: ListModel {
                    ListElement { text: "Mer core OS" }
                    ListElement { text: "GStreamer" }
                    ListElement { text: "ConnMan" }
                    ListElement { text: "Qt 5" }
                    ListElement { text: "Ofono" }
                    ListElement { text: "Wayland" }
                    ListElement { text: "Pulse Audio" }
                }
            }

            TableRow {
                color: "#91BEC8"
                baseFontSize: container.baseFontSize
                tableWidth: content.width
                height: content.height / 4
                model: ListModel {
                    ListElement { text: "Hardware \nadaptation" }
                    ListElement { text: "x86" }
                    ListElement { text: "Armv7hl" }
                    ListElement { text: "Armv7l" }
                    ListElement { text: "..." }
                }
            }
        }
    }
} 
