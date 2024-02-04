//
//  CXXModel.cpp
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

#include "CXXModel.h"

std::string CXXModel::getText() {
    std::string baseText = "Hi from C++!";
    std::string additionalText = CXXAdditionalModel().getAdditionalText();
    return baseText + " " + additionalText;
}
