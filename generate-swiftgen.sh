#!/bin/sh

#  generate-swiftgen.sh
#  WeatherRxSwift
#
#  Created by Nischal Hada on 6/1/20.
#  Copyright © 2020 Nischal Hada. All rights reserved.
PROJECT_DIR="."
PODS_ROOT="$PROJECT_DIR/Pods"

${PODS_ROOT}/SwiftGen/bin/swiftgen
