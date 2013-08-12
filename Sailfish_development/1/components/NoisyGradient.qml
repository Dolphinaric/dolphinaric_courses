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

    id: effectRoot;

    width: 1280
    height: 720

    property Gradient gradient: Gradient {
        GradientStop { position: 0; color: "white" }
        GradientStop { position: 0.4; color: "blue" }
        GradientStop { position: 1.0; color: "black" }
    }

    Rectangle {
        id: colorTable
        width: 1
        height: 128;

        gradient: effectRoot.gradient;

        layer.enabled: true
        layer.smooth: true

        visible: false;
    }

    property variant source: colorTable;

    blending: false;

    fragmentShader:"
                #ifdef GL_ES
                precision lowp float;
                #endif

                uniform lowp sampler2D source;
                uniform lowp float qt_Opacity;
                varying highp vec2 qt_TexCoord0;

                // Noise function from: http://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl
                float rand(vec2 n) {
                    return 0.5 + 0.5 * fract(sin(dot(n.xy, vec2(12.9898, 78.233))) * 43758.5453);
                }

                void main() {
                    lowp float len = clamp(length(vec2(0.5, 0.0) - qt_TexCoord0), 0.0, 1.0);
                    gl_FragColor = texture2D(source, vec2(0, len)) * qt_Opacity + rand(qt_TexCoord0) * 0.05;
                }
"
}
