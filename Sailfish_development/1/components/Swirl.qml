/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt 5 launch demo.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0

ShaderEffect {
    id: shader

    width: 400
    height: 300

    property real speed: 1

    property color d: Qt.rgba(Math.random() * 0.7,
                              Math.random() * 0.5,
                              Math.random() * 0.7,
                              Math.random() * 0.5)
    property real tx
    NumberAnimation on tx { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real ty
    NumberAnimation on ty { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real tz
    NumberAnimation on tz { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real tw
    NumberAnimation on tw { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }

    property real amplitude: height / 2

    property variant colorTable: ShaderEffectSource { sourceItem: Rectangle { width: 4; height: 4; color: "green" } }

    fragmentShader: "
    uniform lowp float qt_Opacity;
    uniform lowp sampler2D colorTable;
    varying highp vec2 qt_TexCoord0;
    varying lowp float xx;

    void main() {
        gl_FragColor = texture2D(colorTable, qt_TexCoord0);
        gl_FragColor.xyz += xx * 0.1;
        gl_FragColor *= qt_Opacity;
    }
    "

    vertexShader: "
    uniform lowp vec4 d;
    uniform highp float tx;
    uniform highp float ty;
    uniform highp float tz;
    uniform highp float tw;
    uniform highp float amplitude;
    uniform highp mat4 qt_Matrix;
    attribute highp vec4 qt_Vertex;
    attribute highp vec2 qt_MultiTexCoord0;
    varying highp vec2 qt_TexCoord0;
    varying lowp float xx;
    void main() {
        highp vec4 pos = qt_Vertex;

        highp float y = sin(-tx       + d.x * qt_MultiTexCoord0.x * 57. + 12. * d.y)
                      + sin(ty * 2.0 + d.z * qt_MultiTexCoord0.x * 21. + 5. * d.w)
                      + sin(tz * 4.0 + d.y * qt_MultiTexCoord0.x * 13. + 7.0 * d.x)
                      + sin(-ty * 8.0 + d.w * qt_MultiTexCoord0.x * 29. + 15. * d.z);
        highp float x = sin(-tx       + d.x * qt_MultiTexCoord0.x * 213. + 15. * d.y)
                      + sin(ty * 2.0 + d.z * qt_MultiTexCoord0.x * 107. + 12. * d.w)
                      + sin(tz * 4.0 + d.y * qt_MultiTexCoord0.x * 13. + 5. * d.x)
                      + sin(-ty * 8.0 + d.w * qt_MultiTexCoord0.x * 15. + 7. * d.z);
        xx = x;

        pos.xy += vec2(x * sin(qt_MultiTexCoord0.x * 3.14152) * 0.3,
                       y * (1.0 - qt_MultiTexCoord0.y)) * amplitude;

        gl_Position = qt_Matrix * pos;
        qt_TexCoord0 = qt_MultiTexCoord0;
    }
    "

    mesh: GridMesh { resolution: Qt.size(width / 10, 4) }

}
